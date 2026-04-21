# Pentaho Data Integration

**Equipo**: Betancourt, Camacho, Calvache, Villareal, Yunga


**Fecha**: 21-04-2026

## Ejemplos de inputs y transform

### 1. Limpieza de API
**Input:** `JSON Input` (Consume datos de una API externa).
**Transform:** `Select Values` (Elimina campos innecesarios y renombra las claves a español).


## 2. Dividir campos mediante separador

- **Input:** `Data Grid`
- **Transform:** `Split field to rows`

<p align="center">
  <img src="https://github.com/user-attachments/assets/c2984284-49b4-41d7-8c3f-ac6210bbeb3b" alt="Data Grid" width="401" />
  <br>
  <sub><strong>Figura 1.</strong> Input y Transformation</sub>
</p>


  <p align="center">
  <img src="https://github.com/user-attachments/assets/b04e23d8-28eb-4336-864d-6d96114efb5d" alt="Preview" width="401" />
  <br>
  <sub><strong>Figura 2.</strong>Preview</sub>
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
  <img src="https://github.com/user-attachments/assets/8358e441-e448-4201-b401-48c47568f948" alt="Transformación en Spoon" width="600" />
  <br>
  <sub><strong>Figura 3.</strong> Flujo de transformación: CSV Input → Sort Rows → Excel Writer</sub>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/8ba8b78b-b9fe-428f-b463-3312b3caf238" alt="Resultado Excel" width="600" />
  <br>
  <sub><strong>Figura 4.</strong> Archivo de salida con productos ordenados por precio</sub>
</p>




