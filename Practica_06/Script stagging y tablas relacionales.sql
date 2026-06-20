-- ------------------------------------------------------------
-- Limpieza previa
-- ------------------------------------------------------------
DROP TABLE IF EXISTS visits CASCADE;
DROP TABLE IF EXISTS patients CASCADE;
DROP TABLE IF EXISTS doctors CASCADE;
DROP TABLE IF EXISTS diagnosis CASCADE;
DROP TABLE IF EXISTS procedures CASCADE;
DROP TABLE IF EXISTS specialties CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS insurance_types CASCADE;
DROP TABLE IF EXISTS cities CASCADE;
DROP TABLE IF EXISTS staging_visits CASCADE;

-- ============================================================
-- TABLA STAGING
-- ============================================================
CREATE TABLE staging_visits (
    visit_id              INTEGER,
    visit_date            DATE,
    patient_id            INTEGER,
    patient_age           SMALLINT,
    patient_gender        VARCHAR(20),
    city                  VARCHAR(100),
    hospital_department   VARCHAR(100),
    doctor_id             INTEGER,
    specialty             VARCHAR(100),
    diagnosis_group       VARCHAR(150),
    procedure_type        VARCHAR(150),
    insurance_type        VARCHAR(50),
    is_emergency           SMALLINT,
    length_of_stay_days    SMALLINT,
    cost_medicine          NUMERIC(12,2),
    cost_procedure         NUMERIC(12,2),
    total_cost              NUMERIC(12,2),
    outcome                 VARCHAR(50)
);

-- ============================================================
-- TABLAS RELACIONALES
-- ============================================================

-- ------------------------------------------------------------
-- Pacientes 
-- ------------------------------------------------------------
CREATE TABLE patients (
    patient_id      INTEGER PRIMARY KEY,
    patient_gender  VARCHAR(20)
);

-- ------------------------------------------------------------
-- Doctores
-- ------------------------------------------------------------
CREATE TABLE doctors (
    doctor_id       INTEGER PRIMARY KEY
);

-- ------------------------------------------------------------
-- Catálogo de especialidades
-- ------------------------------------------------------------
CREATE TABLE specialties (
    specialty_id    SERIAL PRIMARY KEY,
    specialty_name  VARCHAR(100)
);

-- ------------------------------------------------------------
-- Catálogo de departamentos hospitalarios 
-- ------------------------------------------------------------
CREATE TABLE departments (
    department_id   SERIAL PRIMARY KEY,
    department_name VARCHAR(100)
);

-- ------------------------------------------------------------
-- Catálogo de grupos de diagnóstico
-- ------------------------------------------------------------
CREATE TABLE diagnosis (
    diagnosis_id    SERIAL PRIMARY KEY,
    diagnosis_group VARCHAR(150)
);

-- ------------------------------------------------------------
-- Catálogo de tipos de procedimiento
-- ------------------------------------------------------------
CREATE TABLE procedures (
    procedure_id    SERIAL PRIMARY KEY,
    procedure_type  VARCHAR(150)
);

-- ------------------------------------------------------------
-- Catálogo de tipos de seguro
-- ------------------------------------------------------------
CREATE TABLE insurance_types (
    insurance_type_id    SERIAL PRIMARY KEY,
    insurance_type_name  VARCHAR(50)
);

-- ------------------------------------------------------------
-- Catálogo de ciudades
-- ------------------------------------------------------------
CREATE TABLE cities (
    city_id      SERIAL PRIMARY KEY,
    city_name    VARCHAR(100)
);

-- ============================================================
-- Visitas
-- ============================================================
CREATE TABLE visits (
    visit_id              INTEGER PRIMARY KEY,
    visit_date            DATE,

    patient_id            INTEGER REFERENCES patients(patient_id),
    patient_age           SMALLINT,
    city_id                INTEGER REFERENCES cities(city_id),
    insurance_type_id      INTEGER REFERENCES insurance_types(insurance_type_id),

    doctor_id              INTEGER REFERENCES doctors(doctor_id),
    department_id          INTEGER REFERENCES departments(department_id),
    specialty_id           INTEGER REFERENCES specialties(specialty_id),

    diagnosis_id           INTEGER REFERENCES diagnosis(diagnosis_id),
    procedure_id           INTEGER REFERENCES procedures(procedure_id),

    is_emergency           SMALLINT,
    length_of_stay_days    SMALLINT,

    cost_medicine          NUMERIC(12,2),
    cost_procedure         NUMERIC(12,2),
    total_cost              NUMERIC(12,2),

    outcome                 VARCHAR(50)
);

