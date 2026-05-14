-- Tabla RAW (staging)
CREATE TABLE raw_desnutrition (
    child_id VARCHAR(20),
    gender VARCHAR(10),
    age_months INT,
    weight_kg NUMERIC(6,2),
    height_cm NUMERIC(6,2),
    nutritional_status VARCHAR(50),
    region VARCHAR(100),
    institution VARCHAR(150),
    date_measured DATE
);

-- Dimensión Niño (Incluye Género y Región)
CREATE TABLE dim_child (
    child_key SERIAL PRIMARY KEY,
    child_id VARCHAR(20),
    gender VARCHAR(10),
    region VARCHAR(100)
);

-- Dimensión Institución
CREATE TABLE dim_institution (
    institution_key SERIAL PRIMARY KEY,
    institution_name VARCHAR(150)
);

-- Dimensión Diagnóstico (Estado Nutricional)
CREATE TABLE dim_diagnosis (
    diagnosis_key SERIAL PRIMARY KEY,
    nutritional_status VARCHAR(50)
);

-- Dimensión Fecha
CREATE TABLE dim_date (
    date_key DATE PRIMARY KEY,
    year INT,
    month INT,
    day INT
);

-- Tabla de Hechos
CREATE TABLE fact_desnutrition (
    fact_key SERIAL PRIMARY KEY,
    child_key INT,
    institution_key INT,
    diagnosis_key INT,
    date_key DATE,
    age_months INT,
    weight_kg NUMERIC(6,2),
    height_cm NUMERIC(6,2)
);