-- =====================================================================
-- MIGRACION: regla_asociacion
-- Persiste las reglas de asociacion (Apriori) calculadas sobre las
-- canastas de venta (detalle_venta agrupado por id_venta), para no
-- tener que recalcularlas en cada consulta desde el frontend.
-- =====================================================================
CREATE TABLE IF NOT EXISTS regla_asociacion (
    id_regla        SERIAL PRIMARY KEY,
    id_producto_antecedente INT NOT NULL REFERENCES producto(id_producto) ON DELETE CASCADE,
    id_producto_consecuente INT NOT NULL REFERENCES producto(id_producto) ON DELETE CASCADE,
    soporte         DECIMAL(6,5) NOT NULL CHECK (soporte >= 0 AND soporte <= 1),
    confianza       DECIMAL(6,5) NOT NULL CHECK (confianza >= 0 AND confianza <= 1),
    lift            DECIMAL(8,4) NOT NULL,
    fecha_calculo   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_regla_distinta CHECK (id_producto_antecedente <> id_producto_consecuente)
);

CREATE INDEX IF NOT EXISTS idx_regla_antecedente ON regla_asociacion(id_producto_antecedente);
CREATE INDEX IF NOT EXISTS idx_regla_fecha ON regla_asociacion(fecha_calculo);

COMMENT ON TABLE regla_asociacion IS
    'Reglas de asociacion (Apriori) precalculadas: antecedente -> consecuente, con soporte/confianza/lift. Se regenera via POST /sugerencias/recalcular o cron diario.';