-- ============================================================
-- ÍNDICES para acelerar los JOIN/DISTINCT del proceso de carga y las consultas
-- ============================================================
CREATE INDEX idx_visits_patient_id    ON visits(patient_id);
CREATE INDEX idx_visits_doctor_id     ON visits(doctor_id);
CREATE INDEX idx_visits_visit_date    ON visits(visit_date);
CREATE INDEX idx_visits_diagnosis_id  ON visits(diagnosis_id);
CREATE INDEX idx_visits_procedure_id  ON visits(procedure_id);
CREATE INDEX idx_visits_specialty_id  ON visits(specialty_id);
CREATE INDEX idx_visits_department_id ON visits(department_id);



-- ============================================================
-- POBLADO DE TABLAS RELACIONALES DESDE staging_visits
-- ============================================================

-- ------------------------------------------------------------
-- 1. Ciudades
-- ------------------------------------------------------------
INSERT INTO cities (city_name)
SELECT DISTINCT city
FROM staging_visits
WHERE city IS NOT NULL;

-- ------------------------------------------------------------
-- 2. Tipos de seguro
-- ------------------------------------------------------------
INSERT INTO insurance_types (insurance_type_name)
SELECT DISTINCT insurance_type
FROM staging_visits
WHERE insurance_type IS NOT NULL;

-- ------------------------------------------------------------
-- 3. Departamentos hospitalarios
-- ------------------------------------------------------------
INSERT INTO departments (department_name)
SELECT DISTINCT hospital_department
FROM staging_visits
WHERE hospital_department IS NOT NULL;

-- ------------------------------------------------------------
-- 4. Especialidades
-- ------------------------------------------------------------
INSERT INTO specialties (specialty_name)
SELECT DISTINCT specialty
FROM staging_visits
WHERE specialty IS NOT NULL;

-- ------------------------------------------------------------
-- 5. Grupos de diagnóstico
-- ------------------------------------------------------------
INSERT INTO diagnosis (diagnosis_group)
SELECT DISTINCT diagnosis_group
FROM staging_visits
WHERE diagnosis_group IS NOT NULL;

-- ------------------------------------------------------------
-- 6. Tipos de procedimiento
-- ------------------------------------------------------------
INSERT INTO procedures (procedure_type)
SELECT DISTINCT procedure_type
FROM staging_visits
WHERE procedure_type IS NOT NULL;

-- ------------------------------------------------------------
-- 7. Pacientes
-- ------------------------------------------------------------
INSERT INTO patients (patient_id, patient_gender)
SELECT DISTINCT ON (patient_id) patient_id, patient_gender
FROM staging_visits
WHERE patient_id IS NOT NULL
ORDER BY patient_id;

-- ------------------------------------------------------------
-- 8. Doctores
-- ------------------------------------------------------------
INSERT INTO doctors (doctor_id)
SELECT DISTINCT doctor_id
FROM staging_visits
WHERE doctor_id IS NOT NULL;

-- ============================================================
-- 9. Visitas
-- ============================================================
INSERT INTO visits (
    visit_id, visit_date, patient_id, patient_age, city_id, insurance_type_id,
    doctor_id, department_id, specialty_id, diagnosis_id, procedure_id,
    is_emergency, length_of_stay_days, cost_medicine, cost_procedure, total_cost, outcome
)
SELECT
    sv.visit_id,
    sv.visit_date,
    sv.patient_id,
    sv.patient_age,
    c.city_id,
    ins.insurance_type_id,
    sv.doctor_id,
    d.department_id,
    s.specialty_id,
    dg.diagnosis_id,
    pr.procedure_id,
    sv.is_emergency,
    sv.length_of_stay_days,
    sv.cost_medicine,
    sv.cost_procedure,
    sv.total_cost,
    sv.outcome
FROM staging_visits sv
LEFT JOIN cities c           ON sv.city = c.city_name
LEFT JOIN insurance_types ins ON sv.insurance_type = ins.insurance_type_name
LEFT JOIN departments d      ON sv.hospital_department = d.department_name
LEFT JOIN specialties s      ON sv.specialty = s.specialty_name
LEFT JOIN diagnosis dg       ON sv.diagnosis_group = dg.diagnosis_group
LEFT JOIN procedures pr      ON sv.procedure_type = pr.procedure_type;
	
