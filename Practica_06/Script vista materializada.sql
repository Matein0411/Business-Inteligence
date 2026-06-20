-- ============================================================
-- VISTA MATERIALIZADA (MOLAP) - BASE DE DATOS DE SALUD
-- Pre-une fact_visit con TODAS las dimensiones, dejando una
-- tabla "plana" lista para consultas de agregación OLAP
-- (GROUP BY por cualquier combinación de atributos dimensionales).
-- ============================================================

DROP MATERIALIZED VIEW IF EXISTS mv_visitas_paciente_diagnostico;

CREATE MATERIALIZED VIEW mv_visitas_paciente_diagnostico AS
SELECT
    f.visit_id,
    f.visit_key,

    -- Atributos de dim_patient
    dp.patient_id,
    dp.patient_gender,

    -- Atributos descriptivos de la visita (en fact_visit)
    f.patient_age,
    f.city,
    f.insurance_type,

    -- Atributos de dim_doctor
    dd.doctor_id,

    -- Atributos de dim_specialty
    ds.specialty_name,

    -- Atributos de dim_department
    de.department_name,

    -- Atributos de dim_diagnosis
    dg.diagnosis_group,

    -- Atributos de dim_procedure
    dpr.procedure_type,

    -- Atributos de dim_visit_date
    dv.visit_date,
    dv.day,
    dv.month,
    dv.year,

    -- Medidas / hechos
    f.is_emergency,
    f.length_of_stay_days,
    f.cost_medicine,
    f.cost_procedure,
    f.total_cost,
    f.outcome

FROM fact_visit f
JOIN dim_patient dp     ON f.patient_key = dp.patient_key
JOIN dim_doctor dd      ON f.doctor_key = dd.doctor_key
JOIN dim_specialty ds   ON f.specialty_key = ds.specialty_key
JOIN dim_department de  ON f.department_key = de.department_key
JOIN dim_diagnosis dg   ON f.diagnosis_key = dg.diagnosis_key
JOIN dim_procedure dpr  ON f.procedure_key = dpr.procedure_key
JOIN dim_visit_date dv  ON f.date_key = dv.date_key;

-- ------------------------------------------------------------
-- Refrescar la vista (ejecutar cada vez que cambien los datos
-- subyacentes en fact_visit o en las dimensiones)
-- ------------------------------------------------------------
REFRESH MATERIALIZED VIEW mv_visitas_paciente_diagnostico;

-- ------------------------------------------------------------
-- Índices sobre la vista materializada
-- (aceleran los GROUP BY de las consultas MOLAP siguientes)
-- ------------------------------------------------------------
CREATE INDEX idx_mv_specialty   ON mv_visitas_paciente_diagnostico(specialty_name);
CREATE INDEX idx_mv_city        ON mv_visitas_paciente_diagnostico(city);
CREATE INDEX idx_mv_month_year  ON mv_visitas_paciente_diagnostico(year, month);
CREATE INDEX idx_mv_gender      ON mv_visitas_paciente_diagnostico(patient_gender);
CREATE INDEX idx_mv_diagnosis   ON mv_visitas_paciente_diagnostico(diagnosis_group);
CREATE INDEX idx_mv_insurance   ON mv_visitas_paciente_diagnostico(insurance_type);
