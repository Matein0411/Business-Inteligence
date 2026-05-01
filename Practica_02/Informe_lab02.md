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

## Transformación
se hizo con replace in string
Estandarizacion inicial, se eliminan espacios antes y despues del string (por so both), lower case en los strings de interes
<img width="1126" height="314" alt="Screenshot 2026-04-30 223314" src="https://github.com/user-attachments/assets/25c73743-6cd3-4b6b-bc15-58fb6af14478" />
### Normalización de categorías
Se hizo con value mapper
<img width="597" height="504" alt="Screenshot 2026-04-30 224556" src="https://github.com/user-attachments/assets/41938d1d-8286-42c8-9336-7aacee3cace4" />
### Normalización de unidad de medida
Se hizo con value mapper
<img width="598" height="509" alt="Screenshot 2026-04-30 225426" src="https://github.com/user-attachments/assets/74465f66-2c9e-465e-92a5-91fdfe96a933" />
### Normalización de precio
se hizo con replace in string
Se reemplazo el simbolo $, se estandarizo el formato decimal a 0.00, 
<img width="515" height="377" alt="Screenshot 2026-04-30 230042" src="https://github.com/user-attachments/assets/02fc8b74-6d1d-41cb-8d14-fe3951a38dc7" />
ademas, se seteo el valor en number
<img width="696" height="311" alt="Screenshot 2026-04-30 230208" src="https://github.com/user-attachments/assets/e1945836-5518-4e3e-97e2-422525a93e30" />

## Carga
Se utilizo para esto una tabla productos_ferreteria_raw_new en staging mediante una sentencia sql
<img width="679" height="599" alt="Screenshot 2026-04-30 230400" src="https://github.com/user-attachments/assets/09ca9e08-6aa0-49ce-9a95-62d3851ffb67" />
flujo exitoso
<img width="793" height="369" alt="Screenshot 2026-04-30 230445" src="https://github.com/user-attachments/assets/0721627e-3f50-4d92-9dc4-f953d1dc72a5" />

# Resultados y conclusiones
<img width="900" height="516" alt="image" src="https://github.com/user-attachments/assets/3fadd7c9-7bbb-4b05-a5be-df491919f518" />



