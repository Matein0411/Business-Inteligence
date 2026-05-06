# <center> **ESCUELA POLITÉCNICA NACIONAL** </center>

**Integrantes**
* Betancourt Alison
* Calvache Mateo
* Camacho Julián
* Villareal Alexis
* Yunga Mateo


## **Índice de Contenidos** 

1. [Products.csv](#productscsv)
   - [Modelo estrella](#modelo-estrella)
2. [Tabla_Desnormalizada_Ventas.csv](#tabla_desnormalizada_ventascsv)
   - [Normalización](#normalización)
   - [Modelo estrella](#modelo-estrella-1)
   - [Respuestas a las preguntas](#respuestas-a-las-preguntas)
     - [1. ¿Cuántas ventas se realizaron por categoría de producto y mes?](#1-cuántas-ventas-se-realizaron-por-categoría-de-producto-y-mes)
     - [2. ¿Cuál es el ingreso total (ventas) por cliente y género?](#2-cuál-es-el-ingreso-total-ventas-por-cliente-y-género)
     - [3. ¿Cuál es la cantidad total vendida por producto?](#3-cuál-es-la-cantidad-total-vendida-por-producto)
     - [4. ¿Cuál fue la cantidad enviada por mes de envío?](#4-cuál-fue-la-cantidad-enviada-por-mes-de-envío)
     - [5. ¿Cuánto se vendió por tamaño de producto y por estado civil del cliente?](#5-cuánto-se-vendió-por-tamaño-de-producto-y-por-estado-civil-del-cliente)


## Products.csv
### Proceso 

#### Datos desde postgreSQL
<p align="center">
  <img width="1919" height="1018" alt="image" src="https://github.com/user-attachments/assets/c9e5a33f-0356-4714-b96a-5a5e3d565a61" />
  <br><sub><strong>Figura 1.</strong> Vista de los datos denormalizados cargados en la tabla 'products' mediante pgAdmin. </sub>
</p>

Se muestra la importación exitosa de los 699 registros del archivo products.csv en una tabla temporal para su posterior procesamiento.


#### Creacion de tablas postgreSQL
<p align="center">
  <img width="752" height="336" alt="Screenshot 2026-05-05 185615" src="https://github.com/user-attachments/assets/e8466095-ff66-4a90-a2a8-ccc5ec550294" />
  <br><sub><strong>Figura 2.</strong> Ejecución de scripts SQL para la creación de las tablas de dimensiones y la tabla de hechos. </sub>
</p>

Definición de la estructura física del modelo mediante sentencias CREATE TABLE, estableciendo las claves primarias y relaciones necesarias.

#### Cargando al modelo de datos
<p align="center">
  <img width="996" height="540" alt="Screenshot 2026-05-05 185754" src="https://github.com/user-attachments/assets/2598914b-1bb3-40a7-84d6-6695b3c76a86" />
  <br><sub><strong>Figura 3.</strong> Incorporación de las tablas normalizadas al modelo de datos de Power Pivot para su integración. </sub>
</p>

Proceso de exportación de las tablas desde Excel hacia el complemento Power Pivot para establecer el motor analítico del modelo.

### Modelo estrella
<p align="center">
  <img width="1006" height="571" alt="Screenshot 2026-05-05 190020" src="https://github.com/user-attachments/assets/c877e5c4-8601-4968-8222-84ae902a6f33" />
  <br><sub><strong>Figura 4.</strong> Diagrama relacional del modelo estrella que conecta la tabla de hechos 'fact_products' con sus respectivas dimensiones. </sub>
</p>

Representación gráfica de las relaciones uno a muchos (1:N) entre las dimensiones de categoría y subcategoría con la tabla central de productos.

## Tabla_Desnormalizada_Ventas.csv
### Proceso 
1. Se ingresa al PGAdmin dentro del esquema public y se abre un query tool.
<p align="center">
  <img width="1118" height="1010" alt="image" src="https://github.com/user-attachments/assets/a7a92d40-8f7e-4abc-9d3c-4fc9bfa3a324" />
  <br><sub><strong>Figura 5.</strong> </sub>
</p>

2. Se crea una base para poder importar todos los datos del excel de Tabla_Desnormalizada_Ventas.csv, pero antes de crear la table base se setean las fechas para poder importar los datos del archi[...]

<p align="center">
  <img width="1291" height="575" alt="image" src="https://github.com/user-attachments/assets/3bf21df6-69b8-4f7a-bb40-b24b7e34301e" />
  <br><sub><strong>Figura 6.</strong> </sub>
</p>

<p align="center">
  <img width="1918" height="1015" alt="image" src="https://github.com/user-attachments/assets/9ecd0cdd-dee9-47df-bcb7-79dfeebf31aa" />
  <br><sub><strong>Figura 7.</strong> </sub>
</p>

3. Se importan los datos:

3.1. En la tabla creada, clic derecho para acceder a import/export data.
<p align="center">
  <img width="1162" height="1021" alt="image" src="https://github.com/user-attachments/assets/6a5b2602-8c1f-40da-b628-727f983e1d61" />
  <br><sub><strong>Figura 8.</strong> </sub>
</p>

3.2. establecer import, la extensión del archivo (csv) y el encoding (UTF8).
<p align="center">
  <img width="1478" height="825" alt="image" src="https://github.com/user-attachments/assets/a1246b20-3fd4-4284-b3a2-aedd3cefebe9" />
  <br><sub><strong>Figura 9.</strong> </sub>
</p>

3.3. en la pestaña de options se activó header y se verificó que el delimitador sea el punto y coma
<p align="center">
  <img width="1475" height="876" alt="image" src="https://github.com/user-attachments/assets/b9cadfb2-5446-4fe7-9d47-3b9e74ae8e0f" />
  <br><sub><strong>Figura 10.</strong> </sub>
</p>

3.4. Se verifica que estén las columnas especificadas
<p align="center">
  <img width="1429" height="816" alt="image" src="https://github.com/user-attachments/assets/f528e6e1-a99d-4049-9134-5dad2440fb8f" />
  <br><sub><strong>Figura 11.</strong> </sub>
</p>

3.5. Se da en ok y se ve el proceso con éxito.
<p align="center">
  <img width="1919" height="1022" alt="image" src="https://github.com/user-attachments/assets/8a67ace9-981a-4222-9e51-d33c67ece53b" />
  <br><sub><strong>Figura 12.</strong> </sub>
</p>

4. Se verificó que los datos estén
<p align="center">
  <img width="1919" height="1014" alt="image" src="https://github.com/user-attachments/assets/2ba03ffe-7bc9-49a6-938f-6adc8f7e9c9b" />
  <br><sub><strong>Figura 13.</strong> </sub>
</p>

### Normalización

5. Se crearán las tablas establecidas entre el grupo que se consideró patra el modelo estrella.

5.1. Tabla de dimensión para los productos (dim_product) junto a sus valores

```sql
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
```

<p align="center">
  <img width="1919" height="906" alt="image" src="https://github.com/user-attachments/assets/c53f93e3-0c29-4e5d-bc4d-820ca30a531a" />
  <br><sub><strong>Figura 14.</strong> </sub>
</p>

5.2. Tabla de dimensión para los clientes (dim_customer) junto a sus valores

```sql
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
```

<p align="center">
  <img width="1744" height="859" alt="image" src="https://github.com/user-attachments/assets/6a3167ed-445c-4ce4-b949-1b3cabfdc758" />
  <br><sub><strong>Figura 15.</strong> </sub>
</p>

5.3. Tabla de dimensión para la fecha (dim_date) junto a sus valores, a diferencia de las otras, esta se genera combinando todas las fechas únicas de órdenes y envíos.

```sql
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
```

<p align="center">
  <img width="1137" height="975" alt="image" src="https://github.com/user-attachments/assets/61b1af55-4a29-45e5-a4df-0ba2923cc853" />
  <br><sub><strong>Figura 16.</strong> </sub>
</p>

5.4. Tabla de hechos para el análisis

```sql
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
```

<p align="center">
  <img width="1919" height="936" alt="image" src="https://github.com/user-attachments/assets/fbc0f880-61c8-4fb3-8d3d-d8385c8f1924" />
  <br><sub><strong>Figura 17.</strong> </sub>
</p>

### Modelo estrella

Una vez definida la arquitectura estrella, se procedió a cargar las tablas en Excel y al modelo de datos de Power Pivot, con ello, se establecieron las relaciones correspondientes entre claves d[...]
<p align="center">
  <img width="1119" height="718" alt="image" src="https://github.com/user-attachments/assets/ef18d89a-6f55-41e1-a9a0-3915bc8254a2" />
  <br><sub><strong>Figura 18.</strong> </sub>
</p>

### Respuestas a las preguntas 
#### 1. ¿Cuántas ventas se realizaron por categoría de producto y mes?

```sql
SELECT p.category, d.year, d.month_name, COUNT(f.order_number) AS total_ventas
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
JOIN dim_date d ON f.order_date_key = d.date_key
GROUP BY p.category, d.year, d.month_no, d.month_name
ORDER BY d.year, d.month_no;
```

<p align="center">
  <img width="1315" height="1016" alt="image" src="https://github.com/user-attachments/assets/ba6b2c47-55d9-463b-b2e6-a8c29af8e8b7" />
  <br><sub><strong>Figura 19.</strong> </sub>
</p>

#### 2. ¿Cuál es el ingreso total (ventas) por cliente y género?

```sql
SELECT c.customer_key, c.gender, SUM(f.sales_amount) AS ingreso_total
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.gender
ORDER BY ingreso_total DESC;
```

<p align="center">
  <img width="1209" height="869" alt="image" src="https://github.com/user-attachments/assets/38481dae-1a3b-4ad5-bb17-19b3421d2c9d" />
  <br><sub><strong>Figura 20.</strong> </sub>
</p>

#### 3. ¿Cuál es la cantidad total vendida por producto?

```sql
SELECT p.product_name, SUM(f.quantity) AS cantidad_total
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY cantidad_total DESC;
```

<p align="center">
  <img width="1088" height="858" alt="image" src="https://github.com/user-attachments/assets/4d7c0e8e-752b-45a4-b2f3-a18c136caf8f" />
  <br><sub><strong>Figura 21.</strong> </sub>
</p>

#### 4. ¿Cuál fue la cantidad enviada por mes de envío?

```sql
SELECT d.year, d.month_name, SUM(f.quantity) AS cantidad_enviada
FROM fact_sales f
JOIN dim_date d ON f.ship_date_key = d.date_key
GROUP BY d.year, d.month_no, d.month_name
ORDER BY d.year, d.month_no;
```

<p align="center">
  <img width="1189" height="978" alt="image" src="https://github.com/user-attachments/assets/76f2f35f-a77f-457c-9983-461ef0ec0586" />
  <br><sub><strong>Figura 22.</strong> </sub>
</p>

#### 5. ¿Cuánto se vendió por tamaño de producto y por estado civil del cliente?

```sql
SELECT p.size, c.marital_status, SUM(f.sales_amount) AS total_vendido
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
JOIN dim_customer c ON f.customer_key = c.customer_key
GROUP BY p.size, c.marital_status;
```

<p align="center">
  <img width="1219" height="752" alt="image" src="https://github.com/user-attachments/assets/f21bb579-33a5-41d0-82e7-4137acb65877" />
  <br><sub><strong>Figura 23.</strong> </sub>
</p>

