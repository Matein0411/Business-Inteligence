-- ============================================================
-- CONSULTAS MOLAP
-- ============================================================

-- ============================================================
-- PREGUNTA 1
-- ¿Cuál es el costo total de atención por especialidad,
-- ciudad y mes?
-- ============================================================
SELECT
    specialty_name,
    city,
    year,
    month,
    SUM(total_cost) AS costo_total
FROM mv_visitas_paciente_diagnostico
GROUP BY specialty_name, city, year, month
ORDER BY specialty_name, city, year, month;


-- ============================================================
-- PREGUNTA 2
-- ¿Qué ciudad tuvo más emergencias por mes y género?
-- ------------------------------------------------------------
-- Paso 1: contar emergencias por ciudad, año, mes y género.
-- Paso 2: usar DISTINCT ON para quedarnos con la ciudad de
--         mayor conteo en cada combinación (año, mes, género).
-- is_emergency = 1 indica que la visita fue una emergencia.
-- ============================================================
WITH emergencias_por_ciudad AS (
    SELECT
        year,
        month,
        patient_gender,
        city,
        COUNT(*) AS total_emergencias
    FROM mv_visitas_paciente_diagnostico
    WHERE is_emergency = 1
    GROUP BY year, month, patient_gender, city
)
SELECT DISTINCT ON (year, month, patient_gender)
    year,
    month,
    patient_gender,
    city AS ciudad_con_mas_emergencias,
    total_emergencias
FROM emergencias_por_ciudad
ORDER BY year, month, patient_gender, total_emergencias DESC;


-- ============================================================
-- PREGUNTA 3
-- Por diagnóstico y tipo de seguro: ¿cuál es el costo promedio
-- por visita, y en qué ciudad es más alto?
-- ------------------------------------------------------------
-- Paso 1: calcular el costo promedio por diagnóstico, seguro
--         y ciudad.
-- Paso 2: usar DISTINCT ON para quedarnos con la ciudad de
--         mayor costo promedio en cada combinación
--         (diagnóstico, tipo de seguro).
-- ============================================================
WITH costo_promedio_por_ciudad AS (
    SELECT
        diagnosis_group,
        insurance_type,
        city,
        AVG(total_cost) AS costo_promedio,
        COUNT(*) AS num_visitas
    FROM mv_visitas_paciente_diagnostico
    GROUP BY diagnosis_group, insurance_type, city
)
SELECT DISTINCT ON (diagnosis_group, insurance_type)
    diagnosis_group,
    insurance_type,
    city AS ciudad_costo_mas_alto,
    ROUND(costo_promedio, 2) AS costo_promedio_mas_alto,
    num_visitas
FROM costo_promedio_por_ciudad
ORDER BY diagnosis_group, insurance_type, costo_promedio DESC;

