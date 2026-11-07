# ULTRON: COLOSSAL AWAKENING VR — Jarvis y contraseña del jetpack

Proyecto HTML / Three.js / WebXR para Meta Quest 3, Meta Quest Pro y navegador de escritorio. Continúa la edición anterior con Ultron de 562,5 m, suelo completamente negro, ondas circulares de lluvia, rayos de tormenta anteriores al encendido, pisadas con temblor, descarga de proximidad, armas ARC y efectos gráficos optimizados.

## Misiones y voces de Jarvis

Los diálogos aparecen como cuadros flotantes con texto progresivo y reproducen los audios MP3 incluidos en la carpeta `public`. Las intervenciones de combate son de **una sola reproducción por partida** y se administran en cola para no superponer las voces. Los avisos de contraseña, derrota y victoria tienen prioridad.

| Momento | Texto de Jarvis |
|---|---|
| Al entrar al juego | «Boss, sigue el enjambre de partículas. Te dirá adónde ir.» |
| Al llegar al jetpack | «Coloca el password que descubrimos en el taller tres de Desarrollo Móvil.» |
| Tras introducir la contraseña válida | «Boss, con el jetpack ahora puedes volar con el gatillo secundario izquierdo.» |
| Al volar cerca de las turbinas | «Mira el color de las turbinas. Aprovecha las debilidades que aprendimos en el taller uno de Ciberseguridad.» |
| Al apuntar y disparar hacia una turbina o impactarla | «No olvides que puedes cambiar de arma con el joystick derecho.» |
| Tras avanzar el jefe durante la batalla | «¡Ya casi llega a Hermosillo! ¡Tienes que detenerlo!» |
| Al perder toda la vida | «¡Boss, estás ahí! ¡Responde, responde, Boss!» |
| Al derrotar a Ultron | «¡Boss, lo conseguiste! ¡Eres una leyenda!» |

## Jetpack: clave 1122

Al alcanzar el jetpack aparece un **teclado numérico virtual en VR**. Apunta a los números con cualquiera de los mandos, pulsa el gatillo para seleccionar `1`, `1`, `2`, `2` y después `OK`. Hay botones `BORRAR` y una señal luminosa que muestra hacia dónde apuntas. Hasta introducir la clave correcta no se puede equipar ni iniciar el despertar de Ultron.

En escritorio aparece un formulario donde se escribe `1122` y se pulsa **DESBLOQUEAR JETPACK** o Enter. El sonido de vuelo de Jarvis se reproduce **después** de desbloquearlo. Con una clave incorrecta puede volver a intentarse sin perder progreso.

## Escena inicial ampliada

El jugador comienza ahora a unos **186 metros del jetpack**, en lugar de unos 20 metros. La velocidad de caminar durante la fase anterior al jetpack se ha ajustado a **13,5 m/s**, por lo que el desplazamiento frontal directo dura aproximadamente **14 segundos**. Se conservan los controles y la velocidad de vuelo de la versión anterior.

El enjambre contiene ahora **160 partículas**, se anima en GPU en una única llamada de dibujo y se adapta constantemente a la posición del jugador. Desaparece después del desbloqueo y reaparece al reiniciar.

## Despliegue GitHub / Render

1. Extrae el ZIP y sube **el contenido** del directorio del proyecto a la raíz del repositorio; verifica que exista `public/index.html`.
2. En Render usa **Static Site**, `Publish Directory: public` y `Build Command: echo "Sitio HTML estatico: no requiere compilacion"`. También puede utilizarse `render.yaml`.
3. Sube **todos los 14 MP3 de `public/`** junto con `index.html` (8 diálogos Jarvis más 6 efectos grabados: disparos del jugador, disparos de Ultron, rugido, encendido, pisadas y jetpack).
4. En Quest abre la URL HTTPS desde el navegador WebXR y selecciona la calidad correspondiente al visor.

La música de fondo permanece en su URL externa original. Three.js y los demás recursos CDN aún requieren conexión a Internet.

## Verificación y límites

Se validaron la sintaxis JavaScript, las rutas de los 13 audios, su decodificación con `ffprobe`, el flujo de contraseña y la estructura del paquete. **No se ha probado físicamente en Meta Quest 3 o Quest Pro**, así que la interacción con los mandos, la visibilidad del teclado y el rendimiento deberán confirmarse en el visor.

## Actualización: jetpack grabado y huella exacta

- El **jetpack** usa exclusivamente `public/jetpack_ligero.mp3`, que se reproduce
  en bucle solo mientras el jugador mantiene la propulsión. Se pausa al soltar
  el control, al morir, al ganar, al reiniciar y al salir de VR.
- Se retiró toda **síntesis de audio del juego** (osciladores de motor, lluvia,
  trueno, ricochets, explosiones, rugido de acordes y efectos procedurales).
  Permanecen los archivos MP3 del jugador, Ultron, Jarvis, pisadas y música.
  Los eventos para los que no se proporcionó un audio grabado quedan sin
  sonido adicional; sus efectos visuales se conservan.
- Los anillos de impacto se centran bajo **marcadores unidos a las suelas de
  las botas animadas**, usando sus posiciones mundiales reales y proyectando
  el resultado al suelo negro. El choque de la caída final se centra debajo
  del torso y el impacto de rodilla en el pie correspondiente.
- El clip `jetpack_ligero.mp3` dura aproximadamente 0,91 s; por diseño se
  repite mientras el propulsor está encendido.
- Verificar las transiciones de reproducción y precisión del impacto en
  Meta Quest Pro y Quest 3 antes de publicar la versión definitiva.
