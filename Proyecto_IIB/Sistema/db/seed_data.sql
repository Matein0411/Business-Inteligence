-- =====================================================================
-- DATOS DE PRUEBA (INSERT) — Tienda de Barrio (Quito, Ecuador)
-- Motor: PostgreSQL
-- Complemento del script tienda_barrio_schema.sql
--
-- Estos datos son SINTÉTICOS: no provienen de una tienda real ni de
-- transacciones reales. Fueron construidos para reflejar patrones de
-- consumo, marcas, proveedores y sectores de Quito documentados en
-- fuentes públicas verificables, entre ellas:
--
--  - Dichter & Neira (vía Vistazo, abr. 2022 y El Universo, nov. 2021):
--    gaseosas, snacks y agua embotellada como categorías con más
--    transacciones en tiendas de barrio de Ecuador; miércoles como día
--    de mayor transaccionalidad en la Sierra; ticket promedio bajo
--    (entre 1 y 2 productos por compra).
--  - INEC, Informe de Canastas Analíticas 2026: referencia de precios
--    de productos de primera necesidad (arroz, azúcar, aceite, leche).
--  - Marcas reales del canal tradicional en Ecuador (Coca-Cola, Pilsener/
--    Club Premium de Cervecera Nacional, Toni, Nestlé, Frito Lay, entre
--    otras) y esquema de distribución directa (DSD) típico de bebidas
--    y lácteos frente a distribución mayorista para el resto de abarrotes.
--  - Barrios reales de los sectores norte, centro y sur de Quito
--    (Wikipedia "Barrios de Quito"; ecuadorec.com).
--
-- Los PRECIOS por producto son estimaciones razonables de mercado y
-- NO constituyen cifras oficiales exactas por SKU. Los CLIENTES,
-- VENTAS y COMPRAS son ficticios y sirven únicamente para pruebas de
-- analítica y Business Intelligence.
-- =====================================================================

-- =====================================================================
-- DATOS DE PRUEBA: Tienda de Barrio (Quito, Ecuador)
-- Basado en tendencias reales del canal tradicional en Ecuador:
--  - Gaseosas, snacks y agua embotellada como categorias de mayor rotacion
--    (Dichter & Neira / El Universo, 2021-2022).
--  - Miercoles y fines de semana como dias de mayor transaccionalidad
--    en la region Sierra (Dichter & Neira via Vistazo, 2022).
--  - Ticket promedio bajo (1 a 2 productos por compra), pago mayoritario
--    en efectivo, propio del canal tradicional ecuatoriano.
--  - Precios de productos basados en rangos de mercado y el informe de
--    Canasta Basica del INEC (2026); son estimaciones, no cifras oficiales
--    exactas por producto.
--  - Barrios de clientes tomados de la division real de sectores de Quito
--    (norte, centro y sur).
-- =====================================================================

-- ---------------------------------------------------------------------
-- CATEGORIA
-- ---------------------------------------------------------------------
INSERT INTO categoria (id_categoria, nombre, descripcion) VALUES (1, 'Bebidas', 'Gaseosas, cerveza, agua embotellada y bebidas hidratantes');
INSERT INTO categoria (id_categoria, nombre, descripcion) VALUES (2, 'Snacks', 'Papas fritas, chifles y snacks salados');
INSERT INTO categoria (id_categoria, nombre, descripcion) VALUES (3, 'Lacteos', 'Leche, yogurt, queso y mantequilla');
INSERT INTO categoria (id_categoria, nombre, descripcion) VALUES (4, 'Abarrotes', 'Arroz, azucar, aceite, sal, fideo, cafe, pan y huevos');
INSERT INTO categoria (id_categoria, nombre, descripcion) VALUES (5, 'Enlatados', 'Atun, sardina y conservas');
INSERT INTO categoria (id_categoria, nombre, descripcion) VALUES (6, 'Productos de Limpieza', 'Detergentes, jabon de ropa, cloro y papel higienico');
INSERT INTO categoria (id_categoria, nombre, descripcion) VALUES (7, 'Higiene Personal', 'Jabon de bano, shampoo, pasta dental y desodorante');
INSERT INTO categoria (id_categoria, nombre, descripcion) VALUES (8, 'Confites', 'Chocolates, caramelos y chicles');

