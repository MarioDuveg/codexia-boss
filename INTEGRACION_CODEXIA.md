# Integración de Batalla final — CODEXIA

**Juego:** ULTRON: COLOSSAL AWAKENING VR  
**Equipos:** 1 a 20, elegidos con `− / +` antes de iniciar  
**Cronómetro:** 4 minutos, inicia cuando comienza el despertar de Ultron  
**Objetivo:** destruir las cuatro turbinas dentro del límite  

**Correspondencias:** amarillo → rojo; rojo → verde; verde → azul; azul → amarillo. Otros disparos hacen cero daño; cada turbina posee 900 HP.

**Nota (solo al ganar):** `redondear(100 × (0.40 × precisión + 0.35 × vida_conservada + 0.25 × rapidez))`. Precisión = aciertos correctos sobre disparos realizados desde el despertar; vida conservada = máximo de cero o uno menos daño recibido/100; rapidez = máximo de cero o uno menos segundos usados/240. Al perder o acabarse el tiempo, la nota es 0.

**Registro:** `POST https://zgpfcmvjmjfaphtudmis.supabase.co/rest/v1/rpc/registrar_taller` con `p_equipo` (1–20), `p_taller: 5`, `p_puntaje` (0–100). Uso de la clave **publishable** provista; no requiere login. La función SQL debe aceptar el taller 5, tener permisos para `anon` y conservar el mayor resultado para `public.scores.batalla_final`. El juego muestra el estado de publicación, sin afirmar que se guardó si hay error.

**Para compartir:** publicar el contenido completo del ZIP en GitHub/Render (sitio estático con directorio `public`), incluidos sus MP3. No se envían notas de prueba y se requiere verificar los permisos reales de Supabase.
