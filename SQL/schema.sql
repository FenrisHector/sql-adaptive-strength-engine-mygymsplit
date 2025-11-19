-- 1. Tabla Users
CREATE TABLE Users (
    user_id VARCHAR(50) PRIMARY KEY NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    age INTEGER,
    sex VARCHAR(10),
    training_goal VARCHAR(50),
    experience_level VARCHAR(20)
);

-- 2. Tabla Exercises
CREATE TABLE Exercises (
    exercise_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    movement_pattern VARCHAR(50),
    primary_muscle VARCHAR(50),
    secondary_muscle VARCHAR(100)
);

-- 3. Tabla Workouts (CLAVE AJENA Workouts.user_id --> Users.user_id)
CREATE TABLE Workouts (
    workout_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
    session_type VARCHAR(50),
    duration_minutes INTEGER,
    notes TEXT,
    FOREIGN KEY (user_id) REFERENCES Users (user_id) ON DELETE CASCADE
);

-- 4. Tabla Sets (CLAVE AJENA Sets.workout_id --> Workouts.workout_id, CLAVE AJENA Sets.exercise_id --> Exercises.exercise_id)
CREATE TABLE Sets (
    set_id INTEGER PRIMARY KEY AUTOINCREMENT,
    workout_id INTEGER NOT NULL,
    exercise_id INTEGER NOT NULL,
    set_number INTEGER NOT NULL,
    reps INTEGER NOT NULL,
    weight DECIMAL(6, 2) NOT NULL,
    rpe DECIMAL(3, 1),
    FOREIGN KEY (workout_id) REFERENCES Workouts (workout_id) ON DELETE CASCADE,
    FOREIGN KEY (exercise_id) REFERENCES Exercises (exercise_id)
);

-- 5. Tabla BodyMetrics (CLAVE AJENA BodyMetrics.user_id --> Users.user_id)
CREATE TABLE BodyMetrics (
    metric_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
    bodyweight DECIMAL(5, 2),
    bodyfat_percent DECIMAL(4, 2),
    waist_cm DECIMAL(5, 2),
    sleep_hours DECIMAL(4, 2),
    readiness_score INTEGER,
    FOREIGN KEY (user_id) REFERENCES Users (user_id) ON DELETE CASCADE,
    UNIQUE (user_id, date)
);