-- ---------------------------------------------------------------------
-- PROVEEDOR
-- ---------------------------------------------------------------------
INSERT INTO proveedor (id_proveedor, nombre_empresa, contacto, telefono, direccion) VALUES (1, 'Nestle Ecuador S.A.', 'Ventas Canal Tradicional', '022460000', 'Av. Eloy Alfaro, Quito');
INSERT INTO proveedor (id_proveedor, nombre_empresa, contacto, telefono, direccion) VALUES (2, 'Arca Continental Ecuador (Coca-Cola)', 'Distribucion Zona Quito', '022980000', 'Av. Galo Plaza Lasso, Quito');
INSERT INTO proveedor (id_proveedor, nombre_empresa, contacto, telefono, direccion) VALUES (3, 'Cervecera Nacional CN S.A.', 'Ventas Canal Tradicional', '023980000', 'Av. Amazonas, Quito');
INSERT INTO proveedor (id_proveedor, nombre_empresa, contacto, telefono, direccion) VALUES (4, 'Toni S.A.', 'Distribucion Sierra Norte', '022670000', 'Panamericana Norte km 7.5, Quito');
INSERT INTO proveedor (id_proveedor, nombre_empresa, contacto, telefono, direccion) VALUES (5, 'Distribuidora Mayorista de Consumo Masivo Quito', 'Ventas Mayoristas', '022550000', 'Mercado Mayorista, Quito');

