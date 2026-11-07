# ULTRON: COLOSSAL AWAKENING VR — Tormenta y descarga (Quest 3 / Quest Pro)

Proyecto **HTML + Three.js r160 + WebXR**, listo para publicar como **sitio estático en GitHub y Render**. Conserva jetpack, controles VR/PC, cuatro armas y turbinas ARC, cinemáticas, impactos y música original.

## Cambios de esta edición

- **Ultron 50 % más grande:** escala 75.0 en vez de 50.0, altura teórica de **562,5 m** en vez de ~375 m. Adaptados el encendido vertical, luces, sombras de contacto, pisadas y techo de vuelo (650 m).
- **Suelo negro:** aspecto casi negro (`#020203`) con microrrelieve discreto, sin reflejos intensos que aclaren el terreno.
- **Gotas convertidas en círculos expansivos:** 260 anillos de lluvia en Quest 3, 150 en Quest Pro; nacen y se expanden sobre el suelo **mediante un único lote de geometría instanciada y shader GPU**. Comienzan desde el inicio de la partida y siguen al jugador.
- **Descarga de proximidad:** si se entra en el campo eléctrico del robot mientras está activo, se reciben **20 puntos de daño** y un **empuje horizontal** (con ligero impulso vertical). Intervalo mínimo de 2,3 segundos entre descargas; aparecen chispas y alerta de HUD. No se aplica después de derrotar al robot.
- **Relámpagos previos a la activación:** la tormenta y sus rayos nube-tierra aparecen antes de recoger el jetpack y siguen durante el combate. Se mantienen rayos fractales agrupados en instancias.
- **Niebla azul y armadura oscurecidas:** menor intensidad azul en atmósfera, luces de contorno y nubes; armaduras metálicas más oscuras sin alterar los colores identificativos de las turbinas ARC.
- **Sonidos aportados, sin números:** `public/StartingUp.mp3` (se reproduce al tomar el jetpack e iniciar el encendido) y `public/RobotStep.mp3` (se reproduce en **cada pisada registrada** por la animación). `StartingUp(2).m4a` se convirtió a MP3 para reproducción sencilla por WebXR; `RobotStep(1).mp3` se copió con el nuevo nombre. Ambos **están incluidos localmente**, sin depender de URL externa.
- Mantiene las optimizaciones anteriores de PBR, `InstancedMesh` para nubes y rayos, piscina de humo, perfiles de Quest y correcciones del shader.

## Estructura del repositorio

```text
ultron_colossal_visual_optimized/
├── public/
│   ├── index.html
│   ├── StartingUp.mp3
│   └── RobotStep.mp3
├── render.yaml
├── README.md
└── .gitignore
```

**Es importante subir los DOS MP3 dentro de `public/` junto con `index.html`**. Si solo se sustituye el HTML, los sonidos nuevos no funcionarán.

## Subir a GitHub y Render

1. Descomprime el ZIP y sube a la raíz del repositorio **el contenido de la carpeta descomprimida** (no el ZIP ni una carpeta extra alrededor del proyecto).
2. En Render selecciona **New → Static Site** con **Build Command:** `echo "Sitio HTML estatico: no requiere compilacion"` y **Publish Directory:** `public`; también puedes utilizar el `render.yaml` incluido.
3. Desde el navegador de Quest abre la dirección HTTPS que ofrece Render e inicia la experiencia.
4. Selecciona en el menú **Quest 3 — detalle alto** o **Quest Pro — equilibrado**. El modo automático es orientativo; puedes elegir manualmente.

Los cuatro audios originales del repositorio externo siguen dependiendo de sus URLs preexistentes. **Los dos audios nuevos viajan dentro del proyecto**.

## Comprobaciones y límites

- Sintaxis JavaScript de módulo validada con Node.js; archivos del proyecto y decodificación de los audios comprobados.
- Los efectos de círculos, nubes y relámpagos se han programado para ejecutarse principalmente en GPU. En visores VR **los FPS y la compatibilidad visual deben comprobarse físicamente**, especialmente el renderizado WebXR y los materiales.
- Para investigar la tasa de FPS o las llamadas de dibujo, añade `?debug=1` a la URL (vista de diagnóstico en pantalla cuando el navegador la exponga).
- Se recomienda HTTPS para WebXR y conexión a Internet para Three.js y otros recursos CDN que ya existían.
