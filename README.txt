Gym Performance Intelligence System (GPIS)
Proyecto de ingeniería de datos y análisis avanzado de rendimiento deportivo basando en lógica de negocio, lógica relacional y SQL (SQLite), rutina basada en split mi personal de 7 días en el gimnasio con enfoque de hipertrofia. Datos sintéticos generados con lógica de fatiga aleatoria para validación de algoritmos.

Descripción
Este proyecto busca digitalizar y optimizar la toma de decisiones en el entrenamiento de fuerza mediante un motor de base de datos relacional. El enfoque principal no fue únicamente almacenar registros, sino diseñar una arquitectura de datos capaz de interpretar el rendimiento en tiempo real. Se implementaron algoritmos para detectar estancamientos, predecir la fatiga intra-sesión y calcular la necesidad de semanas de descarga (restweeks) basándose en variables biológicas (sueño, dieta) y métricas de carga.

Los datos base fueron generados sintéticamente replicando mi rutina personal de hipertrofia (frecuencia 2, split: Pecho/Espalda - Brazo - Pierna - Descanso - Upper - Lower - Descanso), introduciendo variabilidad aleatoria (caída de repeticiones entre -1 y -3) para poner a prueba los algoritmos. Durante el desarrollo se utilizó de forma sutil asistencia de inteligencia artificial, principalmente Copilot en Visual Studio Code, para la generación de datos sintéticos (inserts), pero toda la lógica de negocio, lógica relacional, el diseño del esquema y las decisiones analíticas fueron realizadas manualmente.

Objetivos
Detección de Estancamiento: Identificar automáticamente cuándo un levantamiento no supera el récord histórico (Running Max) en un periodo determinado.

Auto-Regulación de Carga: Predecir cuándo un atleta debe bajar peso en la siguiente serie basándose en la caída de rendimiento de la serie anterior debido a la fatiga acumulada.

Gestión de Fatiga (Deload): Calcular la "Semana de Descarga" óptima cruzando semanas acumuladas, horas de sueño y fase nutricional (Volumen vs Recomposición Croporal vs Definición).

Auditoría de Datos: Asegurar la integridad de la información mediante una capa de calidad de datos.

Datos
Fuente principal: Generación propia basada en mi rutina real de 7 días.

Volumen: Simulaciones de ciclos de 5 a 10 semanas de entrenamiento.

Perfiles simulados:

Juan: Perfil óptimo (Volumen, sueño > 7h).

Antonio: Perfil de riesgo (Definición, sueño < 6h).

Variables principales
Entrenamiento: reps, weight, rpe, session_type (Pecho/Espalda, Lower, etc.).

Contexto: sleep_hours (horas de sueño), training_goal (volumen/definición).

Catálogo: Ejercicios específicos como Press Plano Máquina, Jalón Neutro, Remo Gironda, Extensión Tríceps Overhead.

Para probar la robustez del sistema, se introdujo un factor de aleatoriedad en los datos de Antonio, simulando caídas de rendimiento de entre 1 y 3 repeticiones en series sucesivas para activar las alertas de fatiga.

Metodología
1. Diseño del Schema (OLTP)
Modelado de una base de datos normalizada en SQLite con 5 tablas principales (Users, Exercises, Workouts, Sets, BodyMetrics) asegurando integridad referencial y tipos de datos correctos.

2. Generación de Datos (Escenarios)
Creación de scripts SQL (seeds) que simulan historiales de entrenamiento completos:

Escenario A (Progresión): Aumento lineal de cargas.

Escenario B (Fatiga Aguda): Caída drástica de repeticiones intra-sesión.

Escenario C (Riesgo Sistémico): Acumulación de semanas con déficit de sueño y dieta restrictiva.

3. Algoritmo de Estancamiento
Implementación de Window Functions (MAX() OVER ... ROWS UNBOUNDED PRECEDING) para comparar el rendimiento actual contra el máximo histórico absoluto del usuario, evitando falsos positivos por comparaciones simples semanales.

