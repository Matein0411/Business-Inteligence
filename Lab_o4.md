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

#### Creacion de tablas postgreSQL
<img width="752" height="336" alt="Screenshot 2026-05-05 185615" src="https://github.com/user-attachments/assets/e8466095-ff66-4a90-a2a8-ccc5ec550294" />

#### Cargando al; modelo de datos
<img width="996" height="540" alt="Screenshot 2026-05-05 185754" src="https://github.com/user-attachments/assets/2598914b-1bb3-40a7-84d6-6695b3c76a86" />

### Modelo estrella
<img width="1006" height="571" alt="Screenshot 2026-05-05 190020" src="https://github.com/user-attachments/assets/c877e5c4-8601-4968-8222-84ae902a6f33" />

### Diagrama modelo estrella 1 




## Tabla_Desnormalizada_Ventas.csv
### Proceso 
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
