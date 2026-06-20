-- ============================================================
-- MODELO ESTRELLA 
-- ============================================================

-- ------------------------------------------------------------
-- Limpieza previa
-- ------------------------------------------------------------
DROP TABLE IF EXISTS fact_visit CASCADE;
DROP TABLE IF EXISTS dim_visit_date CASCADE;
DROP TABLE IF EXISTS dim_patient CASCADE;
DROP TABLE IF EXISTS dim_doctor CASCADE;
DROP TABLE IF EXISTS dim_specialty CASCADE;
DROP TABLE IF EXISTS dim_department CASCADE;
DROP TABLE IF EXISTS dim_diagnosis CASCADE;
DROP TABLE IF EXISTS dim_procedure CASCADE;

-- ============================================================
-- DIMENSIÓN: FECHA
-- ============================================================
CREATE TABLE dim_visit_date (
    date_key    INTEGER PRIMARY KEY,   -- formato YYYYMMDD
    visit_date  DATE,
    day         SMALLINT,
    month       SMALLINT,
    year        SMALLINT
);

-- ============================================================
-- DIMENSIÓN: PACIENTE
-- ============================================================
CREATE TABLE dim_patient (
    patient_key     SERIAL PRIMARY KEY,
    patient_id      INTEGER,
    patient_gender  VARCHAR(20)
);

-- ============================================================
-- DIMENSIÓN: DOCTOR
-- ============================================================
CREATE TABLE dim_doctor (
    doctor_key  SERIAL PRIMARY KEY,
    doctor_id   INTEGER
);

-- ============================================================
-- DIMENSIÓN: ESPECIALIDAD
-- ============================================================
CREATE TABLE dim_specialty (
    specialty_key   SERIAL PRIMARY KEY,
    specialty_name  VARCHAR(100)
);

-- ============================================================
-- DIMENSIÓN: DEPARTAMENTO HOSPITALARIO
-- ============================================================
CREATE TABLE dim_department (
    department_key   SERIAL PRIMARY KEY,
    department_name  VARCHAR(100)
);

-- ============================================================
-- DIMENSIÓN: DIAGNÓSTICO
-- ============================================================
CREATE TABLE dim_diagnosis (
    diagnosis_key    SERIAL PRIMARY KEY,
    diagnosis_group  VARCHAR(150)
);

-- ============================================================
-- DIMENSIÓN: PROCEDIMIENTO
-- ============================================================
CREATE TABLE dim_procedure (
    procedure_key   SERIAL PRIMARY KEY,
    procedure_type  VARCHAR(150)
);

-- ============================================================
-- TABLA DE HECHOS: VISITA
-- Grano: una fila = una visita médica.
-- Incluye atributos que varían por visita (city, insurance_type,
-- patient_age) ya que no pertenecen de forma estable al paciente.
-- ============================================================
CREATE TABLE fact_visit (
    visit_key             SERIAL PRIMARY KEY,
    visit_id              INTEGER,

    date_key              INTEGER REFERENCES dim_visit_date(date_key),
    patient_key           INTEGER REFERENCES dim_patient(patient_key),
    doctor_key            INTEGER REFERENCES dim_doctor(doctor_key),
    specialty_key         INTEGER REFERENCES dim_specialty(specialty_key),
    department_key        INTEGER REFERENCES dim_department(department_key),
    diagnosis_key          INTEGER REFERENCES dim_diagnosis(diagnosis_key),
    procedure_key          INTEGER REFERENCES dim_procedure(procedure_key),

    -- Atributos que varían por visita (no estables en dim_patient)
    patient_age            SMALLINT,
    city                    VARCHAR(100),
    insurance_type          VARCHAR(50),

    -- Medidas / hechos
    is_emergency            SMALLINT,
    length_of_stay_days     SMALLINT,
    cost_medicine           NUMERIC(12,2),
    cost_procedure          NUMERIC(12,2),
    total_cost              NUMERIC(12,2),
    outcome                  VARCHAR(50)
);

