# Integración de Batalla Final CODEXIA — corrección de publicación

Se detectó una suposición no confirmada en la versión previa: `registrar_taller(p_equipo,p_taller,p_puntaje)` se invocaba con `p_taller=5`. La documentación original describía talleres 1–4, pero no comprobaba la implementación de la rama 5 en Supabase. Esto **podría explicar** que `batalla_final` continúe en 0. No es posible establecer la causa exacta sin registros de errores o acceso al proyecto.

Para evitar depender de esa suposición se agregó una **función RPC dedicada** `registrar_batalla_final(integer,numeric)` que se instala mediante `SQL/01_REGISTRAR_BATALLA_FINAL.sql`.

- Equipo 1–20; nota 0–100.
- Mantiene el mejor puntaje en `batalla_final` (`GREATEST`).
- No reescribe los cuatro talleres anteriores.
- Inserta la fila del equipo si no existía.
- Actualiza `total` cuando es columna normal; si `total` es GENERATED, deja que PostgreSQL lo calcule.
- Retorna el `batalla_final` realmente almacenado.
- Concede ejecución a `anon`, sin login, usando la clave pública (no service_role).

**PostgreSQL:** SQL Editor → ejecutar el contenido del archivo. Luego volver a desplegar el juego; el HTML llamará a `POST /rest/v1/rpc/registrar_batalla_final` con `{"p_equipo":7,"p_puntaje":95}` en el ejemplo de formato **sin enviar ese ejemplo**. `200 OK` sin valor numérico válido ya no se considera confirmación. Un fallo conserva el registro pendiente localmente.

## Comprobar sin registrar notas ficticias

Después de instalar el SQL, debe resultar `true` esta consulta de solo lectura:

```sql
SELECT pg_catalog.has_function_privilege(
  'anon',
  'public.registrar_batalla_final(integer,numeric)',
  'EXECUTE'
);
```

Tras una partida **real**, verifica en el Table Editor que `public.scores` haya actualizado la fila del equipo escogido y que `total` refleje la suma. El resultado antiguo (si no quedó registrado) no puede deducirse de la captura; para recuperarlo necesitas conocer su equipo y su nota legítima.
