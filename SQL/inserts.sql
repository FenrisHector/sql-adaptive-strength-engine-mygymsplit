-- 0. Limpieza
DELETE FROM Sets;

DELETE FROM Workouts;

DELETE FROM BodyMetrics;

DELETE FROM Users;

DELETE FROM Exercises;

DELETE FROM sqlite_sequence;

-- 1. Insertar Ejercicios
INSERT INTO
    Exercises (
        name,
        movement_pattern,
        primary_muscle,
        secondary_muscle
    )
VALUES (
        'Press Plano Máquina',
        'push',
        'pecho medio',
        'triceps, hombro anterior'
    ), -- id 1
    (
        'Press Inclinado Máquina',
        'push',
        'pecho superior',
        'triceps, hombro anterior'
    ), -- id 2
    (
        'Extensión Tríceps Unilateral (Cuerda)',
        'push',
        'triceps (cabeza corta)',
        NULL
    ), -- id 3
    (
        'Extensión Tríceps Overhead (Cuerda)',
        'push',
        'triceps (cabeza larga)',
        NULL
    ), -- id 4
    (
        'Elevaciones Laterales Máquina',
        'push',
        'hombro lateral',
        NULL
    ), -- id 5
    (
        'Jalón al Pecho Neutro',
        'pull',
        'dorsales',
        'biceps, hombro posterior'
    ), -- id 6
    (
        'Remo Máquina (Densidad)',
        'pull',
        'trapecio',
        'dorsales, hombro posterior'
    ), -- id 7
    (
        'Remo Gironda',
        'pull',
        'dorsales',
        'biceps, hombro posterior, trapecio'
    ), -- id 8
    (
        'Remo en Polea (Densidad)',
        'pull',
        'trapecio',
        'dorsales, hombro posterior'
    ), -- id 9
    (
        'Curl Bíceps Banco Inclinado',
        'pull',
        'biceps (cabeza larga)',
        NULL
    ), -- id 10
    (
        'Bíceps Unilateral Polea (Anilla)',
        'pull',
        'biceps (cabeza corta)',
        NULL
    ), -- id 11
    (
        'Extensión Cuádriceps',
        'squat',
        'cuadriceps',
        NULL
    ), -- id 12
    (
        'Aductor Máquina',
        'squat',
        'aductores',
        NULL
    ), -- id 13
    (
        'Prensa Unilateral',
        'squat',
        'cuadriceps',
        'gluteos'
    ), -- id 14
    (
        'Femoral Tumbado',
        'hinge',
        'isquios',
        'gluteos'
    ), -- id 15
    (
        'Gemelo en Máquina',
        'squat',
        'gemelos',
        NULL
    );
-- id 16

-- 2. Insertar Usuarios
INSERT INTO
    Users (
        user_id,
        email,
        age,
        sex,
        training_goal,
        experience_level
    )
VALUES (
        'Juan',
        'juan@email.com',
        28,
        'male',
        'volumen',
        'intermediate'
    ),
    (
        'Antonio',
        'antonio@email.com',
        30,
        'male',
        'definicion',
        'advanced'
    );

-- 3. Insertar Métricas
INSERT INTO
    BodyMetrics (
        user_id,
        date,
        bodyweight,
        sleep_hours
    )
VALUES (
        'Juan',
        '2025-10-06',
        82.0,
        7.5
    ),
    (
        'Juan',
        '2025-10-13',
        82.2,
        7.5
    ),
    (
        'Juan',
        '2025-10-20',
        82.3,
        7.6
    ),
    (
        'Juan',
        '2025-10-27',
        82.3,
        7.4
    ),
    (
        'Juan',
        '2025-11-03',
        82.4,
        7.5
    ),
    (
        'Antonio',
        '2025-10-06',
        75.0,
        5.5
    ),
    (
        'Antonio',
        '2025-10-13',
        75.2,
        5.6
    ),
    (
        'Antonio',
        '2025-10-20',
        75.5,
        5.4
    ),
    (
        'Antonio',
        '2025-10-27',
        75.6,
        5.5
    ),
    (
        'Antonio',
        '2025-11-03',
        75.8,
        5.2
    ),
    (
        'Antonio',
        '2025-11-10',
        75.8,
        5.0
    ),
    (
        'Antonio',
        '2025-11-17',
        75.5,
        6.0
    ),
    (
        'Antonio',
        '2025-11-24',
        75.7,
        5.5
    ),
    (
        'Antonio',
        '2025-12-01',
        76.0,
        5.6
    ),
    (
        'Antonio',
        '2025-12-08',
        76.2,
        5.5
    );