-- ============================================================
-- ÍNDICES para acelerar los JOIN con las dimensiones en las consultas MOLAP
-- ============================================================
CREATE INDEX idx_fact_date_key        ON fact_visit(date_key);
CREATE INDEX idx_fact_patient_key     ON fact_visit(patient_key);
CREATE INDEX idx_fact_doctor_key      ON fact_visit(doctor_key);
CREATE INDEX idx_fact_specialty_key   ON fact_visit(specialty_key);
CREATE INDEX idx_fact_department_key  ON fact_visit(department_key);
CREATE INDEX idx_fact_diagnosis_key   ON fact_visit(diagnosis_key);
CREATE INDEX idx_fact_procedure_key   ON fact_visit(procedure_key);



-- ============================================================
-- POBLADO DEL MODELO ESTRELLA DESDE LAS TABLAS RELACIONALES
-- ============================================================

-- ------------------------------------------------------------
-- 1. dim_visit_date
-- ------------------------------------------------------------
INSERT INTO dim_visit_date (date_key, visit_date, day, month, year)
SELECT DISTINCT
    CAST(TO_CHAR(visit_date, 'YYYYMMDD') AS INTEGER) AS date_key,
    visit_date,
    EXTRACT(DAY   FROM visit_date)::SMALLINT AS day,
    EXTRACT(MONTH FROM visit_date)::SMALLINT AS month,
    EXTRACT(YEAR  FROM visit_date)::SMALLINT AS year
FROM visits
WHERE visit_date IS NOT NULL;

-- ------------------------------------------------------------
-- 2. dim_patient
-- ------------------------------------------------------------
INSERT INTO dim_patient (patient_id, patient_gender)
SELECT patient_id, patient_gender
FROM patients;

-- ------------------------------------------------------------
-- 3. dim_doctor
-- ------------------------------------------------------------
INSERT INTO dim_doctor (doctor_id)
SELECT doctor_id
FROM doctors;

-- ------------------------------------------------------------
-- 4. dim_specialty
-- ------------------------------------------------------------
INSERT INTO dim_specialty (specialty_name)
SELECT specialty_name
FROM specialties;

-- ------------------------------------------------------------
-- 5. dim_department
-- ------------------------------------------------------------
INSERT INTO dim_department (department_name)
SELECT department_name
FROM departments;

-- ------------------------------------------------------------
-- 6. dim_diagnosis
-- ------------------------------------------------------------
INSERT INTO dim_diagnosis (diagnosis_group)
SELECT diagnosis_group
FROM diagnosis;

-- ------------------------------------------------------------
-- 7. dim_procedure
-- ------------------------------------------------------------
INSERT INTO dim_procedure (procedure_type)
SELECT procedure_type
FROM procedures;

-- ============================================================
-- 8. fact_visit
-- ============================================================
INSERT INTO fact_visit (
    visit_id, date_key, patient_key, doctor_key, specialty_key,
    department_key, diagnosis_key, procedure_key,
    patient_age, city, insurance_type,
    is_emergency, length_of_stay_days,
    cost_medicine, cost_procedure, total_cost, outcome
)
SELECT
    v.visit_id,
    CAST(TO_CHAR(v.visit_date, 'YYYYMMDD') AS INTEGER) AS date_key,
    dp.patient_key,
    dd.doctor_key,
    ds.specialty_key,
    de.department_key,
    dg.diagnosis_key,
    dpr.procedure_key,
    v.patient_age,
    c.city_name,
    ins.insurance_type_name,
    v.is_emergency,
    v.length_of_stay_days,
    v.cost_medicine,
    v.cost_procedure,
    v.total_cost,
    v.outcome
FROM visits v
JOIN dim_patient dp     ON v.patient_id = dp.patient_id
JOIN dim_doctor dd      ON v.doctor_id = dd.doctor_id
JOIN specialties s      ON v.specialty_id = s.specialty_id
JOIN dim_specialty ds   ON s.specialty_name = ds.specialty_name
JOIN departments dep    ON v.department_id = dep.department_id
JOIN dim_department de  ON dep.department_name = de.department_name
JOIN diagnosis di       ON v.diagnosis_id = di.diagnosis_id
JOIN dim_diagnosis dg   ON di.diagnosis_group = dg.diagnosis_group
JOIN procedures pro     ON v.procedure_id = pro.procedure_id
JOIN dim_procedure dpr  ON pro.procedure_type = dpr.procedure_type
JOIN cities c           ON v.city_id = c.city_id
JOIN insurance_types ins ON v.insurance_type_id = ins.insurance_type_id;