-- CAPA DE CALIDAD DE DATOS
-- Objetivo: Detectar anomalías o datos imposibles en el sistema

CREATE TABLE IF NOT EXISTS Data_Quality_Logs (
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,
    check_name VARCHAR(100),
    status VARCHAR(20),
    details TEXT,
    checked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Test 1: Validar RPE (No puede ser mayor que 10 ni menor que 0)
INSERT INTO
    Data_Quality_Logs (check_name, status, details)
SELECT
    'RPE_Range_Check',
    CASE
        WHEN COUNT(*) > 0 THEN 'FAIL'
        ELSE 'PASS'
    END,
    'Se encontraron ' || COUNT(*) || ' series con RPE inválido (>10 o <0)'
FROM Sets
WHERE
    rpe > 10
    OR rpe < 0;

-- 3. Test 2: Validar Sueño (No puede ser > 24h o negativo)
INSERT INTO
    Data_Quality_Logs (check_name, status, details)
SELECT
    'Sleep_Hours_Check',
    CASE
        WHEN COUNT(*) > 0 THEN 'FAIL'
        ELSE 'PASS'
    END,
    'Se encontraron ' || COUNT(*) || ' registros con sueño imposible'
FROM BodyMetrics
WHERE
    sleep_hours > 24
    OR sleep_hours < 0;

-- 4. Test 3: Validar Pesos Negativos
INSERT INTO
    Data_Quality_Logs (check_name, status, details)
SELECT
    'Negative_Weight_Check',
    CASE
        WHEN COUNT(*) > 0 THEN 'FAIL'
        ELSE 'PASS'
    END,
    'Se encontraron ' || COUNT(*) || ' series con peso negativo'
FROM Sets
WHERE
    weight < 0;

SELECT * FROM Data_Quality_Logs;