4. Predictor de Auto-Regulación
Uso de funciones de desplazamiento (LAG) para comparar la serie actual (N) con la anterior (N-1).

Regla: Si las repeticiones caen por debajo de un umbral crítico o la fatiga es evidente, el sistema sugiere 🔻 ALERTA: BAJAR PESO.

Aquí tienes la versión expandida y detallada del Punto 5 para tu README.

Copia este bloque y sustituye el punto 5 anterior. Esta versión demuestra mucho mejor la complejidad de la lógica de negocio que has implementado.

 5. Predictor de Semanas de Descarga

Desarrollo de un sistema de puntuación (Fatigue Score) mediante lógica condicional (CASE WHEN)

A. Sistema de Puntuación (Fatigue Score)

Se implementó una lógica acumulativa mediante CASE WHEN donde 0 es el estado ideal y 10 es el riesgo máximo.

Factor Sueño (Recuperación Neural):

< 6 horas: +6 Puntos (Riesgo Crítico / SNC comprometido).

6 - 7 horas: +3 Puntos (Recuperación incompleta).
7 - 8 horas: +1 Punto (Fatiga leve).
> 8 horas: 0 Puntos (Recuperación óptima).

Factor Nutrición (Recuperación Energética):

Déficit / Definición: +4 Puntos (Alta penalización por falta de sustrato energético).
Recomposición: +2 Puntos.
Superávit / Volumen: 0 Puntos.

B. Matriz de Decisión Temporal El sistema evalúa el Fatigue Score total contra la semana actual del mesociclo para determinar el límite seguro de entrenamiento:

Rango 1 (Semanas 0-5): Fase de Acumulación:

Acción: 🟢 SIGUE ENTRENANDO. Se prioriza la acumulación de volumen ignorando fatiga leve.

Rango 2 (Semana 6): Filtro de Seguridad Crítica:

Lógica: Si Score ≥ 6 (Ej: Dormir <6h).
Acción: 💀 DESCARGA INMEDIATA.

Rango 3 (Semanas 7-8): Zona de Gestión de Fatiga:

Lógica: Si Score ≥ 3 (Ej: Definición o dormir regular).
Acción: ⚠️ PLANIFICA DESCARGA.

Rango 4 (Semana 9+): Límite Fisiológico:

Lógica: Independientemente de la puntuación.
Acción: 🔴 DESCARGA OBLIGATORIA.

Resultado: Clasificación en 4 rangos temporales, forzando descargas en la semana 6 para perfiles de riesgo alto o permitiendo llegar a la semana 9 en perfiles de riesgo bajo.

Conclusiones
El sistema diferenció correctamente los perfiles: sugirió continuar entrenando a Juan (Semana 5) y forzó una descarga inmediata a Antonio (Semana 9 + Riesgo Alto).

El uso de Window Functions demostró ser superior a las subconsultas para calcular récords históricos (PRs).

El predictor de carga intra-sesión reaccionó correctamente a la simulación de fatiga aleatoria, sugiriendo bajadas de peso en la 2ª y 3ª serie cuando el rendimiento caía más de 2 repeticiones.

SQL permite implementar lógica de negocio ("Business Logic") directamente en la base de datos, reduciendo la necesidad de procesamiento externo.

Estructura del repositorio
Plaintext

sql-adaptive-strength-engine/
├── sql/
│   ├── 01_schema.sql      # Estructura de tablas (CREATE)
│   ├── 02_seeds.sql       # Datos simulados (Juan y Antonio)
│   └── 03_analysis.sql    # KPIs y Algoritmos de decisión
├── tests/
│   └── data_quality.sql   # Tests de integridad de datos
└── README.md              # Documentación del proyecto

Tecnologías
Lenguaje: SQL (Dialecto SQLite)
Entorno: VS Code con extensión SQLite
Control de versiones: Git / GitHub
Conceptos: Window Functions, CTEs, Data Modeling, Business Logic Implementation

Autor
Héctor Zamorano García.
