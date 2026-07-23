-- =====================================================================
-- BASE DE DATOS: Tienda de Barrio (Quito, Ecuador)
-- Motor: PostgreSQL
-- Moneda: USD (Dólares)
-- Propósito: soporte para análisis descriptivo, dashboards en Power BI
--            y minería de datos.
-- Incluye manejo de fiados (venta a crédito), habitual en tiendas de
-- barrio: la tabla venta admite metodo_pago='fiado' (solo con cliente
-- identificado) y la tabla pago_fiado registra los abonos, lo que
-- permite calcular cuánto debe cada cliente y evaluar si es apto para
-- que se le siga fiando.
-- =====================================================================

-- =====================================================================
-- TABLA: categoria
-- Agrupa los productos en categorías generales (bebidas, snacks, etc.)
-- =====================================================================
CREATE TABLE categoria (
    id_categoria    SERIAL PRIMARY KEY,
    nombre          VARCHAR(50) NOT NULL UNIQUE,
    descripcion     VARCHAR(150)
);

-- =====================================================================
-- TABLA: producto
-- Catálogo de productos que vende la tienda.
-- =====================================================================
CREATE TABLE producto (
    id_producto         SERIAL PRIMARY KEY,
    nombre              VARCHAR(100) NOT NULL,
    id_categoria        INT NOT NULL REFERENCES categoria(id_categoria) ON DELETE RESTRICT,
    marca               VARCHAR(50),
    unidad_medida       VARCHAR(20) NOT NULL DEFAULT 'unidad'
                        CHECK (unidad_medida IN ('unidad','kg','g','litro','ml','paquete')),
    precio_compra       DECIMAL(10,2) NOT NULL CHECK (precio_compra >= 0),
    precio_venta        DECIMAL(10,2) NOT NULL CHECK (precio_venta >= 0),
    stock_actual        INT NOT NULL DEFAULT 0 CHECK (stock_actual >= 0),
    stock_minimo        INT NOT NULL DEFAULT 0 CHECK (stock_minimo >= 0),
    activo              BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_producto_categoria ON producto(id_categoria);

-- =====================================================================
-- TABLA: cliente
-- Registra clientes frecuentes. Muchas ventas no tienen cliente asociado.
-- La cedula es OPCIONAL: en la practica una tiendita de barrio suele
-- conocer y fiarle a un cliente solo por su nombre/apodo, sin pedirle
-- cedula. Cuando SI se registra, debe tener 10 digitos y ser unica
-- (UNIQUE en Postgres no considera dos NULL como iguales, asi que
-- varios clientes sin cedula conviven sin problema).
-- limite_credito es el monto maximo que el dueno esta dispuesto a fiarle;
-- se compara contra su deuda pendiente (ver tabla pago_fiado, y la vista
-- vista_saldo_cliente mas abajo) para decidir si el cliente es apto para
-- un nuevo fiado. Esto ya no queda solo como calculo manual: el trigger
-- trg_validar_limite_fiado (ver el bloque final de este archivo) lo hace
-- cumplir automaticamente al registrar una venta.
-- =====================================================================
CREATE TABLE cliente (
    id_cliente          SERIAL PRIMARY KEY,
    nombres             VARCHAR(100) NOT NULL,
    cedula              VARCHAR(10) UNIQUE CHECK (cedula IS NULL OR cedula ~ '^[0-9]{10}$'),
    telefono            VARCHAR(15),
    barrio              VARCHAR(80),
    cliente_frecuente   BOOLEAN NOT NULL DEFAULT FALSE,
    limite_credito      DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (limite_credito >= 0),
    fecha_registro      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================================
-- TABLA: proveedor
-- Información básica de los proveedores de la tienda.
-- =====================================================================
CREATE TABLE proveedor (
    id_proveedor        SERIAL PRIMARY KEY,
    nombre_empresa      VARCHAR(100) NOT NULL,
    contacto            VARCHAR(100),
    telefono            VARCHAR(15),
    direccion           VARCHAR(150),
    fecha_registro      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================================
-- TABLA: venta
-- Cabecera de cada venta realizada.
-- =====================================================================
CREATE TABLE venta (
    id_venta        SERIAL PRIMARY KEY,
    fecha_hora      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_cliente      INT REFERENCES cliente(id_cliente) ON DELETE SET NULL,
    metodo_pago     VARCHAR(20) NOT NULL
                    CHECK (metodo_pago IN ('efectivo','tarjeta','transferencia','fiado')),
    estado_venta    VARCHAR(20) NOT NULL DEFAULT 'completada'
                    CHECK (estado_venta IN ('completada','anulada')),
    total           DECIMAL(10,2) NOT NULL CHECK (total >= 0),
    -- No se puede fiar a un cliente anonimo: toda venta fiada debe
    -- tener un id_cliente identificado.
    CONSTRAINT chk_fiado_requiere_cliente
        CHECK (metodo_pago <> 'fiado' OR id_cliente IS NOT NULL)
);

CREATE INDEX idx_venta_cliente ON venta(id_cliente);
CREATE INDEX idx_venta_fecha ON venta(fecha_hora);

-- =====================================================================
-- TABLA: detalle_venta
-- Detalle de productos vendidos en cada venta.
-- =====================================================================
CREATE TABLE detalle_venta (
    id_detalle      SERIAL PRIMARY KEY,
    id_venta        INT NOT NULL REFERENCES venta(id_venta) ON DELETE CASCADE,
    id_producto     INT NOT NULL REFERENCES producto(id_producto) ON DELETE RESTRICT,
    cantidad        INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario >= 0),
    subtotal        DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0)
);

CREATE INDEX idx_detalle_venta_venta ON detalle_venta(id_venta);
CREATE INDEX idx_detalle_venta_producto ON detalle_venta(id_producto);

-- =====================================================================
-- TABLA: compra
-- Cabecera de cada compra realizada a un proveedor.
-- =====================================================================
CREATE TABLE compra (
    id_compra       SERIAL PRIMARY KEY,
    fecha_hora      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_proveedor    INT NOT NULL REFERENCES proveedor(id_proveedor) ON DELETE RESTRICT,
    total           DECIMAL(10,2) NOT NULL CHECK (total >= 0)
);

CREATE INDEX idx_compra_proveedor ON compra(id_proveedor);
CREATE INDEX idx_compra_fecha ON compra(fecha_hora);

-- =====================================================================
-- TABLA: detalle_compra
-- Detalle de productos comprados en cada compra.
-- =====================================================================
CREATE TABLE detalle_compra (
    id_detalle_compra  SERIAL PRIMARY KEY,
    id_compra          INT NOT NULL REFERENCES compra(id_compra) ON DELETE CASCADE,
    id_producto        INT NOT NULL REFERENCES producto(id_producto) ON DELETE RESTRICT,
    cantidad           INT NOT NULL CHECK (cantidad > 0),
    precio_unitario    DECIMAL(10,2) NOT NULL CHECK (precio_unitario >= 0),
    subtotal           DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0)
);

