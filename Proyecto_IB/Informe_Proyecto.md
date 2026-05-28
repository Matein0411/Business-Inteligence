# <center> **ESCUELA POLITÉCNICA NACIONAL** </center>
# <center> **Proyecto I Bimestre** </center>

**Integrantes**
* Betancourt Alison
* Calvache Mateo
* Camacho Julián
* Villareal Alexis
* Yunga Mateo

## **Índice de Contenidos**

1. [El problema y la solución](#el-problema-y-la-solución)
2. [Justificación del diseño](#justificación-del-diseño)
3. [Proceso ETL](#proceso-etl)
	- [dim_establecimiento](#dim_establecimiento)
	- [dim_diagnostico](#dim_diagnostico)
	- [dim_residencia](#dim_residencia)
	- [dim_paciente](#dim_paciente)
	- [fact_camas_hospitalarias](#fact_camas_hospitalarias)
	- [fact_egresos_hospitalarios](#fact_egresos_hospitalarios)
4. [Análisis de insights clave obtenidos (OLAP)](#análisis-de-insights-clave-obtenidos-olap)
5. [Recomendaciones al negocio](#recomendaciones-al-negocio)

## El problema y la solución
### Problema:
El sistema de salud en el Ecuador sufre constantemente por hospitales colapsados y salas de emergencia saturadas. Para gestionar esta crisis, no basta con saber cuántas camas existen, sino que es obligatorio cruzar esa capacidad con la demanda real de pacientes, representada en los egresos hospitalarios. Aunque el INEC tiene un dashboard público con estos datos, solo muestra resúmenes generales a gran escala (por provincias o a nivel nacional). El problema real es que esta información macro no les sirve a los coordinadores locales de salud, quienes necesitan ver la realidad de su zona para identificar qué hospitales específicos están recibiendo un volumen insostenible de pacientes en comparación con su dotación de camas y así tomar medidas antes de que el servicio colapse.
### Solución:
La solución fue crear un almacén de datos centralizado que unifica automáticamente la disponibilidad de camas con el volumen de egresos de cada casa de salud, poniendo toda esta información conectada a disposición de los coordinadores locales a través de un tablero interactivo. Al consolidar los datos en un solo lugar, la herramienta permite a los coordinadores entender claramente las relaciones entre la capacidad física de un hospital y la cantidad de pacientes que realmente atiende o despacha. Con este entendimiento visual de las conexiones, los usuarios pueden monitorear los niveles de saturación por especialidad médica en su territorio, identificar cuellos de botella exactos y tomar decisiones operativas inmediatas, como gestionar derivaciones a tiempo o redistribuir recursos antes de llegar al colapso sanitario.

## Justificación del diseño

## Proceso ETL

### dim_establecimiento

### dim_diagnostico

### dim_residencia

### dim_paciente

### fact_camas_hospitalarias

### fact_egresos_hospitalarios

## Análisis de insights clave obtenidos (OLAP)

## Recomendaciones al negocio
