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

5. 

### Diagrama modelo estrella 2 
### Respuestas a las preguntas 
#### Pregunta 1
#### Pregunta 1



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