CREATE INDEX idx_detalle_compra_compra ON detalle_compra(id_compra);
CREATE INDEX idx_detalle_compra_producto ON detalle_compra(id_producto);

-- =====================================================================
-- TABLA: pago_fiado
-- Registra los abonos (pagos) que un cliente hace contra su deuda
-- acumulada de fiados. No se vincula a una venta especifica, ya que en
-- la practica el cliente abona montos parciales contra el total que
-- debe (igual que la tradicional "libreta de fiados" del tendero).
--
-- El saldo pendiente de un cliente se calcula como:
--   SUM(venta.total)      WHERE metodo_pago='fiado' AND estado_venta='completada'
--   - SUM(pago_fiado.monto)
-- agrupado por id_cliente. Ese saldo, comparado contra limite_credito,
-- permite decidir si el cliente es apto para un nuevo fiado.
-- =====================================================================
CREATE TABLE pago_fiado (
    id_pago         SERIAL PRIMARY KEY,
    id_cliente      INT NOT NULL REFERENCES cliente(id_cliente) ON DELETE RESTRICT,
    fecha_hora      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    monto           DECIMAL(10,2) NOT NULL CHECK (monto > 0),
    metodo_pago     VARCHAR(20) NOT NULL DEFAULT 'efectivo'
                    CHECK (metodo_pago IN ('efectivo','transferencia')),
    observacion     VARCHAR(150)
);

CREATE INDEX idx_pago_fiado_cliente ON pago_fiado(id_cliente);
CREATE INDEX idx_pago_fiado_fecha ON pago_fiado(fecha_hora);

-- =====================================================================
-- CONTROL DE DEUDAS / FIADO ROBUSTO
-- El saldo pendiente ya se podia calcular manualmente (ver comentario de
-- pago_fiado), pero para una tiendita real conviene automatizarlo:
--   1) fn_saldo_pendiente_cliente / vista_saldo_cliente: saldo en tiempo
--      real por cliente, sin tablas duplicadas que se puedan desincronizar.
--   2) trg_validar_limite_fiado: bloquea a nivel de base de datos una
--      venta a fiado que dejaria al cliente por encima de su limite_credito
--      (lo que el tendero hoy hace "de memoria" mirando la libreta).
--   3) vista_riesgo_fiado: semaforo heuristico (bajo/medio/alto) segun
--      % de cupo usado y dias sin abonar. Es el punto de partida para un
--      analisis de riesgo de fiado mas elaborado (ej. scoring en Python/
--      Power BI); aqui solo quedan las reglas base, no un modelo formal.
-- =====================================================================

-- ---------------------------------------------------------------------
-- Saldo pendiente por cliente (funcion + vista)
-- ---------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_saldo_pendiente_cliente(p_id_cliente INT)
RETURNS DECIMAL(10,2) AS $$
DECLARE
    v_fiado    DECIMAL(10,2);
    v_abonado  DECIMAL(10,2);
