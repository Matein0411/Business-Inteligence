# <center> **ESCUELA POLITÉCNICA NACIONAL** </center>

**Integrantes**
* Betancourt Alison
* Calvache Mateo
* Camacho Julián
* Villareal Alexis
* Yunga Mateo


## **Índice de Contenidos** 

1. [Products.csv](#products.csv)
2. [Tabla_Desnormalizada_Ventas.csv](#tabla_desnormalizada_ventas.csv)


## Products.csv
### Proceso 

#### Datos desde postgreSQL
<img width="1919" height="1018" alt="image" src="https://github.com/user-attachments/assets/c9e5a33f-0356-4714-b96a-5a5e3d565a61" />

#### Creacion de tablas postgreSQL
<img width="752" height="336" alt="Screenshot 2026-05-05 185615" src="https://github.com/user-attachments/assets/e8466095-ff66-4a90-a2a8-ccc5ec550294" />

#### Cargando al; modelo de datos
<img width="996" height="540" alt="Screenshot 2026-05-05 185754" src="https://github.com/user-attachments/assets/2598914b-1bb3-40a7-84d6-6695b3c76a86" />

### Modelo estrella
<img width="1006" height="571" alt="Screenshot 2026-05-05 190020" src="https://github.com/user-attachments/assets/c877e5c4-8601-4968-8222-84ae902a6f33" />

### Diagrama modelo estrella 1 




## Tabla_Desnormalizada_Ventas.csv
### Proceso 
1. Se ingresa al PGAdmin dentro del esquema public y se abre un query tool.
<img width="1118" height="1010" alt="image" src="https://github.com/user-attachments/assets/a7a92d40-8f7e-4abc-9d3c-4fc9bfa3a324" />

2. Se crea una base para poder importar todos los datos del excel de Tabla_Desnormalizada_Ventas.csv, pero antes de crear la table base se setean las fechas para poder importar los datos del archivo.

<img width="1291" height="575" alt="image" src="https://github.com/user-attachments/assets/3bf21df6-69b8-4f7a-bb40-b24b7e34301e" />
<img width="1918" height="1015" alt="image" src="https://github.com/user-attachments/assets/9ecd0cdd-dee9-47df-bcb7-79dfeebf31aa" />

3. Se importan los datos:

3.1. En la tabla creada, clic derecho para acceder a import/export data.
<img width="1162" height="1021" alt="image" src="https://github.com/user-attachments/assets/6a5b2602-8c1f-40da-b628-727f983e1d61" />

3.2. establecer import, la extensión del archivo (csv) y el encoding (UTF8).
<img width="1478" height="825" alt="image" src="https://github.com/user-attachments/assets/a1246b20-3fd4-4284-b3a2-aedd3cefebe9" />

3.3. en la pestaña de options se activó header y se verificó que el delimitador sea el punto y coma
<img width="1475" height="876" alt="image" src="https://github.com/user-attachments/assets/b9cadfb2-5446-4fe7-9d47-3b9e74ae8e0f" />

3.4. Se verifica que estén las columnas especificadas
<img width="1429" height="816" alt="image" src="https://github.com/user-attachments/assets/f528e6e1-a99d-4049-9134-5dad2440fb8f" />

3.5. Se da en ok y se ve el proceso con éxito.
<img width="1919" height="1022" alt="image" src="https://github.com/user-attachments/assets/8a67ace9-981a-4222-9e51-d33c67ece53b" />

4. Se verificó que los datos estén
<img width="1919" height="1014" alt="image" src="https://github.com/user-attachments/assets/2ba03ffe-7bc9-49a6-938f-6adc8f7e9c9b" />

5. Se crearán las tablas establecidas entre el grupo que se consideró patra el modelo estrella.

5.1. Tabla de dimensión para los productos (dim_product) junto a sus valores

CREATE TABLE dim_product (
    product_key VARCHAR(100) PRIMARY KEY,
    product_code VARCHAR(100),
    product_name VARCHAR(200),
    list_price DECIMAL(18,2),
    color VARCHAR(50),
    size VARCHAR(50),
    category VARCHAR(100),
    subcategory VARCHAR(100)
);

INSERT INTO dim_product
SELECT DISTINCT 
    product_key, product_code, product_name, 
    CAST(list_price AS DECIMAL), 
    color, size, category, subcategory
FROM ventas;

<img width="1919" height="906" alt="image" src="https://github.com/user-attachments/assets/c53f93e3-0c29-4e5d-bc4d-820ca30a531a" />

5.2. Tabla de dimensión para los clientes (dim_customer) junto a sus valores

CREATE TABLE dim_customer (
    customer_key VARCHAR(100) PRIMARY KEY,
    birth_date DATE,
    marital_status VARCHAR(50),
    gender VARCHAR(20),
    income DECIMAL(18,2),
    children INT,
    home_owner VARCHAR(10),
    cars INT
);

INSERT INTO dim_customer
SELECT DISTINCT 
    customer_key, 
    CAST(birth_date AS DATE), 
    marital_status, 
    gender, 
    CAST(income AS DECIMAL), 
    CAST(children AS INT), 
    home_owner, 
    CAST(cars AS INT)
FROM ventas;

<img width="1744" height="859" alt="image" src="https://github.com/user-attachments/assets/6a3167ed-445c-4ce4-b949-1b3cabfdc758" />

5.3. Tabla de dimensión para la fecha (dim_date) junto a sus valores, a diferencia de las otras, esta se genera combinando todas las fechas únicas de órdenes y envíos.

CREATE TABLE dim_date (
    date_key DATE PRIMARY KEY,
    month_name VARCHAR(20),
    month_no INT,
    year INT
);

INSERT INTO dim_date
SELECT DISTINCT 
    fecha, 
    TO_CHAR(fecha, 'Month'), 
    EXTRACT(MONTH FROM fecha), 
    EXTRACT(YEAR FROM fecha)
FROM (
    SELECT CAST(order_date AS DATE) AS fecha FROM ventas
    UNION
    SELECT CAST(ship_date AS DATE) AS fecha FROM ventas
) AS t;

<img width="1137" height="975" alt="image" src="https://github.com/user-attachments/assets/61b1af55-4a29-45e5-a4df-0ba2923cc853" />

5.4. Tabla de hechos para el análisis

CREATE TABLE fact_sales (
    order_number VARCHAR(100),
    order_line_number INT,
    product_key VARCHAR(100) REFERENCES dim_product(product_key),
    customer_key VARCHAR(100) REFERENCES dim_customer(customer_key),
    order_date_key DATE REFERENCES dim_date(date_key),
    ship_date_key DATE REFERENCES dim_date(date_key),
    quantity INT,
    unit_price DECIMAL(18,2),
    product_cost DECIMAL(18,2),
    sales_amount DECIMAL(18,2),
    PRIMARY KEY (order_number, order_line_number)
);

INSERT INTO fact_sales
SELECT 
    order_number, 
    CAST(order_line_number AS INT), 
    product_key, 
    customer_key, 
    CAST(order_date AS DATE), 
    CAST(ship_date AS DATE), 
    CAST(quantity AS INT), 
    CAST(unit_price AS DECIMAL), 
    CAST(product_cost AS DECIMAL), 
    CAST(sales_amount AS DECIMAL)
FROM ventas;

<img width="1919" height="936" alt="image" src="https://github.com/user-attachments/assets/fbc0f880-61c8-4fb3-8d3d-d8385c8f1924" />

### Diagrama modelo estrella 2 

Una vez definida la arquitectura estrella, se procedió a cargar las tablas en Excel y al modelo de datos de Power Pivot, con ello, se establecieron las relaciones correspondientes entre claves de la siguiente manera:
<img width="1119" height="718" alt="image" src="https://github.com/user-attachments/assets/ef18d89a-6f55-41e1-a9a0-3915bc8254a2" />

### Respuestas a las preguntas 
#### 1. ¿Cuántas ventas se realizaron por categoría de producto y mes?

SELECT p.category, d.year, d.month_name, COUNT(f.order_number) AS total_ventas
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
JOIN dim_date d ON f.order_date_key = d.date_key
GROUP BY p.category, d.year, d.month_no, d.month_name
ORDER BY d.year, d.month_no;

<img width="1315" height="1016" alt="image" src="https://github.com/user-attachments/assets/ba6b2c47-55d9-463b-b2e6-a8c29af8e8b7" />

#### 2. ¿Cuál es el ingreso total (ventas) por cliente y género?

SELECT c.customer_key, c.gender, SUM(f.sales_amount) AS ingreso_total
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.gender
ORDER BY ingreso_total DESC;

<img width="1209" height="869" alt="image" src="https://github.com/user-attachments/assets/38481dae-1a3b-4ad5-bb17-19b3421d2c9d" />

#### 3. ¿Cuál es la cantidad total vendida por producto?

SELECT p.product_name, SUM(f.quantity) AS cantidad_total
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY cantidad_total DESC;

<img width="1088" height="858" alt="image" src="https://github.com/user-attachments/assets/4d7c0e8e-752b-45a4-b2f3-a18c136caf8f" />

#### 4. ¿Cuál fue la cantidad enviada por mes de envío?

SELECT d.year, d.month_name, SUM(f.quantity) AS cantidad_enviada
FROM fact_sales f
JOIN dim_date d ON f.ship_date_key = d.date_key
GROUP BY d.year, d.month_no, d.month_name
ORDER BY d.year, d.month_no;

<img width="1189" height="978" alt="image" src="https://github.com/user-attachments/assets/76f2f35f-a77f-457c-9983-461ef0ec0586" />

#### 5. ¿Cuánto se vendió por tamaño de producto y por estado civil del cliente?

SELECT p.size, c.marital_status, SUM(f.sales_amount) AS total_vendido
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
JOIN dim_customer c ON f.customer_key = c.customer_key
GROUP BY p.size, c.marital_status;

<img width="1219" height="752" alt="image" src="https://github.com/user-attachments/assets/f21bb579-33a5-41d0-82e7-4137acb65877" />


# Resultados y conclusiones
## Resultados

La ejecución del proceso ETL en Pentaho Data Integration se completó de manera exitosa, logrando procesar la totalidad de los registros sin errores en ninguno de los pasos del flujo.

<p align="center">
  <img width="793" height="369" alt="Screenshot 2026-04-30 230445" src="https://github.com/user-attachments/assets/0721627e-3f50-4d92-9dc4-f953d1dc72a5" />
  <br><sub><strong>Figura 12.</strong> Flujo finalizado </sub>
</p>

<img width="900" height="516" alt="image" src="https://github.com/user-attachments/assets/3fadd7c9-7bbb-4b05-a5be-df491919f518" />

Como resultado tangible, se obtuvo una tabla normalizada en PostgreSQL donde se aprecian las siguientes mejoras de calidad de datos:

* **Estandarización de Categorías:** Se unificaron términos inconsistentes (como "Htas." o "herram.") bajo la categoría única "Herramientas".
* **Limpieza de Unidades:** Se estandarizaron las presentaciones de productos (ej. de "1L" a "1 litro").
* **Conversión de Tipos de Datos:** El campo de precio fue transformado de una cadena de texto con símbolos especiales ($) a un formato numérico decimal, permitiendo cálculos matemáticos directos.

## Conclusiones

1.  **Automatización y Eficiencia:** La implementación de este proceso ETL permite que la *Ferretería El Tornillo Feliz* centralice su información de inventario de forma automática, eliminando el error humano derivado del ingreso manual de datos inconsistentes.
2.  **Integridad de la Información:** El uso de herramientas de transformación como *Value Mapper* y *Replace in String* garantizó que los datos ahora cumplan con los estándares necesarios para su análisis, asegurando que cada producto esté correctamente categorizado y valorado.
3.  **Preparación para Business Intelligence:** Con la limpieza de los campos de precio y categoría, la base de datos queda lista para alimentar tableros de visualización o reportes de ventas, facilitando una toma de decisiones basada en datos reales y confiables.
