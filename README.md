# ULTRON: COLOSSAL AWAKENING VR — Visual Optimized Edition

Versión mejorada para **Meta Quest 3** y **Meta Quest Pro** usando HTML + Three.js r160 + WebGL/WebXR. Mantiene intactas las mecánicas, cuatro armas/turbinas ARC, controles, jetpack, cinemáticas de Ultron y sonidos existentes. **No se han añadido dependencias de compilación.**

## Archivos para Render y GitHub

```text
ultron_colossal_visual_optimized/
├── public/
│   └── index.html
├── render.yaml
├── README.md
└── .gitignore
```

1. Crea un repositorio de GitHub o utiliza el que ya tienes.
2. Sube **la carpeta `public/` y los archivos de la raíz**, no el ZIP como archivo único.
3. En Render, configura **New → Static Site**, con **Build Command** `echo "Sitio HTML estatico: no requiere compilacion"` y **Publish Directory** `public`. Alternativamente utiliza `render.yaml` como Blueprint.
4. Abre la URL HTTPS del sitio en Meta Quest Browser y pulsa «Iniciar experiencia / Enter VR».

## Mejoras visuales realizadas

- **Armadura PBR**: rugosidad y normal maps procedurales compartidos para metal cepillado y microarañazos (sin geometría adicional).
- **Suelo mojado**: textura procedural de charcos y microrrelieve, más sombras suaves de contacto bajo las botas (sin costosas shadow maps).
- **Nubes**: cambiadas de 48 mallas/materiales a **3 lotes de instancias**, que reducen draw calls.
- **Rayos de la mano**: 120 segmentos convertidos en **2 `InstancedMesh`**, manteniendo su animación fractal.
- **Relámpagos de tormenta**: sus segmentos se agrupan en un `InstancedMesh` por relámpago activo.
- **Humo**: columna y explosiones usan un pool reutilizable de **192 instancias**, con opacidad individual en shader, evitando crear y destruir materiales en cada emisión.
- **Salpicaduras en suelo**: ondas pequeñas cerca del jugador mediante **un shader de puntos** y un solo lote de dibujo.
- **Shader de encendido**: normalizadas las operaciones `smoothstep` con límites previamente invertidos para evitar resultados GLSL indefinidos.
- **Limpieza de VFX**: eliminación segura de recursos temporales de relámpagos, explosiones y marcador al reiniciar.
- **Configuración WebXR**: factor de framebuffer, foveación (cuando sea compatible) y presupuestos gráficos diferentes para Quest 3 / Quest Pro.

## Perfiles gráficos

En el menú principal aparece una selección de calidad:

| Modo | Buffer XR relativo | Foveación inicial | Densidad relativa nubes/lluvia |
| --- | ---: | ---: | ---: |
| Quest 3 — alto | 0.98 | 0.40 | 100 % |
| Quest Pro — equilibrado | 0.85 | 0.65 | 72 % / 74 % |

El modo «Automático» usa el identificador del navegador **solo como pista**, no como comprobación de características WebXR. Si lo detecta mal, elige el modo manualmente antes de iniciar VR. También puedes forzar el perfil desde la dirección: `?graphics=quest3` o `?graphics=questpro`.

Para una vista de diagnóstico en la pantalla del PC, usa `?debug=1` (añade FPS, draw calls, triángulos y puntos, basado en `renderer.info`). Este indicador no sustituye mediciones de GPU dentro del visor.

## Compatibilidad y limitaciones

- El código mantiene su Three.js **0.160.0** y bibliotecas de CDN tal como en el proyecto original. Necesita Internet para descargar librerías y audios MP3 alojados externamente.
- La foveación y otros ajustes XR dependen del soporte de la versión de Meta Quest Browser. Los niveles configurados son puntos de partida, no valores de rendimiento certificados.
- Se verificó la **sintaxis JavaScript con Node.js** y la estructura de los archivos. **No se pudo ejecutar ni medir físicamente en Meta Quest 3 / Quest Pro en este entorno**, por lo que se recomienda probar ambos perfiles en los visores.
- Si ocurre un bajón de FPS, empezar por Quest Pro (equilibrado) y medir draw calls / GPU antes de añadir más efectos.

## Actualizar el juego

Para reemplazar la versión anterior, conserva la ruta exacta `public/index.html`, realiza commit/push y deja que Render vuelva a desplegar el sitio estático. En pruebas locales utiliza un servidor HTTP; para WebXR real es necesario HTTPS o un contexto seguro admitido.