-- 4. INSERTAR ENTRENAMIENTOS

-- PARTE 2: DATOS DE JUAN (5 SEMANAS) - IDs 1 al 5
--------------------------------------------------------------------------------------------------------

-- SEMANA 1: Base
INSERT INTO
    Workouts (
        workout_id,
        user_id,
        date,
        session_type
    )
VALUES (
        1,
        'Juan',
        '2025-10-06',
        'Pecho/Espalda'
    );

INSERT INTO
    Sets (
        workout_id,
        exercise_id,
        set_number,
        reps,
        weight,
        rpe
    )
VALUES (1, 1, 1, 10, 80, 8),
    (1, 1, 2, 9, 80, 8.5),
    (1, 1, 3, 8, 80, 9);

-- SEMANA 2: Progreso
INSERT INTO
    Workouts (
        workout_id,
        user_id,
        date,
        session_type
    )
VALUES (
        2,
        'Juan',
        '2025-10-13',
        'Pecho/Espalda'
    );

INSERT INTO
    Sets (
        workout_id,
        exercise_id,
        set_number,
        reps,
        weight,
        rpe
    )
VALUES (2, 1, 1, 10, 82.5, 8),
    (2, 1, 2, 8, 82.5, 8.5),
    (2, 1, 3, 7, 82.5, 9);

-- SEMANA 3: Pico
INSERT INTO
    Workouts (
        workout_id,
        user_id,
        date,
        session_type
    )
VALUES (
        3,
        'Juan',
        '2025-10-20',
        'Pecho/Espalda'
    );

INSERT INTO
    Sets (
        workout_id,
        exercise_id,
        set_number,
        reps,
        weight,
        rpe
    )
VALUES (3, 1, 1, 10, 85, 8.5),
    (3, 1, 2, 8, 85, 9),
    (3, 1, 3, 6, 85, 9.5);

-- SEMANA 4: Estancamiento
INSERT INTO
    Workouts (
        workout_id,
        user_id,
        date,
        session_type
    )
VALUES (
        4,
        'Juan',
        '2025-10-27',
        'Pecho/Espalda'
    );

INSERT INTO
    Sets (
        workout_id,
        exercise_id,
        set_number,
        reps,
        weight,
        rpe
    )
VALUES (4, 1, 1, 10, 85, 9),
    (4, 1, 2, 7, 85, 9.5),
    (4, 1, 3, 5, 85, 10);

-- SEMANA 5: Regresión
INSERT INTO
    Workouts (
        workout_id,
        user_id,
        date,
        session_type
    )
VALUES (
        5,
        'Juan',
        '2025-11-03',
        'Pecho/Espalda'
    );

INSERT INTO
    Sets (
        workout_id,
        exercise_id,
        set_number,
        reps,
        weight,
        rpe
    )
VALUES (5, 1, 1, 8, 85, 9.5),
    (5, 1, 2, 5, 85, 10),
    (5, 1, 3, 4, 85, 10);

-- ANTONIO (10 SEMANAS) - IDs 20 al 29
-------------------------------------------------------------------------------------------------

-- SEMANA 1: Base
INSERT INTO
    Workouts (
        workout_id,
        user_id,
        date,
        session_type
    )
VALUES (
        20,
        'Antonio',
        '2025-10-06',
        'Pecho/Espalda'
    );

INSERT INTO
    Sets (
        workout_id,
        exercise_id,
        set_number,
        reps,
        weight,
        rpe
    )
VALUES (20, 1, 1, 10, 60, 7),
    (20, 1, 2, 9, 60, 7.5),
    (20, 1, 3, 8, 60, 8);

-- SEMANA 2: Subida
INSERT INTO
    Workouts (
        workout_id,
        user_id,
        date,
        session_type
    )
VALUES (
        21,
        'Antonio',
        '2025-10-13',
        'Pecho/Espalda'
    );

INSERT INTO
    Sets (
        workout_id,
        exercise_id,
        set_number,
        reps,
        weight,
        rpe
    )
VALUES (21, 1, 1, 10, 65, 8),
    (21, 1, 2, 8, 65, 8.5),
    (21, 1, 3, 7, 65, 9);

