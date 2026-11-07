# ULTRON: COLOSSAL AWAKENING VR — Jarvis, enjambre guía y audio personalizado

Proyecto **HTML + Three.js r160 + WebXR**, listo para publicar como **sitio estático en GitHub y Render**. Conserva jetpack, controles VR/PC, cuatro armas y turbinas ARC, cinemáticas, impactos y música original.

## Novedad: los dos diálogos de Jarvis y el enjambre guía

El diseño de los diálogos procede del sistema de notificaciones flotantes de `index (5).html`, adaptado al entorno WebXR. Los cuadros aparecen dentro de la vista VR y también en escritorio, con fondo oscuro, contorno cian, animación de entrada/salida y escritura progresiva. El nombre **TecGPT** se sustituyó por **Jarvis**.

- **Al iniciar la experiencia** (botón INICIAR / entrada en VR): Jarvis reproduce el MP3 suministrado y muestra: **Jarvis: «Boss, sigue el enjambre de partículas. Te dirá adónde ir.»**
- **Guía dinámica**: 96 partículas brillantes de color cian/ámbar fluyen desde la posición actual del jugador hacia el jetpack. Se renderizan en un solo `THREE.Points` con ShaderMaterial, sin una actualización individual de partículas por CPU, y desaparecen al recogerlo. Al reiniciar, reaparecen.
- **Al recoger el jetpack**: el segundo MP3 reproduce **Jarvis: «Boss, con el Jetpack, ahora puedes volar con el gatillo secundario izquierdo.»**; sustituye inmediatamente la indicación anterior si aún está en pantalla.
- Se convirtieron ambos audios `.m4a` originales a `.mp3` para mejorar su compatibilidad con el navegador integrado de los visores, y se incluyeron en `public/` con nombres legibles, sin el sufijo `(1)`.
- Como los navegadores VR pueden bloquear el audio automático, el primer diálogo se inicia al pulsar **INICIAR EXPERIENCIA / ENTER VR** o al entrar en una sesión WebXR (solo una vez). Los subtítulos se muestran aunque el audio no pueda reproducirse.
- La segunda indicación comienza inmediatamente tras recoger el jetpack, pero el resto de sonidos existentes (StartingUp, robot_encendido, RobotStep, disparos y ambiente) se conserva.

## Novedad: sonidos de disparo reemplazados

- **Disparos del protagonista:** exclusivamente `public/shot_comprimido.mp3`, suministrado por el usuario. Se eliminó el antiguo MP3 remoto de disparo y el oscilador Web Audio que se sumaba al sonido.
- **Disparos de Ultron:** exclusivamente `public/power-beam-sound-effect.mp3`, suministrado por el usuario. Se reproduce cuando el jefe **lanza el proyectil**, no durante su carga; se retiró el sonido anterior `ice-beam` y la reproducción prematura del `power-beam` durante la carga.
- El método auxiliar de cañón también usa el mismo MP3 de Ultron, sin ondas sintéticas añadidas.
- Un grupo reutilizable de hasta 8 voces para el protagonista y 2 para Ultron evita crear indefinidamente reproductores HTMLAudio cuando se dispara repetidamente.
- Se **conservan** música, ambiente de lluvia, rugido y encendido, sonido de pisadas, impactos y demás efectos no relacionados con el disparo.

## Novedad: temblor de cada pisada recuperado del visor 3D original

- **Sacudida mecánica de armadura (`armorJolt`)**: cuando la bota toca el suelo, las piezas del Ultron vibran con una oscilación de 38 rad/s y decaimiento amortiguado. Las piezas más cercanas al suelo reciben un multiplicador de 1,95; las altas vibran menos. Se respetan las posiciones originales de cada pieza para evitar acumulación de errores.
- **Sacudida global del chasis**: durante 0,50 segundos la estructura tiene un ligero hundimiento vertical, desplazamiento lateral y balanceo; la interpolación reutiliza los parámetros de la animación de marcha existente, sin modificar controles ni colisiones.
- **Doble onda expansiva**: al impacto aparece un anillo mecánico cálido y un segundo anillo tenue de agua que se expande sobre el **suelo negro**. Son reutilizables y se desactivan automáticamente, también durante el colapso final.
- **Sin movimiento artificial de cabeza en WebXR**: al pisar se conserva la háptica en mandos y el sonido `RobotStep.mp3`; la cámara de escritorio mantiene su vibración suave. En Quest se evita forzar desplazamientos de cámara que puedan marear.
- **Ubicación física**: las ondas se colocan según la orientación actual del gigante, de modo que no queden desplazadas si gira hacia el jugador.
- Configuración interna: el objeto `FOOTSTEP_TREMOR` en `public/index.html` permite ajustar amplitud, cercanía al suelo, frecuencia y duración. Los valores iniciales proceden de `visor_3d_interactivo_ultron_prestige-2(2).html`.

