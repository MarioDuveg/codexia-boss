# ULTRON: COLOSSAL AWAKENING VR

Juego HTML/WebGL/WebXR listo para publicarse en **GitHub + Render** como **sitio estático**.

## Estructura

```text
ultron-colossal-awakening-vr/
├── public/
│   └── index.html    # Juego completo, mismo contenido que el HTML entregado
├── render.yaml       # Configuración opcional para Render Blueprint
├── .gitignore
└── README.md
```

## Paso 1: subirlo a GitHub

1. Descomprime `ultron_colossal_render_github.zip` en tu computadora.
2. Crea un repositorio nuevo en https://github.com/new (por ejemplo, `ultron-colossal-vr`).
3. Dentro del repositorio, elige **Add file → Upload files**.
4. Sube **el contenido descomprimido** (la carpeta `public` y los archivos `render.yaml`, `README.md` y `.gitignore`). **No subas el ZIP como un solo archivo.**
5. Guarda los cambios con **Commit changes**.

> Comprueba que GitHub muestre `public/index.html` y `render.yaml` en las rutas indicadas.

## Paso 2: desplegar en Render (método sencillo)

1. Ve a https://dashboard.render.com/ y conecta tu cuenta de GitHub si hace falta.
2. Pulsa **New → Static Site**.
3. Selecciona el repositorio que acabas de crear.
4. Usa estos valores:

   - **Build Command:** `echo "Sitio HTML estatico: no requiere compilacion"`
   - **Publish Directory:** `public`
   - **Branch:** `main` (o el nombre real de tu rama principal)

5. Selecciona **Create Static Site / Deploy**.
6. Abre la dirección `https://<nombre-asignado>.onrender.com` que te muestre Render cuando termine la publicación.

**Alternativa:** si prefieres **New → Blueprint**, el archivo `render.yaml` ya incluye la configuración del sitio estático.

## Cómo actualizar el juego

Sustituye `public/index.html` por una versión nueva, conserva ese nombre y haz *commit/push* a la misma rama. Render puede redesplegar automáticamente los cambios del repositorio conectado.

## Sobre el juego y sus dependencias

- No requiere `package.json`, `npm install`, servidor Express ni variables de entorno.
- Three.js v0.160.0 se carga desde jsDelivr; Tailwind CSS y las fuentes desde sus respectivos CDN.
- El HTML **mantiene intactos** los enlaces originales de los cuatro MP3 alojados en `raw.githubusercontent.com/MarioDuran/VariableOverload`. El ZIP **no** contiene esos archivos de audio. Si sus enlaces dejan de funcionar o bloquean el acceso, el sonido correspondiente podría faltar.
- Para la experiencia VR necesitas navegador/dispositivo compatible con **WebXR**; para PC se usa WebGL. Render proporciona acceso vía HTTPS, requerido por WebXR en entornos normales.
- Se requiere conexión a Internet para las librerías, fuentes y recursos de audio externos.
- Este ZIP prepara el despliegue, pero no verifica que todos los recursos externos estén disponibles ni que el hardware admita VR.

## Prueba local rápida (opcional)

Desde el directorio descomprimido, ejecuta:

```bash
python -m http.server 8000 --directory public
```

Abre http://localhost:8000/ en el navegador. Puedes comprobar la versión PC antes de desplegar.