-- ---------------------------------------------------------------------
-- PRODUCTO
-- ---------------------------------------------------------------------
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (1, 'Coca-Cola 500ml', 1, 'Coca-Cola', 'unidad', 0.55, 0.75, 60, 15, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (2, 'Coca-Cola 1L', 1, 'Coca-Cola', 'unidad', 0.85, 1.10, 40, 10, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (3, 'Agua Cielo 600ml', 1, 'Cielo', 'unidad', 0.30, 0.50, 60, 15, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (4, 'Pilsener Lata 355ml', 1, 'Pilsener', 'unidad', 0.85, 1.15, 48, 12, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (5, 'Club Premium Botella 600ml', 1, 'Club Premium', 'unidad', 1.10, 1.50, 24, 6, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (6, 'Doritos Nacho 46g', 2, 'Frito Lay', 'unidad', 0.55, 0.80, 40, 10, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (7, 'Ruffles Original 42g', 2, 'Frito Lay', 'unidad', 0.55, 0.80, 35, 10, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (8, 'Cheetos Mix 40g', 2, 'Frito Lay', 'unidad', 0.50, 0.75, 40, 10, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (9, 'Chifles de Platano 30g', 2, 'K''Rico', 'unidad', 0.40, 0.60, 25, 8, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (10, 'Yupi Sal 30g', 2, 'Yupi', 'unidad', 0.30, 0.50, 30, 8, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (11, 'Leche Toni Entera 1L', 3, 'Toni', 'litro', 0.85, 1.05, 30, 10, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (12, 'Yogurt Toni 200ml', 3, 'Toni', 'unidad', 0.45, 0.65, 30, 10, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (13, 'Queso Fresco El Ranchito 500g', 3, 'El Ranchito', 'unidad', 2.20, 3.00, 15, 5, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (14, 'Mantequilla La Holandesa 250g', 3, 'La Holandesa', 'unidad', 1.60, 2.10, 12, 4, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (15, 'Arroz Gustadina 2kg', 4, 'Gustadina', 'kg', 1.85, 2.30, 40, 10, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (16, 'Azucar San Carlos 2kg', 4, 'San Carlos', 'kg', 1.60, 2.00, 35, 10, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (17, 'Aceite La Favorita 1L', 4, 'La Favorita', 'litro', 2.10, 2.60, 30, 8, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (18, 'Sal Refisal 500g', 4, 'Refisal', 'unidad', 0.35, 0.55, 25, 8, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (19, 'Fideo Oriental 400g', 4, 'Oriental', 'unidad', 0.65, 0.90, 30, 8, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (20, 'Cafe Nescafe Sachet 25g', 4, 'Nescafe', 'unidad', 0.20, 0.30, 50, 15, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (21, 'Pan de Sal (unidad)', 4, 'Panaderia local', 'unidad', 0.10, 0.15, 100, 30, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (22, 'Huevos Indaves cubeta 30u', 4, 'Indaves', 'unidad', 4.20, 5.20, 8, 3, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (23, 'Atun Real en Aceite 140g', 5, 'Real', 'unidad', 0.95, 1.30, 30, 8, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (24, 'Atun Van Camp''s 174g', 5, 'Van Camp''s', 'unidad', 1.10, 1.45, 25, 8, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (25, 'Sardina Isabel 425g', 5, 'Isabel', 'unidad', 1.40, 1.85, 20, 6, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (26, 'Salsa de Tomate Los Andes 400g', 5, 'Los Andes', 'unidad', 1.00, 1.35, 20, 6, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (27, 'Detergente Deja 1kg', 6, 'Deja', 'kg', 2.40, 3.00, 20, 6, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (28, 'Jabon de Ropa Leon 250g', 6, 'Leon', 'unidad', 0.55, 0.80, 25, 8, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (29, 'Cloro Ayudin 1L', 6, 'Ayudin', 'litro', 1.20, 1.60, 20, 6, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (30, 'Papel Higienico Scott x4', 6, 'Scott', 'unidad', 1.90, 2.50, 25, 8, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (31, 'Jabon de Bano Palmolive 120g', 7, 'Palmolive', 'unidad', 0.60, 0.90, 30, 8, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (32, 'Shampoo Sedal 350ml', 7, 'Sedal', 'unidad', 2.20, 2.90, 15, 5, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (33, 'Pasta Dental Colgate 75ml', 7, 'Colgate', 'unidad', 1.30, 1.75, 20, 6, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (34, 'Desodorante Rexona 150ml', 7, 'Rexona', 'unidad', 2.50, 3.20, 15, 5, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (35, 'Chocolate Manicho', 8, 'Nestle', 'unidad', 0.35, 0.55, 40, 10, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (36, 'Caramelos Ambrosoli surtido 100u', 8, 'Ambrosoli', 'unidad', 2.50, 3.50, 15, 5, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (37, 'Chicles Trident', 8, 'Trident', 'unidad', 0.30, 0.50, 30, 8, TRUE);
INSERT INTO producto (id_producto, nombre, id_categoria, marca, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, activo) VALUES (38, 'Bon Bon Bum', 8, 'Colombina', 'unidad', 0.10, 0.20, 60, 15, TRUE);

-- ---------------------------------------------------------------------
-- CLIENTE
-- ---------------------------------------------------------------------
-- NOTA: cedula es OPCIONAL en el esquema (tienda_barrio_schema.sql).
-- En la practica el tendero solo pide cedula a los clientes de confianza
-- a quienes les fia; a los clientes ocasionales (cliente_frecuente =
-- FALSE) no se la exige, por eso quedan con cedula = NULL abajo.
INSERT INTO cliente (id_cliente, nombres, cedula, telefono, barrio, cliente_frecuente) VALUES (1, 'Maria Elena Chuquimarca', '1712345671', '0991234501', 'La Mariscal', TRUE);
INSERT INTO cliente (id_cliente, nombres, cedula, telefono, barrio, cliente_frecuente) VALUES (2, 'Jose Luis Toapanta', '1712345672', '0991234502', 'Cotocollao', TRUE);
INSERT INTO cliente (id_cliente, nombres, cedula, telefono, barrio, cliente_frecuente) VALUES (3, 'Rosa Amparo Quishpe', '1712345673', '0991234503', 'Carcelen', TRUE);
INSERT INTO cliente (id_cliente, nombres, telefono, barrio, cliente_frecuente) VALUES (4, 'Carlos Andrade', '0991234504', 'El Condado', FALSE);
INSERT INTO cliente (id_cliente, nombres, cedula, telefono, barrio, cliente_frecuente) VALUES (5, 'Lucia Fernanda Vaca', '1712345675', '0991234505', 'Ponceano', TRUE);
INSERT INTO cliente (id_cliente, nombres, telefono, barrio, cliente_frecuente) VALUES (6, 'Segundo Manuel Cuji', '0991234506', 'La Magdalena', FALSE);
INSERT INTO cliente (id_cliente, nombres, cedula, telefono, barrio, cliente_frecuente) VALUES (7, 'Blanca Isabel Tipan', '1712345677', '0991234507', 'Chillogallo', TRUE);
INSERT INTO cliente (id_cliente, nombres, cedula, telefono, barrio, cliente_frecuente) VALUES (8, 'Angel Patricio Simbana', '1712345678', '0991234508', 'Solanda', TRUE);
INSERT INTO cliente (id_cliente, nombres, telefono, barrio, cliente_frecuente) VALUES (9, 'Gladys Beatriz Morocho', '0991234509', 'Quitumbe', FALSE);
INSERT INTO cliente (id_cliente, nombres, cedula, telefono, barrio, cliente_frecuente) VALUES (10, 'Wilson Fabian Guaman', '1712345680', '0991234510', 'Comite del Pueblo', TRUE);
INSERT INTO cliente (id_cliente, nombres, telefono, barrio, cliente_frecuente) VALUES (11, 'Silvia Marlene Pilamunga', '0991234511', 'La Argelia', FALSE);
INSERT INTO cliente (id_cliente, nombres, cedula, telefono, barrio, cliente_frecuente) VALUES (12, 'Edison Javier Chicaiza', '1712345682', '0991234512', 'Turubamba', TRUE);
INSERT INTO cliente (id_cliente, nombres, telefono, barrio, cliente_frecuente) VALUES (13, 'Nancy Elizabeth Yugcha', '0991234513', 'San Bartolo', FALSE);
INSERT INTO cliente (id_cliente, nombres, cedula, telefono, barrio, cliente_frecuente) VALUES (14, 'Fausto Ramiro Ushina', '1712345684', '0991234514', 'La Ferroviaria', TRUE);
INSERT INTO cliente (id_cliente, nombres, telefono, barrio, cliente_frecuente) VALUES (15, 'Diana Carolina Male', '0991234515', 'Centro Historico', FALSE);
-- ---------------------------------------------------------------------
-- COMPRA / DETALLECOMPRA
-- Reabastecimientos durante julio 2026 (2 a 3 por proveedor)
-- ---------------------------------------------------------------------
INSERT INTO compra (id_compra, fecha_hora, id_proveedor, total) VALUES (1, '2026-07-02 10:15:00', 1, 8.30);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (1, 1, 20, 24, 0.20, 4.80);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (2, 1, 35, 10, 0.35, 3.50);
INSERT INTO compra (id_compra, fecha_hora, id_proveedor, total) VALUES (2, '2026-07-09 10:00:00', 1, 11.00);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (3, 2, 20, 20, 0.20, 4.00);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (4, 2, 35, 20, 0.35, 7.00);
INSERT INTO compra (id_compra, fecha_hora, id_proveedor, total) VALUES (3, '2026-07-02 08:15:00', 2, 22.30);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (5, 3, 3, 24, 0.30, 7.20);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (6, 3, 2, 10, 0.85, 8.50);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (7, 3, 1, 12, 0.55, 6.60);
INSERT INTO compra (id_compra, fecha_hora, id_proveedor, total) VALUES (4, '2026-07-09 08:45:00', 2, 24.45);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (8, 4, 1, 15, 0.55, 8.25);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (9, 4, 3, 20, 0.30, 6.00);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (10, 4, 2, 12, 0.85, 10.20);
INSERT INTO compra (id_compra, fecha_hora, id_proveedor, total) VALUES (5, '2026-07-02 08:30:00', 3, 23.75);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (11, 5, 4, 15, 0.85, 12.75);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (12, 5, 5, 10, 1.10, 11.00);
INSERT INTO compra (id_compra, fecha_hora, id_proveedor, total) VALUES (6, '2026-07-09 08:00:00', 3, 33.50);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (13, 6, 5, 15, 1.10, 16.50);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (14, 6, 4, 20, 0.85, 17.00);
INSERT INTO compra (id_compra, fecha_hora, id_proveedor, total) VALUES (7, '2026-07-02 11:30:00', 4, 30.90);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (15, 7, 11, 30, 0.85, 25.50);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (16, 7, 12, 12, 0.45, 5.40);
INSERT INTO compra (id_compra, fecha_hora, id_proveedor, total) VALUES (8, '2026-07-09 08:30:00', 4, 27.15);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (17, 8, 12, 15, 0.45, 6.75);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (18, 8, 11, 24, 0.85, 20.40);
INSERT INTO compra (id_compra, fecha_hora, id_proveedor, total) VALUES (9, '2026-07-02 08:00:00', 5, 161.10);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (19, 9, 13, 10, 2.20, 22.00);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (20, 9, 33, 30, 1.30, 39.00);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (21, 9, 18, 10, 0.35, 3.50);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (22, 9, 10, 24, 0.30, 7.20);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (23, 9, 24, 24, 1.10, 26.40);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (24, 9, 22, 15, 4.20, 63.00);
INSERT INTO compra (id_compra, fecha_hora, id_proveedor, total) VALUES (10, '2026-07-09 10:30:00', 5, 207.50);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (25, 10, 27, 20, 2.40, 48.00);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (26, 10, 34, 30, 2.50, 75.00);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (27, 10, 23, 30, 0.95, 28.50);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (28, 10, 8, 10, 0.50, 5.00);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (29, 10, 37, 10, 0.30, 3.00);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (30, 10, 16, 30, 1.60, 48.00);
INSERT INTO compra (id_compra, fecha_hora, id_proveedor, total) VALUES (11, '2026-07-16 10:45:00', 5, 47.90);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (31, 11, 31, 10, 0.60, 6.00);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (32, 11, 21, 20, 0.10, 2.00);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (33, 11, 38, 15, 0.10, 1.50);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (34, 11, 30, 12, 1.90, 22.80);
INSERT INTO detalle_compra (id_detalle_compra, id_compra, id_producto, cantidad, precio_unitario, subtotal) VALUES (35, 11, 19, 24, 0.65, 15.60);

-- ---------------------------------------------------------------------
-- VENTA / DETALLEVENTA
-- Periodo: 1 al 21 de julio de 2026
-- ---------------------------------------------------------------------
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (1, '2026-07-01 08:15:00', NULL, 'efectivo', 'completada', 4.30);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (1, 1, 15, 1, 2.30, 2.30);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (2, 1, 16, 1, 2.00, 2.00);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (2, '2026-07-01 08:15:00', 7, 'transferencia', 'completada', 1.55);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (3, 2, 4, 1, 1.15, 1.15);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (4, 2, 38, 2, 0.20, 0.40);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (3, '2026-07-01 09:40:00', 5, 'efectivo', 'completada', 1.10);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (5, 3, 3, 1, 0.50, 0.50);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (6, 3, 9, 1, 0.60, 0.60);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (4, '2026-07-01 13:30:00', NULL, 'efectivo', 'completada', 1.75);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (7, 4, 33, 1, 1.75, 1.75);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (5, '2026-07-08 13:30:00', NULL, 'efectivo', 'completada', 2.50);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (8, 5, 4, 2, 1.15, 2.30);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (9, 5, 38, 1, 0.20, 0.20);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (6, '2026-07-08 13:30:00', NULL, 'efectivo', 'completada', 1.05);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (10, 6, 11, 1, 1.05, 1.05);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (7, '2026-07-08 12:10:00', NULL, 'efectivo', 'completada', 4.10);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (11, 7, 2, 1, 1.10, 1.10);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (12, 7, 5, 2, 1.50, 3.00);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (8, '2026-07-08 09:40:00', NULL, 'tarjeta', 'completada', 4.30);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (13, 8, 15, 1, 2.30, 2.30);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (14, 8, 16, 1, 2.00, 2.00);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (9, '2026-07-15 13:30:00', NULL, 'efectivo', 'completada', 1.95);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (15, 9, 31, 1, 0.90, 0.90);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (16, 9, 11, 1, 1.05, 1.05);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (10, '2026-07-15 16:45:00', NULL, 'efectivo', 'completada', 1.20);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (17, 10, 11, 1, 1.05, 1.05);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (18, 10, 21, 1, 0.15, 0.15);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (11, '2026-07-15 16:45:00', NULL, 'efectivo', 'completada', 7.50);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (19, 11, 22, 1, 5.20, 5.20);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (20, 11, 15, 1, 2.30, 2.30);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (12, '2026-07-15 16:45:00', NULL, 'tarjeta', 'completada', 8.30);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (21, 12, 15, 1, 2.30, 2.30);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (22, 12, 13, 2, 3.00, 6.00);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (13, '2026-07-04 12:10:00', NULL, 'tarjeta', 'completada', 0.60);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (23, 13, 20, 1, 0.30, 0.30);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (24, 13, 21, 2, 0.15, 0.30);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (14, '2026-07-04 19:50:00', NULL, 'tarjeta', 'completada', 2.30);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (25, 14, 15, 1, 2.30, 2.30);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (15, '2026-07-04 08:15:00', 5, 'efectivo', 'anulada', 1.20);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (26, 15, 11, 1, 1.05, 1.05);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (27, 15, 21, 1, 0.15, 0.15);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (16, '2026-07-05 19:50:00', NULL, 'transferencia', 'completada', 3.00);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (28, 16, 2, 2, 1.10, 2.20);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (29, 16, 7, 1, 0.80, 0.80);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (17, '2026-07-05 08:15:00', NULL, 'tarjeta', 'completada', 0.80);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (30, 17, 6, 1, 0.80, 0.80);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (18, '2026-07-05 09:40:00', NULL, 'efectivo', 'completada', 2.20);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (31, 18, 31, 1, 0.90, 0.90);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (32, 18, 23, 1, 1.30, 1.30);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (19, '2026-07-11 08:15:00', 15, 'efectivo', 'completada', 3.00);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (33, 19, 13, 1, 3.00, 3.00);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (20, '2026-07-11 08:15:00', 5, 'efectivo', 'completada', 4.90);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (34, 20, 4, 2, 1.15, 2.30);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (35, 20, 23, 2, 1.30, 2.60);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (21, '2026-07-11 19:50:00', NULL, 'efectivo', 'completada', 4.30);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (36, 21, 15, 1, 2.30, 2.30);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (37, 21, 16, 1, 2.00, 2.00);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (22, '2026-07-12 19:50:00', 3, 'efectivo', 'completada', 3.50);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (38, 22, 21, 2, 0.15, 0.30);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (39, 22, 34, 1, 3.20, 3.20);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (23, '2026-07-12 16:45:00', 1, 'efectivo', 'completada', 3.10);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (40, 23, 5, 1, 1.50, 1.50);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (41, 23, 29, 1, 1.60, 1.60);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (24, '2026-07-12 18:20:00', 12, 'efectivo', 'completada', 6.10);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (42, 24, 17, 1, 2.60, 2.60);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (43, 24, 36, 1, 3.50, 3.50);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (25, '2026-07-18 19:50:00', NULL, 'efectivo', 'completada', 2.00);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (44, 25, 16, 1, 2.00, 2.00);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (26, '2026-07-18 13:30:00', 2, 'transferencia', 'completada', 3.10);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (45, 26, 10, 1, 0.50, 0.50);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (46, 26, 17, 1, 2.60, 2.60);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (27, '2026-07-18 13:30:00', 11, 'transferencia', 'completada', 4.50);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (47, 27, 19, 2, 0.90, 1.80);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (48, 27, 26, 2, 1.35, 2.70);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (28, '2026-07-19 12:10:00', NULL, 'efectivo', 'completada', 5.20);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (49, 28, 22, 1, 5.20, 5.20);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (29, '2026-07-19 16:45:00', NULL, 'efectivo', 'completada', 1.50);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (50, 29, 1, 1, 0.75, 0.75);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (51, 29, 8, 1, 0.75, 0.75);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (30, '2026-07-19 08:15:00', 3, 'efectivo', 'completada', 2.60);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (52, 30, 17, 1, 2.60, 2.60);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (31, '2026-07-02 13:30:00', 13, 'efectivo', 'completada', 1.30);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (53, 31, 12, 2, 0.65, 1.30);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (32, '2026-07-03 08:15:00', 2, 'transferencia', 'completada', 2.25);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (54, 32, 1, 2, 0.75, 1.50);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (55, 32, 8, 1, 0.75, 0.75);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (33, '2026-07-06 12:10:00', NULL, 'efectivo', 'completada', 2.25);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (56, 33, 19, 1, 0.90, 0.90);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (57, 33, 26, 1, 1.35, 1.35);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (34, '2026-07-07 09:40:00', 7, 'efectivo', 'completada', 1.60);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (58, 34, 29, 1, 1.60, 1.60);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (35, '2026-07-09 12:10:00', 7, 'efectivo', 'completada', 3.55);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (59, 35, 33, 1, 1.75, 1.75);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (60, 35, 31, 2, 0.90, 1.80);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (36, '2026-07-10 08:15:00', NULL, 'efectivo', 'completada', 2.05);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (61, 36, 33, 1, 1.75, 1.75);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (62, 36, 20, 1, 0.30, 0.30);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (37, '2026-07-13 12:10:00', 15, 'efectivo', 'completada', 1.15);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (63, 37, 4, 1, 1.15, 1.15);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (38, '2026-07-14 08:15:00', 9, 'efectivo', 'completada', 4.90);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (64, 38, 15, 1, 2.30, 2.30);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (65, 38, 17, 1, 2.60, 2.60);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (39, '2026-07-16 18:20:00', NULL, 'efectivo', 'completada', 0.65);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (66, 39, 12, 1, 0.65, 0.65);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (40, '2026-07-17 12:10:00', NULL, 'efectivo', 'anulada', 2.80);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (67, 40, 16, 1, 2.00, 2.00);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (68, 40, 3, 1, 0.50, 0.50);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (69, 40, 20, 1, 0.30, 0.30);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (41, '2026-07-20 09:40:00', 12, 'efectivo', 'completada', 0.75);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (70, 41, 1, 1, 0.75, 0.75);
INSERT INTO venta (id_venta, fecha_hora, id_cliente, metodo_pago, estado_venta, total) VALUES (42, '2026-07-21 12:10:00', NULL, 'efectivo', 'completada', 0.30);
INSERT INTO detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (71, 42, 20, 1, 0.30, 0.30);

-- ---------------------------------------------------------------------
-- Reinicio de secuencias SERIAL para futuras inserciones
-- ---------------------------------------------------------------------
SELECT setval('categoria_id_categoria_seq', 8, true);
SELECT setval('proveedor_id_proveedor_seq', 5, true);
SELECT setval('producto_id_producto_seq', 38, true);
SELECT setval('cliente_id_cliente_seq', 15, true);
SELECT setval('compra_id_compra_seq', 11, true);
SELECT setval('detalle_compra_id_detalle_compra_seq', 35, true);
SELECT setval('venta_id_venta_seq', 42, true);
SELECT setval('detalle_venta_id_detalle_seq', 71, true);
