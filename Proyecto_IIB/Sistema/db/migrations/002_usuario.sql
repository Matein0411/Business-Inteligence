-- =====================================================================
-- MIGRACION: usuario
-- El esquema original (schema.sql) se diseno para el dashboard de Power BI
-- y no tenia usuarios del sistema. Esta tabla soporta el login del personal
-- de la tienda (dueno/vendedor) para el backend de Kipu Data.
-- =====================================================================
CREATE TABLE IF NOT EXISTS usuario (
    id_usuario       SERIAL PRIMARY KEY,
    nombre_usuario   VARCHAR(50) NOT NULL UNIQUE,
    contrasena_hash  VARCHAR(255) NOT NULL,
    nombre_completo  VARCHAR(100) NOT NULL,
    rol              VARCHAR(20) NOT NULL DEFAULT 'vendedor'
                     CHECK (rol IN ('dueno', 'vendedor')),
    activo           BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE usuario IS
    'Cuentas del personal de la tienda para autenticarse en el backend (JWT). rol=dueno puede registrar nuevos usuarios.';