BEGIN
    SELECT COALESCE(SUM(total), 0) INTO v_fiado
    FROM venta
    WHERE id_cliente = p_id_cliente
      AND metodo_pago = 'fiado'
      AND estado_venta = 'completada';

    SELECT COALESCE(SUM(monto), 0) INTO v_abonado
    FROM pago_fiado
    WHERE id_cliente = p_id_cliente;

    RETURN v_fiado - v_abonado;
END;
$$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE VIEW vista_saldo_cliente AS
SELECT
    c.id_cliente,
    c.nombres,
    c.cedula,
    c.telefono,
    c.barrio,
    c.cliente_frecuente,
    c.limite_credito,
    COALESCE(f.total_fiado, 0)                                                     AS total_fiado,
    COALESCE(p.total_abonado, 0)                                                   AS total_abonado,
    COALESCE(f.total_fiado, 0) - COALESCE(p.total_abonado, 0)                      AS saldo_pendiente,
    c.limite_credito - (COALESCE(f.total_fiado, 0) - COALESCE(p.total_abonado, 0)) AS credito_disponible,
    f.fecha_ultima_venta_fiada,
    p.fecha_ultimo_abono
FROM cliente c
LEFT JOIN (
    SELECT id_cliente, SUM(total) AS total_fiado, MAX(fecha_hora) AS fecha_ultima_venta_fiada
    FROM venta
    WHERE metodo_pago = 'fiado' AND estado_venta = 'completada'
    GROUP BY id_cliente
) f ON f.id_cliente = c.id_cliente
LEFT JOIN (
    SELECT id_cliente, SUM(monto) AS total_abonado, MAX(fecha_hora) AS fecha_ultimo_abono
    FROM pago_fiado
    GROUP BY id_cliente
) p ON p.id_cliente = c.id_cliente;

COMMENT ON VIEW vista_saldo_cliente IS
    'Saldo de fiado en tiempo real por cliente: total fiado - total abonado. Base para el control de cupo y para el analisis de riesgo.';

-- ---------------------------------------------------------------------
-- Trigger: bloquear una venta a fiado que supere el limite de credito
-- ---------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_validar_limite_fiado()
RETURNS TRIGGER AS $$
DECLARE
    v_saldo_actual DECIMAL(10,2);
    v_limite       DECIMAL(10,2);
BEGIN
    IF NEW.metodo_pago = 'fiado' THEN
        SELECT limite_credito INTO v_limite
        FROM cliente WHERE id_cliente = NEW.id_cliente;

        v_saldo_actual := fn_saldo_pendiente_cliente(NEW.id_cliente);

        -- En un UPDATE sobre una venta que ya era fiado completada, no
        -- se debe contar dos veces su propio total.
        IF TG_OP = 'UPDATE' AND OLD.metodo_pago = 'fiado' AND OLD.estado_venta = 'completada' THEN
            v_saldo_actual := v_saldo_actual - OLD.total;
        END IF;

        IF NEW.estado_venta = 'completada' AND (v_saldo_actual + NEW.total) > v_limite THEN
            RAISE EXCEPTION
                'Fiado rechazado: cliente % ya debe %, limite %, esta venta lo llevaria a %',
                NEW.id_cliente, v_saldo_actual, v_limite, (v_saldo_actual + NEW.total);
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_validar_limite_fiado ON venta;
CREATE TRIGGER trg_validar_limite_fiado
    BEFORE INSERT OR UPDATE ON venta
    FOR EACH ROW EXECUTE FUNCTION fn_validar_limite_fiado();

-- ---------------------------------------------------------------------
-- Vista de riesgo / mora (semaforo heuristico) para clientes con deuda
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW vista_riesgo_fiado AS
SELECT
    s.*,
    CASE WHEN s.limite_credito > 0
         THEN ROUND((s.saldo_pendiente / s.limite_credito) * 100, 1)
         ELSE NULL END                                                              AS pct_utilizacion_credito,
    EXTRACT(DAY FROM (CURRENT_TIMESTAMP -
        COALESCE(s.fecha_ultimo_abono, s.fecha_ultima_venta_fiada)))::INT           AS dias_sin_abonar,
    CASE
        WHEN s.saldo_pendiente <= 0 THEN 'Sin deuda'
        WHEN s.limite_credito = 0 OR s.saldo_pendiente > s.limite_credito THEN 'Alto (excede limite)'
        WHEN (s.saldo_pendiente / NULLIF(s.limite_credito, 0)) >= 0.8 THEN 'Alto'
        WHEN (s.saldo_pendiente / NULLIF(s.limite_credito, 0)) >= 0.5 THEN 'Medio'
        ELSE 'Bajo'
    END AS nivel_riesgo
FROM vista_saldo_cliente s
WHERE s.saldo_pendiente > 0;

COMMENT ON VIEW vista_riesgo_fiado IS
    'Semaforo heuristico de riesgo por cliente con deuda activa (% de cupo usado + dias sin abonar). Punto de partida para un analisis de riesgo de fiado mas elaborado, no un score crediticio formal.';
