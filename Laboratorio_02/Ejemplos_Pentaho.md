# Pentaho Data Integration

**Equipo**: Betancourt, Camacho, Calvache, Villareal, Yunga


**Fecha**: 21-04-2026

## Ejemplos de inputs y transform

### 1. Limpieza de API
- **Input:** `JSON Input`.
- **Transform:** `Select Values` (Elimina campos innecesarios y renombra las claves a español).

<p align="center">
  <img width="504" height="130" alt="image" src="https://github.com/user-attachments/assets/b1adafee-0111-42f7-a9d5-01a975853a74" />
  <sub><strong>Figura 1.</strong>Flujo</sub>
</p>

<p align="center">
  <img width="696" height="63" alt="image" src="https://github.com/user-attachments/assets/58beb90c-cdad-4416-b752-9e213b47b4bc" />
  <sub><strong>Figura 2.</strong>Datos de entrada</sub>
</p>

<p align="center">
  <img width="405" height="63" alt="image" src="https://github.com/user-attachments/assets/7deab141-1d38-4c87-9b3c-72a2dc13ccc0" />
  <sub><strong>Figura 3.</strong>Datos de salida</sub>
</p>

### 2. Dividir campos mediante separador

- **Input:** `Data Grid`
- **Transform:** `Split field to rows`

<p align="center">
  <img src="https://github.com/user-attachments/assets/c2984284-49b4-41d7-8c3f-ac6210bbeb3b" alt="Data Grid" width="400" />
  <br>
  <sub><strong>Figura 4.</strong> Input y Transformation</sub>
</p>


  <p align="center">
  <img src="https://github.com/user-attachments/assets/b04e23d8-28eb-4336-864d-6d96114efb5d" alt="Preview" width="400" />
  <br>
  <sub><strong>Figura 5.</strong>Preview</sub>
</p>

### 3. Ordenamiento de productos por precio

- **Input:** `CSV File Input`
- **Transform:** `Sort Rows`
- **Output:** `Microsoft Excel Writer`

**Descripción:**  
Se cargó un archivo CSV con 100 registros de productos, cada uno con los campos `producto`, `precio` y `categoria`. Mediante la transformación `Sort Rows` se ordenaron los registros de menor a mayor precio. El resultado fue exportado a un archivo Excel (`productos_ordenados.xls`).

**Campos del dataset:**

| Campo | Tipo | Descripción |
|-------|------|-------------|
| producto | String | Nombre del producto |
| precio | Number | Precio en dólares |
| categoria | String | Categoría del producto (Tecnologia, Utiles, Hogar) |

**Configuración del Sort Rows:**

| Field name | Ascending |
|------------|-----------|
| precio | Y (menor a mayor) |

**Resultado esperado:**  
Los productos quedan ordenados desde el más barato hasta el más costoso, permitiendo visualizar fácilmente la distribución de precios por categoría.

<p align="center">
  <img src="https://github.com/user-attachments/assets/8358e441-e448-4201-b401-48c47568f948" alt="Transformación en Spoon" width="400" />
  <br>
  <sub><strong>Figura 6.</strong> Flujo de transformación: CSV Input → Sort Rows → Excel Writer</sub>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/8ba8b78b-b9fe-428f-b463-3312b3caf238" alt="Resultado Excel" width="400" />
  <br>
  <sub><strong>Figura 7.</strong> Archivo de salida con productos ordenados por precio</sub>
</p>

### 4. Enriquecimiento de datos con valores constantes

- **Input:** `Get data from XML`
- **Transform:** `Add constants`
- **Output:** `Text File Output`

**Descripción:**  
Se cargó un archivo XML con registros de personas que contienen los campos `id`, `first_name`, `last_name`, `email`, `gender` e `ip_address`.  
Mediante la transformación `Add constants`, se añadieron dos nuevos campos: `pais` con el valor "Ecuador" y `fuente` con el valor "XML_dataset".  
Finalmente, los datos enriquecidos fueron exportados a un archivo CSV (`salida.csv`).

**Campos del dataset:**

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id | Integer | Identificador único |
| first_name | String | Nombre |
| last_name | String | Apellido |
| email | String | Correo electrónico |
| gender | String | Género |
| ip_address | String | Dirección IP |
| pais | String | País asignado (constante) |
| fuente | String | Origen de los datos |

**Configuración de Add constants:**

| Fieldname | Type | Value |
|----------|------|--------|
| pais | String | Ecuador |
| fuente | String | XML_dataset |

**Resultado esperado:**  
Todos los registros del dataset original se mantienen, pero ahora incluyen las columnas adicionales `pais` y `fuente`, permitiendo enriquecer la información y facilitar su trazabilidad.

<p align="center">
  <img width="459" height="75" alt="image" src="https://github.com/user-attachments/assets/ea9048b4-eb21-4ae7-b2cd-2a7f2a06d193" />
  <br>
  <sub><strong>Figura 8.</strong> Flujo de transformación: XML Input → Add Constants → Text File Output</sub>
</p>

<p align="center">
  <img width="759" height="699" alt="image" src="https://github.com/user-attachments/assets/0ab6a72d-4a67-4b42-9ddc-75a969c15249" />
  <br>
  <sub><strong>Figura 9.</strong> Archivo de salida con columnas adicionales (pais y fuente)</sub>
</p>
