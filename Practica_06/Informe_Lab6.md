# <center> **ESCUELA POLITÉCNICA NACIONAL** </center>

**Integrantes**
* Betancourt Alison
* Calvache Mateo
* Camacho Julián
* Villareal Alexis
* Yunga Mateo

## **Índice de Contenidos**

1. [Modelo Estrella](#modelo-estrella)
2. [Respuestas](#respuestas)
   - [1. ¿Cuál es el costo total de atención por especialidad, ciudad y mes?](#1-cuál-es-el-costo-total-de-atención-por-especialidad-ciudad-y-mes)
   - [2. ¿Qué ciudad tuvo más emergencias por mes y género?](#2-qué-ciudad-tuvo-más-emergencias-por-mes-y-género)
   - [3. ¿Por diagnóstico, tipo de seguro, cuál es el costo promedio por visita y en qué ciudad es más alto?](#3-por-diagnóstico-tipo-de-seguro-cuál-es-el-costo-promedio-por-visita-y-en-qué-ciudad-es-más-alto)

---

## Modelo Estrella

<p align="center">
  <img width="1003" height="727" alt="Modelo estrella" src="https://github.com/user-attachments/assets/d163fafb-bc34-44ba-a73f-cdc010db0316" />
  <br><sub><strong>Figura 1.</strong> Modelo Estrella. </sub>
</p>


## Respuestas

El modelo estrella, la vista de datos materializada y las consultas MOLAP nos permitieron responder las siguientes preguntas:

### 1. ¿Cuál es el costo total de atención por especialidad, ciudad y mes?

Los costos más altos se concentran en Traumatología (alcanzando los $16,001.00 en Ambato durante el mes 2) y en Oncología (con $8,920.00 en Loja durante el mes 1). Por otro lado, Medicina General mantiene valores altos constantes en varias ciudades, registrando su pico máximo en Quito con $3,737.00 en el mes 2.

<p align="center">
  <img width="755" height="831" alt="pregunta1 1" src="https://github.com/user-attachments/assets/1c8ae513-cba1-4b84-bb61-06058cc469a4" />
  <br><sub><strong>Figura 2.</strong> Respuesta pregunta 1. </sub>
</p>

<p align="center">
  <img width="753" height="720" alt="pregunta1 2" src="https://github.com/user-attachments/assets/60c2592f-394f-4d3e-9606-b82d20b57422" />
  <br><sub><strong>Figura 3.</strong> Respuesta pregunta 1. </sub>
</p>

### 2. ¿Qué ciudad tuvo más emergencias por mes y género?

Quito lidera el número de emergencias durante los meses 2 y 3, destacando el mes 2 con un pico de 5 casos en el género masculino (M) y 3 casos en el femenino (F). En el mes 1, las ciudades con más reportes fueron Guayaquil para mujeres (3 casos) y Loja para hombres (2 casos).

<p align="center">
  <img width="847" height="240" alt="pregunta2" src="https://github.com/user-attachments/assets/a72f34e5-9f02-45ca-a8df-9391fa4c4a07" />
  <br><sub><strong>Figura 4.</strong> Respuesta pregunta 2. </sub>
</p>


### 3. ¿Por diagnóstico, tipo de seguro, cuál es el costo promedio por visita y en qué ciudad es más alto?

El costo promedio más elevado de la tabla corresponde al diagnóstico de Cáncer con seguro Mixto en la ciudad de Ambato ($4,350.00). Otros costos notablemente altos se observan en Fracturas con seguro Privado en Quito ($3,610.00) y en Fracturas con seguro Público en Ambato ($2,680.33).

<p align="center">
  <img width="971" height="767" alt="pregunta3" src="https://github.com/user-attachments/assets/2731891a-89e2-424c-857d-6aeffad388f8" />
  <br><sub><strong>Figura 5.</strong> Respuesta pregunta 3. </sub>
</p>