## Cambios de la edición anterior que se conservan

- **Ultron 50 % más grande:** escala 75.0 en vez de 50.0, altura teórica de **562,5 m** en vez de ~375 m. Adaptados el encendido vertical, luces, sombras de contacto, pisadas y techo de vuelo (650 m).
- **Suelo negro absoluto:** material sin texturas (`#000000`), sin mapas de relieve ni rugosidad, sin reflejos, sombras proyectadas o efecto de niebla sobre su superficie. Los círculos de lluvia siguen visibles porque son un efecto independiente.
- **Gotas convertidas en círculos expansivos:** 260 anillos de lluvia en Quest 3, 150 en Quest Pro; nacen y se expanden sobre el suelo **mediante un único lote de geometría instanciada y shader GPU**. Comienzan desde el inicio de la partida y siguen al jugador.
- **Descarga de proximidad:** si se entra en el campo eléctrico del robot mientras está activo, se reciben **20 puntos de daño** y un **empuje horizontal** (con ligero impulso vertical). Intervalo mínimo de 2,3 segundos entre descargas; aparecen chispas y alerta de HUD. No se aplica después de derrotar al robot.
- **Relámpagos previos a la activación:** la tormenta y sus rayos nube-tierra aparecen antes de recoger el jetpack y siguen durante el combate. Se mantienen rayos fractales agrupados en instancias.
- **Niebla azul y armadura oscurecidas:** menor intensidad azul en atmósfera, luces de contorno y nubes; armaduras metálicas más oscuras sin alterar los colores identificativos de las turbinas ARC.
- **Nueva secuencia de despertar:** al recoger el jetpack se escucha primero el antiguo `public/StartingUp.mp3` (más el rugido grave original sintetizado); **cuando termina** comienza el nuevo `public/robot_encendido.mp3` (23,04 s). La iluminación progresiva dura 25 segundos para sincronizarse con ambos sonidos antes de caminar. `public/RobotStep.mp3` sigue sonando en cada pisada. Todos los sonidos están incluidos localmente, sin depender de URL externa.
- Mantiene las optimizaciones anteriores de PBR, `InstancedMesh` para nubes y rayos, piscina de humo, perfiles de Quest y correcciones del shader.

## Estructura del repositorio

```text
ultron_colossal_visual_optimized/
├── public/
│   ├── index.html
│   ├── StartingUp.mp3
│   ├── robot_encendido.mp3
│   ├── RobotStep.mp3
│   ├── shot_comprimido.mp3
│   ├── power-beam-sound-effect.mp3
│   ├── Jarvis_Boss_sigue_el_enjambre_de_particulas_te_dira_adonde_ir.mp3
│   └── Jarvis_Boss_con_el_jetpack_ahora_puedes_volar_con_el_gatillo_secundario_izquierdo.mp3
├── render.yaml
├── README.md
└── .gitignore
```

**Es importante subir los SIETE MP3 dentro de `public/` junto con `index.html`.** Si solo se sustituye el HTML, faltarán efectos de disparo, encendido y pisadas.

## Subir a GitHub y Render

1. Descomprime el ZIP y sube a la raíz del repositorio **el contenido de la carpeta descomprimida** (no el ZIP ni una carpeta extra alrededor del proyecto).
2. En Render selecciona **New → Static Site** con **Build Command:** `echo "Sitio HTML estatico: no requiere compilacion"` y **Publish Directory:** `public`; también puedes utilizar el `render.yaml` incluido.
3. Desde el navegador de Quest abre la dirección HTTPS que ofrece Render e inicia la experiencia.
4. Selecciona en el menú **Quest 3 — detalle alto** o **Quest Pro — equilibrado**. El modo automático es orientativo; puedes elegir manualmente.

Solo la música de fondo continúa usando su URL externa original. **Los siete MP3 de disparos, despertar, pisadas y Jarvis se incluyen localmente.**

## Comprobaciones y límites

- Sintaxis JavaScript de módulo validada con Node.js; integridad del ZIP y presencia de los audios comprobadas. No se ha probado el resultado visual ni la tasa de fotogramas en los visores físicos.
- Los efectos de círculos, nubes y relámpagos se han programado para ejecutarse principalmente en GPU. En visores VR **los FPS y la compatibilidad visual deben comprobarse físicamente**, especialmente el renderizado WebXR y los materiales.
- Para investigar la tasa de FPS o las llamadas de dibujo, añade `?debug=1` a la URL (vista de diagnóstico en pantalla cuando el navegador la exponga).
- Se recomienda HTTPS para WebXR y conexión a Internet para Three.js y otros recursos CDN que ya existían.
