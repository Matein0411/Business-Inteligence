# <center> **ESCUELA POLITÉCNICA NACIONAL** </center>

**Integrantes**
* Betancourt Alison
* Calvache Mateo
* Camacho Julián
* Villareal Alexis
* Yunga Mateo

# <center> Implementación de Modelo Estrella y Análisis Comercial </center>

## **Índice de Contenidos** 

1. [Introducción](#1-introducción)
2. [Fase I: Extracción, Transformación y Carga (ETL)](#2-fase-i-extracción-transformación-y-carga-etl)
  - [Análisis de la Fuente de Datos](#21-análisis-de-la-fuente-de-datos)
  - [Conversión a Tablas](#22-conversión-a-tablas)
  - [Limpieza y Eliminación de Duplicados](#23-limpieza-y-eliminación-de-duplicados)
  - [Estandarización de Nombres](#24-estandarización-de-nombres)
3. [Fase II: Diseño del Modelo Dimensional](#3-fase-ii-diseño-del-modelo-dimensional)
  - [Carga de Datos al Modelo](#31-carga-de-datos-al-modelo)
  - [Creación de la Tabla Calendario](#32-creación-de-la-tabla-calendario)
  - [Creación de la Clave de Fecha](#33-creación-de-la-clave-de-fecha)
  - [Construcción del Modelo Estrella](#34-construcción-del-modelo-estrella)
4. [Fase III: Análisis Analítico y Reportabilidad](#4-fase-iii-análisis-analítico-y-reportabilidad)
  - [Ventas por Categoría y Mes](#41-ventas-por-categoría-y-mes})
  - [Ventas por Cliente y Género](#42-ventas-por-cliente-y-género)
  - [Cantidad Vendida por Producto](#43-cantidad-vendida-por-producto)
  - [Cantidad enviada por mes](#44-cantidad-enviada-por-mes)
  - [Relación de las ventas con el tamaño del producto y el estado civil](#45-relación-de-las-ventas-con-el-tamaño-del-producto-y-el-estado-civil)
5. [Conclusiones](#5-conclusiones)

## 1. Introducción

El presente informe describe el proceso de implementación de un modelo de datos en estrella para el análisis comercial de ventas utilizando Power Pivot, el objetivo principal fue transformar una fuente de datos desnormalizada en una estructura optimizada para análisis, permitiendo responder preguntas estratégicas de negocio relacionadas con ventas, clientes, productos y logística.

### Preguntas de negocio planteadas

- ¿Cuánto se vendió por categoría y mes?
- ¿Cuánto se vendió a cada cliente según su género?
- ¿Cuál es la cantidad total vendida por producto?
- ¿Cuánta cantidad fue enviada por mes?
- ¿Cómo se relacionan las ventas con el tamaño del producto y el estado civil de los clientes?

---

# 2. Fase I: Extracción, Transformación y Carga (ETL)

## 2.1. Análisis de la Fuente de Datos

El proceso inició con una tabla desnormalizada que contenía información de ventas, clientes, productos y fechas en una sola estructura. Aunque esta organización permite almacenar toda la información en un único lugar, no es eficiente para análisis avanzados debido a la redundancia de datos y al incremento en el tamaño de la tabla.

Por esta razón, fue necesario dividir la información en tablas de dimensiones y una tabla de hechos, en un modelo estrella.

<p align="center">
  <img width="1844" height="196" alt="image" src="https://github.com/user-attachments/assets/162d870a-bea2-4084-bd12-426346218862" />
</p>

## 2.2. Conversión a Tablas

Cada conjunto de datos fue convertido a formato de tabla de Excel utilizando la opción `Ctrl + T`.

<p align="center">
  <img width="681" height="337" alt="Screenshot 2026-05-07 225054" src="https://github.com/user-attachments/assets/83298662-906a-46be-9f45-57d2c5981027" />
</p>

## 2.3. Limpieza y Eliminación de Duplicados

En las tablas dimensionales, `dim_customer` y `dim_product`, se eliminaron registros duplicados utilizando las llaves primarias correspondientes.

Este procedimiento garantizó la integridad del modelo dimensional, asegurando que cada dimensión contenga únicamente registros únicos.

<p align="center">
  <img width="473" height="269" alt="Screenshot 2026-05-07 230519" src="https://github.com/user-attachments/assets/97300c1e-302e-44b5-8fdd-3968623bbff3" />
</p>

## 2.4. Estandarización de Nombres

Se aplicó una convención de nombres para identificar claramente cada tabla según su función dentro del modelo:

### Tablas de hechos

- `fact_sales`

### Tablas de dimensiones

- `dim_customer`
- `dim_product`
- `dim_date`

<p align="center">
  <img width="1067" height="440" alt="image" src="https://github.com/user-attachments/assets/8eb0938c-e15c-4abf-9bb9-2710a3d2a1b4" />
</p>
---

# 3. Fase II: Diseño del Modelo Dimensional

## 3.1. Carga de Datos al Modelo

Una vez limpias las tablas, se cargaron al modelo de datos de Power Pivot utilizando la opción **Agregar al modelo de datos**.

<p align="center">
  <img width="1006" height="490" alt="image" src="https://github.com/user-attachments/assets/1b0f803e-2d1a-4405-8da9-10c5e7c5b717" />
</p>

## 3.2. Creación de la Tabla Calendario

Para realizar análisis temporales por mes, año y fecha, se creó una tabla calendario dentro del modelo de datos.

La tabla calendario es fundamental en modelos dimensionales porque permite:

- Agrupar ventas por períodos.
- Comparar resultados temporales.

<p align="center">
  <img width="1049" height="207" alt="image" src="https://github.com/user-attachments/assets/0239de4f-ea4b-4a4d-aa4d-db667a0976e7" />
</p>

## 3.3. Creación de la Clave de Fecha

Se creó una columna calculada denominada `Date_key`, la cual transforma las fechas a un formato numérico entero (`YYYYMMDD`) para facilitar las relaciones entre tablas.

La fórmula utilizada fue:

```DAX
Date_key = INT(FORMAT([Date], "YYYYMMDD"))
```

Esta clave fue utilizada para relacionar la dimensión calendario con la tabla de hechos.

<p align="center">
  <img width="979" height="272" alt="Screenshot 2026-05-07 233938" src="https://github.com/user-attachments/assets/90d8ea83-4168-42cd-b877-6b79015aefae" />
</p>

<p align="center">
  <img width="237" height="298" alt="Screenshot 2026-05-07 230027" src="https://github.com/user-attachments/assets/b865f606-1edb-4e54-b233-19473d0883bc" />
</p>


## 3.4. Construcción del Modelo Estrella

El modelo implementado siguió una estructura de estrella, donde:

- La tabla `fact_sales` almacena las métricas de negocio.
- Las tablas dimensionales almacenan información descriptiva.

Además, se configuraron dos relaciones de fecha:

- Relación activa con la fecha de orden.
- Relación inactiva con la fecha de envío.

Esto permitió analizar tanto ventas realizadas como envíos efectuados.

<p align="center">
  <img width="1444" height="744" alt="Screenshot 2026-05-07 230746" src="https://github.com/user-attachments/assets/7281cb68-8c8d-49f0-a303-73d6ae2764a1" />
</p>

---

# 4. Fase III: Análisis Analítico y Reportabilidad

A través de tablas dinámicas conectadas al modelo de datos se respondieron las preguntas de negocio planteadas.

<p align="center">
  <img width="1017" height="318" alt="image" src="https://github.com/user-attachments/assets/21e4248c-0120-4841-be03-f3b3a35517d8" />
</p>

## 4.1. Ventas por Categoría y Mes

**Pregunta:** ¿Cuántas ventas se realizaron por categoría de producto y mes?

Se analizaron las ventas agrupadas por categoría de producto y mes, permitiendo identificar:

- Temporadas de mayor demanda.
- Categorías con mejor rendimiento.
- Variaciones mensuales de ventas.

Este análisis ayuda a planificar inventarios y estrategias comerciales.

<p align="center">
  <img width="464" height="312" alt="Screenshot 2026-05-07 232706" src="https://github.com/user-attachments/assets/0d2941ef-6676-4886-8219-f606830aaa76" />
</p>

## 4.2. Ventas por Cliente y Género

**Pregunta:** ¿Cuál es el ingreso total (ventas) por cliente y género?

Se calculó el total vendido por cliente segmentado según género.

La consulta permitió identificar:

- Clientes con mayores ingresos generados.
- Distribución de ventas según género.

### Consulta SQL utilizada

```SQL
SELECT 
    dc.customer_name AS "NOMBRE",
    dc.gender AS "GENERO",
    SUM(fss.sales_amount) AS "VALOR VENDIDO"
FROM fact_sales fss
JOIN dim_customer dc
    ON fss.customer_key = dc.customer_key
GROUP BY dc.gender, dc.customer_key
ORDER BY dc.gender;
```

<p align="center">
  <img width="986" height="113" alt="image" src="https://github.com/user-attachments/assets/7edd9399-8059-49ce-b1b7-8353cc714823" />
</p>

## 4.3. Cantidad Vendida por Producto

**Pregunta:** ¿Cuál es la cantidad total vendida por producto?

Se calculó la cantidad total vendida por producto para identificar:

- Productos líderes.
- Productos con baja rotación.
- Comportamientos de demanda.

Este análisis es útil para control de inventarios y decisiones de abastecimiento.

<p align="center">
  <img width="275" height="246" alt="Screenshot 2026-05-07 232946" src="https://github.com/user-attachments/assets/56d36462-6f98-40d8-844c-0f02a45c8b93" />
</p>

## 4.4. Cantidad enviada por mes

**Pregunta:** ¿Cuánta cantidad fue enviada por mes?

Para analizar la cantidad enviada por mes se utilizó una relación inactiva entre la tabla de hechos y la tabla calendario.

Con el fin de activar temporalmente dicha relación, se implementó la función `USERELATIONSHIP`.

La medida desarrollada fue:

```DAX
QuantitySent =
CALCULATE(
    SUM(fact_sales[Quantity]),
    USERELATIONSHIP(
        fact_sales[ShipDateKey],
        Calendario[Date_key]
    )
)
```

<p align="center">
  <img width="1414" height="165" alt="image" src="https://github.com/user-attachments/assets/c54f162d-183b-4c99-801e-3ecc9a51fb8d" />
</p>

<p align="center">
  <img width="936" height="76" alt="Screenshot 2026-05-07 234620" src="https://github.com/user-attachments/assets/58bc990f-4870-4561-ae6f-0ac88c654a7a" />
</p>

Esta medida permitió analizar la logística de envíos utilizando la fecha de despacho en lugar de la fecha de venta.

## 4.5. Relación de las ventas con el tamaño del producto y el estado civil

**Pregunta:** ¿Cómo se relacionan las ventas con el tamaño del producto y el estado civil de los clientes?

Finalmente, se realizó un análisis cruzado entre:

- Tamaño de producto.
- Estado civil de clientes.

Este tipo de análisis permite:

- Personalizar promociones.
- Detectar perfiles de clientes.
- Optimizar estrategias comerciales.

<p align="center">
  <img width="472" height="124" alt="image" src="https://github.com/user-attachments/assets/68621bc8-5f63-4755-ba72-ba71c9adf724" />
</p>

---

# 5. Conclusiones

La implementación del modelo estrella permitió transformar una estructura desnormalizada en una solución analítica eficiente y escalable.

Entre los principales beneficios obtenidos se encuentran:

- Reducción de redundancia de datos.
- Mejora en el rendimiento de análisis.
- Capacidad de realizar segmentaciones complejas.
- Integración de análisis temporal mediante tabla calendario.
- Uso de medidas DAX avanzadas para análisis logísticos.

El uso de Power Pivot y modelado dimensional facilitó la construcción de un entorno de Business Intelligence capaz de responder preguntas estratégicas de negocio de manera rápida y eficiente.
