--- Detección de Estancamiento vs Récord Histórico ---
WITH
    WeeklyStats AS (
        SELECT
            u.user_id,
            e.name AS exercise_name,
            strftime ('%Y-%W', w.date) AS week_group,
            MAX(
                s.weight * (1 + s.reps / 30.0)
            ) AS current_e1rm
        FROM
            Sets s
            JOIN Workouts w ON s.workout_id = w.workout_id
            JOIN Users u ON w.user_id = u.user_id
            JOIN Exercises e ON s.exercise_id = e.exercise_id
        WHERE
            e.name = 'Press Plano Máquina'
        GROUP BY
            u.user_id,
            e.exercise_id,
            week_group
    ),
    Comparison AS (
        SELECT *, MAX(current_e1rm) OVER (
                PARTITION BY
                    user_id, exercise_name
                ORDER BY
                    week_group ROWS BETWEEN UNBOUNDED PRECEDING
                    AND 1 PRECEDING
            ) AS best_previous_pr
        FROM WeeklyStats
    )

SELECT
    user_id,
    week_group,
    ROUND(current_e1rm, 2) AS e1RM_Actual,
    ROUND(
        COALESCE(best_previous_pr, 0),
        2
    ) AS Record_Historico,
    CASE
        WHEN best_previous_pr IS NULL THEN '🏁 Inicio (Base)'
        WHEN current_e1rm > best_previous_pr THEN '🏆 NUEVO PR'
        ELSE '⚠️ ESTANCADO / BAJADA'
    END AS Estado
FROM Comparison
ORDER BY user_id, week_group;

--- Predictor de Carga (Agrupado por Usuario: Juan 1º, Antonio 2º) ---

WITH
    SetAnalysis AS (
        SELECT
            u.user_id,
            w.workout_id,
            w.date,
            e.name AS exercise_name,
            s.set_number AS serie_acabada,
            s.reps AS reps_realizadas,
            MAX(s.set_number) OVER (
                PARTITION BY
                    s.workout_id,
                    s.exercise_id
            ) AS total_series_ejercicio
        FROM
            Sets s
            JOIN Workouts w ON s.workout_id = w.workout_id
            JOIN Users u ON w.user_id = u.user_id
            JOIN Exercises e ON s.exercise_id = e.exercise_id
    )

SELECT
    user_id,
    workout_id,
    date,
    exercise_name,
    serie_acabada,
    reps_realizadas,
    (serie_acabada + 1) AS consejo_para_serie,
    CASE
        WHEN reps_realizadas <= 7 THEN '🔻 ALERTA: BAJAR PESO'
        ELSE '✅ MANTENER PESO'
    END AS Accion_Recomendada
FROM SetAnalysis
WHERE
    serie_acabada < total_series_ejercicio
    AND exercise_name = 'Press Plano Máquina'
ORDER BY user_id DESC, date ASC, serie_acabada ASC;

--- Predictor de Semana de Descarga ---

WITH
    UserContext AS (
        SELECT
            u.user_id,
            u.training_goal AS dieta,
            (
                SELECT sleep_hours
                FROM BodyMetrics bm
                WHERE
                    bm.user_id = u.user_id
                ORDER BY date DESC
                LIMIT 1
            ) AS horas_sueno,
            COUNT(
                DISTINCT strftime ('%Y-%W', w.date)
            ) AS semanas_entrenando
        FROM Users u
            JOIN Workouts w ON u.user_id = w.user_id
        GROUP BY
            u.user_id
    ),
    FatigueCalculator AS (
        SELECT *, (
                CASE
                    WHEN horas_sueno < 6 THEN 6
                    WHEN horas_sueno < 7 THEN 3
                    WHEN horas_sueno < 8 THEN 1
                    ELSE 0
                END + CASE
                    WHEN dieta = 'definicion' THEN 4
                    WHEN dieta = 'recomposition' THEN 2
                    ELSE 0
                END
            ) AS Puntos_Internos
        FROM UserContext
    )

SELECT
    user_id,
    semanas_entrenando AS Semana_Actual,
    CASE
        WHEN Puntos_Internos >= 6 THEN 'Semana 6 (Ciclo Corto)'
        WHEN Puntos_Internos BETWEEN 3 AND 5  THEN 'Semana 7 (Ciclo Medio)'
        ELSE 'Semana 9 (Ciclo Largo)'
    END AS Meta_Descarga,
    CASE
        WHEN semanas_entrenando >= (
            CASE
                WHEN Puntos_Internos >= 6 THEN 6
                WHEN Puntos_Internos BETWEEN 3 AND 5  THEN 7
                ELSE 9
            END
        ) THEN '🔴 TOCA DESCARGAR (Llegaste a tu límite)'
        WHEN semanas_entrenando = (
            CASE
                WHEN Puntos_Internos >= 6 THEN 6
                WHEN Puntos_Internos BETWEEN 3 AND 5  THEN 7
                ELSE 9
            END
        ) - 1 THEN '⚠️ PREPARA DESCARGA (Te queda 1 semana)'
        ELSE '🟢 SIGUE ENTRENANDO (Estás en fase segura)'
    END AS Estado_Actual
FROM FatigueCalculator
ORDER BY semanas_entrenando DESC;