-- SEMANA 3: Carga Alta
INSERT INTO
    Workouts (
        workout_id,
        user_id,
        date,
        session_type
    )
VALUES (
        22,
        'Antonio',
        '2025-10-20',
        'Pecho/Espalda'
    );

INSERT INTO
    Sets (
        workout_id,
        exercise_id,
        set_number,
        reps,
        weight,
        rpe
    )
VALUES (22, 1, 1, 10, 70, 8.5),
    (22, 1, 2, 8, 70, 9),
    (22, 1, 3, 6, 70, 9.5);

-- SEMANA 4: Intento Récord
INSERT INTO
    Workouts (
        workout_id,
        user_id,
        date,
        session_type
    )
VALUES (
        23,
        'Antonio',
        '2025-10-27',
        'Pecho/Espalda'
    );

INSERT INTO
    Sets (
        workout_id,
        exercise_id,
        set_number,
        reps,
        weight,
        rpe
    )
VALUES (23, 1, 1, 9, 75, 9),
    (23, 1, 2, 7, 75, 9.5),
    (23, 1, 3, 5, 75, 10);

-- SEMANA 5:
INSERT INTO
    Workouts (
        workout_id,
        user_id,
        date,
        session_type
    )
VALUES (
        24,
        'Antonio',
        '2025-11-03',
        'Pecho/Espalda'
    );

INSERT INTO
    Sets (
        workout_id,
        exercise_id,
        set_number,
        reps,
        weight,
        rpe
    )
VALUES (24, 1, 1, 8, 75, 9.5),
    (24, 1, 2, 6, 75, 10),
    (24, 1, 3, 4, 75, 10);

-- SEMANA 6: FATIGA AGUDA
INSERT INTO
    Workouts (
        workout_id,
        user_id,
        date,
        session_type
    )
VALUES (
        25,
        'Antonio',
        '2025-11-10',
        'Pecho/Espalda'
    );

INSERT INTO
    Sets (
        workout_id,
        exercise_id,
        set_number,
        reps,
        weight,
        rpe
    )
VALUES (25, 1, 1, 8, 75, 10),
    (25, 1, 2, 5, 75, 10),
    (25, 1, 3, 3, 75, 10);

-- SEMANA 7: DESCARGA
INSERT INTO
    Workouts (
        workout_id,
        user_id,
        date,
        session_type
    )
VALUES (
        26,
        'Antonio',
        '2025-11-17',
        'Pecho/Espalda'
    );

INSERT INTO
    Sets (
        workout_id,
        exercise_id,
        set_number,
        reps,
        weight,
        rpe
    )
VALUES (26, 1, 1, 10, 40, 5),
    (26, 1, 2, 10, 40, 5),
    (26, 1, 3, 10, 40, 5);

-- SEMANA 8: VUELTA
INSERT INTO
    Workouts (
        workout_id,
        user_id,
        date,
        session_type
    )
VALUES (
        27,
        'Antonio',
        '2025-11-24',
        'Pecho/Espalda'
    );

INSERT INTO
    Sets (
        workout_id,
        exercise_id,
        set_number,
        reps,
        weight,
        rpe
    )
VALUES (27, 1, 1, 10, 70, 7.5),
    (27, 1, 2, 9, 70, 8),
    (27, 1, 3, 8, 70, 8.5);

-- SEMANA 9: RECUPERANDO NIVEL
INSERT INTO
    Workouts (
        workout_id,
        user_id,
        date,
        session_type
    )
VALUES (
        28,
        'Antonio',
        '2025-12-01',
        'Pecho/Espalda'
    );

INSERT INTO
    Sets (
        workout_id,
        exercise_id,
        set_number,
        reps,
        weight,
        rpe
    )
VALUES (28, 1, 1, 10, 75, 8.5),
    (28, 1, 2, 9, 75, 9),
    (28, 1, 3, 8, 75, 9.5);

-- SEMANA 10: NUEVO RECORD
INSERT INTO
    Workouts (
        workout_id,
        user_id,
        date,
        session_type
    )
VALUES (
        29,
        'Antonio',
        '2025-12-08',
        'Pecho/Espalda'
    );

INSERT INTO
    Sets (
        workout_id,
        exercise_id,
        set_number,
        reps,
        weight,
        rpe
    )
VALUES (29, 1, 1, 10, 77.5, 9),
    (29, 1, 2, 8, 77.5, 9.5),
    (29, 1, 3, 7, 77.5, 10);
