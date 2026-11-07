-- CODEXIA / BATALLA FINAL. EJECUTAR UNA SOLA VEZ EN SUPABASE > SQL EDITOR.
-- NO REEMPLAZA registrar_taller: talleres 1, 2, 3 y 4 permanecen intactos.
-- No contiene notas de ejemplo ni modifica las ya almacenadas.
-- El valor retornado es el valor realmente guardado en scores.batalla_final.

CREATE OR REPLACE FUNCTION public.registrar_batalla_final(
    p_equipo integer,
    p_puntaje numeric
)
RETURNS numeric
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
    v_guardado numeric;
    v_total_generado text;
BEGIN
    IF p_equipo IS NULL OR p_equipo NOT BETWEEN 1 AND 20 THEN
        RAISE EXCEPTION 'El equipo debe estar entre 1 y 20';
    END IF;
    IF p_puntaje IS NULL OR p_puntaje < 0 OR p_puntaje > 100 THEN
        RAISE EXCEPTION 'La puntuación debe estar entre 0 y 100';
    END IF;

    -- Evitar asignar una columna generada en los proyectos donde total es GENERATED ALWAYS.
    SELECT a.attgenerated::text INTO v_total_generado
      FROM pg_catalog.pg_attribute AS a
      JOIN pg_catalog.pg_class AS c ON c.oid = a.attrelid
      JOIN pg_catalog.pg_namespace AS n ON n.oid = c.relnamespace
     WHERE n.nspname = 'public' AND c.relname = 'scores'
       AND a.attname = 'total' AND a.attnum > 0 AND NOT a.attisdropped;

    IF v_total_generado IS NULL THEN
        RAISE EXCEPTION 'No se encontró la columna public.scores.total';
    ELSIF v_total_generado <> '' THEN
        -- total calculado automáticamente (columna GENERATED).
        INSERT INTO public.scores
            (equipo, taller_1, taller_2, taller_3, taller_4, batalla_final)
        VALUES (p_equipo, 0, 0, 0, 0, p_puntaje)
        ON CONFLICT (equipo) DO UPDATE SET
            batalla_final = GREATEST(
                COALESCE(public.scores.batalla_final, 0),
                EXCLUDED.batalla_final
            )
        RETURNING batalla_final INTO v_guardado;
    ELSE
        -- total normal: actualizar sólo batalla_final y su total acumulado;
        -- NO sobreescribir taller_1..taller_4 en un equipo existente.
        INSERT INTO public.scores
            (equipo, taller_1, taller_2, taller_3, taller_4, batalla_final, total)
        VALUES (p_equipo, 0, 0, 0, 0, p_puntaje, p_puntaje)
        ON CONFLICT (equipo) DO UPDATE SET
            batalla_final = GREATEST(
                COALESCE(public.scores.batalla_final, 0),
                EXCLUDED.batalla_final
            ),
            total = COALESCE(public.scores.taller_1, 0)
                  + COALESCE(public.scores.taller_2, 0)
                  + COALESCE(public.scores.taller_3, 0)
                  + COALESCE(public.scores.taller_4, 0)
                  + GREATEST(
                      COALESCE(public.scores.batalla_final, 0),
                      EXCLUDED.batalla_final
                    )
        RETURNING batalla_final INTO v_guardado;
    END IF;

    RETURN v_guardado;
END;
$$;

-- Permitir la RPC pública prevista para el juego sin cuenta de usuario.
-- ADVERTENCIA: anon puede enviar calificaciones; esto NO verifica honestidad de partida.
REVOKE ALL ON FUNCTION public.registrar_batalla_final(integer, numeric) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.registrar_batalla_final(integer, numeric) TO anon;

-- Verificación de configuración (no escribe notas):
SELECT
    pg_catalog.has_function_privilege(
        'anon', 'public.registrar_batalla_final(integer,numeric)', 'EXECUTE'
    ) AS anon_puede_registrar_batalla_final;
