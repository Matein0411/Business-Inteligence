# <center> **ESCUELA POLITÉCNICA NACIONAL** </center>

**Integrantes**
* Betancourt Alison
* Calvache Mateo
* Camacho Julián
* Villareal Alexis
* Yunga Mateo

## **Caso de Estudio: Ferretería El Tornillo Feliz** 

El gerente de sistemas de *El Tornillo Feliz* solicita el desarrollo de un proceso ETL que permita limpiar, unificar y cargar la información de los productos en una base de datos central PostgreSQL. La transformación deberá tomar los datos originales, estandarizarlos y almacenarlos en una nueva tabla limpia y normalizada para su posterior análisis.

### **Índice de Contenidos** 

1. [Creación de los datos](#creación-de-los-datos)
2. [Análisis de datos](#análisis-de-datos)
3. [Proceso ETL](#proceso-etl)
    * [Extracción](#extracción)
    * [Transformación](#transformación)
    * [Carga](#carga)
4. [Resultados y conclusiones](#resultados-y-conclusiones)
    * [Resultados](#resultados)
    * [Conclusiones](#conclusiones)

## Creación de los datos
Inicialmente, se procedió con la creación de la base de datos `ferreteria_feliz`. Posteriormente, dentro del esquema `staging`, se generó la tabla `productos_ferreteria_raw` para almacenar la carga inicial de los datos en bruto proporcionados por el negocio.

<p align="center">
  <img width="1594" height="892" alt="Screenshot 2026-04-30 215855" src="https://github.com/user-attachments/assets/1d747a7d-7644-4ddb-ae53-fbc7d6fb1d07" />
  <br><sub><strong>Figura 1.</strong> Creación de los datos en base de datos</sub>
</p>

## Análisis de datos
Previa a la implementación del flujo, se realizó un perfilado de la información, identificando severas oportunidades de mejora en la calidad de los registros:

**Datos inconsistentes en la columna "Categorías":** Se observó una alta varianza en la nomenclatura, incluyendo errores tipográficos, uso mixto de mayúsculas/minúsculas y abreviaturas no estandarizadas.

<p align="center">
  <img width="256" height="507" alt="image" src="https://github.com/user-attachments/assets/8bdc7ddf-2014-4963-8adc-8cc8b9edce8c" />
  <br><sub><strong>Figura 2.</strong> Datos inconsistentes en categorías</sub>
</p>

**Datos inconsistentes en la "Unidad de Medida":** Se detectaron múltiples formatos para representar una misma magnitud física o de empaque.

<p align="center">
  <img width="256" height="595" alt="image" src="https://github.com/user-attachments/assets/299a0f26-cb60-460a-8160-1b6bfa7d361f" />
  <br><sub><strong>Figura 3.</strong> Datos inconsistentes en unidad de medida</sub>
</p>

## Proceso ETL

### Extracción
Se configuró exitosamente la conexión de base de datos entre el entorno de Pentaho Data Integration y el contenedor de PostgreSQL.

<p align="center">
  <img width="800" height="748" alt="Screenshot 2026-04-30 222227" src="https://github.com/user-attachments/assets/758dcfcd-1a06-4dc9-aed9-24b792e2980a" />
  <br><sub><strong>Figura 4.</strong> Conexión de Pentaho con PostgreSQL</sub>
</p>

La ingesta de los datos iniciales hacia el flujo de transformación se ejecutó mediante el paso **Table Input**.

<p align="center">
  <img width="1443" height="657" alt="Screenshot 2026-04-30 222604" src="https://github.com/user-attachments/assets/e7c3c377-a75c-4aff-99ee-fe1fdd6ad39c" />
  <br><sub><strong>Figura 5.</strong> Carga de datos mediante Table Input</sub>
</p>

### Transformación

En esta etapa, se aplicaron diversas técnicas de limpieza y normalización para garantizar la integridad y consistencia de los datos antes de su carga final.

#### 1. Estandarización de Cadenas (String Operations)

Se realizó una limpieza inicial de los campos de texto para evitar inconsistencias por caracteres invisibles o variaciones de caja.

- Trim Type (Both): Se eliminaron espacios en blanco al inicio y al final de todos los campos de cadena.
- Lower Case: Se transformaron los campos categoria y unidad_medida a minúsculas para facilitar el mapeo posterior.

<p align="center">
  <img width="1126" height="314" alt="Screenshot 2026-04-30 223314" src="https://github.com/user-attachments/assets/25c73743-6cd3-4b6b-bc15-58fb6af14478" />
  <br><sub><strong>Figura 6.</strong> Configuración del paso String operations.</sub>
</p>

#### 2. Normalización de categorías (Value Mapper)

Para asegurar la uniformidad en el análisis, se homologaron las distintas variantes de nombres de categorías detectadas en la fuente original.

La finalidad era agrupar abreviaturas como htas. o herram., bajo un nombre de categoría estándar como herramientas. Al final se observó que  se consolidaron las categorías en: Herramientas, Pinturas, Ferretería y Adhesivos.

<p align="center">
  <img width="597" height="504" alt="Screenshot 2026-04-30 224556" src="https://github.com/user-attachments/assets/41938d1d-8286-42c8-9336-7aacee3cace4" />
  <br><sub><strong>Figura 7.</strong> Configuración del paso Value mapper para Categoría.</sub>
</p>

#### 3. Normalización de Unidades de Medida (Value Mapper)

Se estandarizaron las unidades de medida para permitir comparaciones directas entre productos.

- Conversión de términos técnicos y abreviaturas (ej. "1 und", "1u", "cj", "1 lt") a un formato descriptivo completo (ej. "1 Unidad", "Caja", "1 Litro").
- Mejoró la legibilidad del catálogo y facilitó el control de inventarios.

<p align="center">
  <img width="598" height="509" alt="Screenshot 2026-04-30 225426" src="https://github.com/user-attachments/assets/74465f66-2c9e-465e-92a5-91fdfe96a933" />
  <br><sub><strong>Figura 8.</strong> Configuración del paso Value mapper para Unidad de medida.</sub>
</p>

#### 4. Limpieza y Tipado de Precio (Replace in String & Select Values)

El tratamiento del campo precio_unitario se realizó en dos fases críticas para permitir operaciones matemáticas posteriores:

1. Limpieza de Símbolos: Se utilizó una operación de reemplazo para eliminar el símbolo de moneda ($), dejando únicamente la cadena numérica.

<p align="center">
  <img width="515" height="377" alt="Screenshot 2026-04-30 230042" src="https://github.com/user-attachments/assets/02fc8b74-6d1d-41cb-8d14-fe3951a38dc7" />
  <br><sub><strong>Figura 9.</strong> Configuración del paso Replace in string para el precio.</sub>
</p>

2. Conversión: A través del paso Select Values, se cambió el tipo de dato de String a Number y se estandarizó el formato decimal a 0.00.

<p align="center">
  <img width="696" height="311" alt="Screenshot 2026-04-30 230208" src="https://github.com/user-attachments/assets/e1945836-5518-4e3e-97e2-422525a93e30" />
  <br><sub><strong>Figura 10.</strong> Configuración del paso Select values.</sub>
</p>


### Carga
Para recibir los resultados de los datos transformados, se creó la tabla `productos_ferreteria_raw_new` usando el esquema staging. 

<p align="center">
  <img width="679" height="599" alt="Screenshot 2026-04-30 230400" src="https://github.com/user-attachments/assets/09ca9e08-6aa0-49ce-9a95-62d3851ffb67" />
  <br><sub><strong>Figura 11.</strong> Carga de datos transformados. </sub>
</p>

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


