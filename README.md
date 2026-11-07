# ULTRON — BATALLA FINAL CODEXIA (registro verificado)

Esta edición conserva los **15 MP3**, Jetpack 1122, Jarvis, menú mínimo, enjambre ondulante, tormenta, pisadas, cuatro armas y turbinas, cronómetro y calificación. Corrige el registro de **Batalla final** sin modificar la función de los talleres 1–4.

## OBLIGATORIO: instalar una función en Supabase

Antes de desplegar esta versión, abre tu proyecto **codexia-scores** en Supabase y ve a **SQL Editor**. Copia y ejecuta **`SQL/01_REGISTRAR_BATALLA_FINAL.sql`**. Este archivo crea la RPC `public.registrar_batalla_final(integer, numeric)` con permiso para `anon`.

La función escribe **solo `batalla_final` y, si corresponde, el `total`**. Respeta las notas existentes de `taller_1` a `taller_4`, mantiene la mejor nota por equipo y devuelve el valor guardado para que el juego pueda comprobarlo. Soporta equipos 1–20 y notas 0–100. No contiene notas de prueba ni hace ninguna escritura de puntuaciones hasta que un juego real invoque la función.

**Nota importante:** el SQL presupone que `public.scores` tiene las columnas `equipo` (única/PK), `taller_1`, `taller_2`, `taller_3`, `taller_4`, `batalla_final`, `total`; coincide con la tabla mostrada. Si tu estructura real difiere, revisa el SQL antes de ejecutarlo.

## Actualizar el juego

Extrae el ZIP. Sube **su contenido** a GitHub, conservando la carpeta `public/` y todos los MP3. Render debe publicar `public`. Desde el siguiente despliegue, el juego envía `POST /rest/v1/rpc/registrar_batalla_final` con `p_equipo` y `p_puntaje`; ya no depende de `p_taller = 5`.

## Qué significa el estado mostrado

- **ENVIANDO A CODEXIA:** todavía no hay confirmación.
- **GUARDADO EN CODEXIA: N / 100:** la función SQL devolvió la nota real almacenada. `N` puede superar la última nota si el equipo ya tenía una mejor (regla del máximo).
- **NO GUARDADO:** problema de red, de función SQL o permisos. Aparece el motivo debajo del mensaje; en PC, **R** reintenta; en VR, dispara al mensaje del panel.

Los resultados pendientes se conservan en el **almacenamiento local de ese navegador** y se reintentan al recargar el juego o recuperar la conexión. No se recuperan automáticamente puntuaciones de versiones anteriores que no guardaron datos localmente.

## Seguridad

Se conserva la clave **publishable** pública provista por el proyecto. No se incluyen claves secretas. Sin cuentas y sin servidor que valide las partidas, el sistema permite que terceros envíen notas simuladas: para una competición con resultados confiables se necesita validación de servidor.

## Comprobaciones y límites

Se verifican localmente sintaxis JavaScript, rutas de archivos, función de envío y respuesta simulada; no se ha ejecutado la función en tu Supabase ni se han escrito puntuaciones reales. Debes ejecutar el SQL y confirmar una partida real en el portal. En Meta Quest 3/Pro el resultado visual/VR requiere prueba física.

## Ajustes de interfaz (7 de noviembre de 2026)

- Portada simplificada: el botón de inicio muestra **ENTER** en lugar de la flecha. La acción de entrada a WebXR permanece igual.
- Barra de vida y cronómetro subidos ligeramente: 12–16 px en la interfaz de escritorio y 6 cm en el panel 3D del visor.
- Se mantiene el registro de Batalla Final CODEXIA, el selector de equipo y todos los archivos MP3 originales.
