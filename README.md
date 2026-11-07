# ULTRON: COLOSSAL AWAKENING VR — Batalla final CODEXIA

Juego WebGL/WebXR en un sitio estático, preparado para **Meta Quest 3**, **Meta Quest Pro** y navegador de escritorio. Conserva los audios originales, Jarvis, contraseña del jetpack (`1122`), tormenta, partículas guía, pisadas y descargas.

## Cambios de esta edición

**Pantalla inicial mínima:** muestra exclusivamente **BATALLA FINAL**, **SELECCIONAR EQUIPO** con botones **− / +** y una **flecha hacia abajo** para entrar en la partida/VR. Se retiraron del inicio las instrucciones, leyendas, etiquetas de turbinas y el selector gráfico. El perfil WebXR se decide automáticamente (Quest 3/Quest Pro) y, si se necesita, aún se puede forzar desde la URL usando `?graphics=quest3` o `?graphics=questpro`. La flecha utiliza internamente el inicio de sesión WebXR cuando el navegador lo permite.

**Selección de equipo antes de iniciar:** se elige entre los equipos **1 y 20**. El enjambre de partículas de Jarvis aparece solo después de usar la flecha. Al reiniciar desde un ordenador se vuelve al selector; durante una misma sesión inmersiva se conserva el equipo.

**Enjambre ondulante:** las **160 partículas GPU** ahora forman una trayectoria con amplias ondulaciones laterales y verticales y destellos que avanzan desde el jugador hacia el jetpack. La guía continúa siguiendo la posición del usuario y deja de mostrarse cuando se equipa el jetpack. Se conserva un solo draw call de partículas.

**Armas y turbinas:** cuatro colores de pistola: **amarillo, verde, rojo, azul**. Solo funciona la siguiente relación:

| Pistola | Turbina vulnerable |
|---|---|
| Amarilla | Roja |
| Roja | Verde |
| Verde | Azul |
| Azul | Amarilla |

Los disparos de color incorrecto hacen **0 de daño** a la turbina. Cada turbina pasó de 300 a **900 puntos de vida** (triple resistencia). La salud global de Ultron no se presenta en el HUD.

**Cronómetro:** **4:00**, sobre la vida del jugador, tanto en PC como en VR. Comienza **al tomar y desbloquear el jetpack**, justo cuando se inicia el despertar de Ultron, e incluye la cinemática. Si llega a **00:00** sin destruir las cuatro turbinas, la ronda termina. Si se destruye la cuarta turbina antes del límite, se detiene el contador y se registra la victoria en ese instante, aunque la animación de caída continúe.

## Calificación final de 0 a 100

Para una victoria dentro del límite:

- **40 % precisión:** impactos del color correcto en turbinas / total de disparos del jugador **desde que empieza el despertar**. Los disparos fallidos, los ataques a los orbes y los colores equivocados no cuentan como aciertos.
- **35 % vida conservada:** `max(0, 1 − daño_recibido / 100)`. El daño recibido se acumula durante la batalla.
- **25 % rapidez:** `max(0, 1 − segundos_transcurridos / 240)`.

Se redondea al entero más cercano, entre **0 y 100**. En caso de derrota por daño o tiempo, la calificación del intento es **0**. El resultado muestra el equipo, nota, precisión, daño, tiempo y estado de publicación.

## Publicación automática a CODEXIA (Supabase)

**Proyecto:** `codexia-scores`  
**URL:** `https://zgpfcmvjmjfaphtudmis.supabase.co`  
**Tabla:** `public.scores`  
**RPC:** `public.registrar_taller(integer, integer, numeric)`  
**Identificador de Batalla final:** `p_taller = 5` (asumimos talleres 1–4 y batalla final 5).

Al **destruir la cuarta turbina**, **morir** o **agotar el tiempo**, se hace automáticamente **un solo POST por intento** a:

`/rest/v1/rpc/registrar_taller`

con cuerpo:

```json
{"p_equipo":7,"p_taller":5,"p_puntaje":95}
```

El ejemplo anterior ilustra el formato; **el paquete NO envía notas de prueba**. En la partida se envían los valores reales. La clave pública `sb_publishable_...` está integrada en el HTML, como se solicitó; no se guarda ninguna clave secreta.

**REQUISITO en Supabase:** la función `registrar_taller` debe aceptar el identificador **5** y tener permiso `EXECUTE` para el rol `anon`. Debe actualizar la columna `batalla_final` y guardar el mejor resultado (máximo), además de aplicar sus políticas de inserción/RLS correspondientes. El navegador debe poder realizar las llamadas CORS.

El HUD final muestra **«GUARDADO EN CODEXIA»** solo cuando el servicio responde sin error. Si falla, aparece el error de envío: en PC pulsa **R** para reintentar; en VR apunta y dispara al **mensaje de error** en el panel final. No se necesita login; este mecanismo por sí solo no impide que usuarios externos falsifiquen puntuaciones (según el diseño proporcionado).

## Desplegar en GitHub + Render

1. Extrae el ZIP y abre la carpeta raíz (contiene `public/`, `render.yaml`, `README.md`, `.gitignore`).
2. Sube **el contenido de la carpeta** al repositorio GitHub. No subas el ZIP sin descomprimir.
3. En Render crea o actualiza un **Static Site** usando `public` como directorio de publicación. El `render.yaml` suministrado también permite el despliegue como Blueprint.
4. Abre la URL HTTPS publicada desde el navegador Meta Quest o de escritorio. Se necesita Internet para Three.js, fuentes, soundtrack y Supabase.

Los **15 MP3** de voces y efectos se alojan localmente en `public/`; no los elimines al publicar.

## Pruebas y límites de validación

- Se ha comprobado la **sintaxis ECMAScript** y que existen las referencias requeridas.
- Se verificaron localmente con pruebas simuladas los límites de equipo, cálculo de notas, formato del POST, tiempo congelado al ganar, ausencia de duplicados y tratamiento de errores HTTP.
- El **envío real a Supabase** no se ha probado ni se ha escrito ninguna nota en la base de datos: debe comprobarse con el proyecto configurado, permisos `anon` y `p_taller = 5`.
- El comportamiento, legibilidad y rendimiento de WebXR requieren una prueba real en Quest 3 y Quest Pro.
