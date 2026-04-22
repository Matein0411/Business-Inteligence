# Pentaho Data Integration

**Equipo**: Betancourt Alison, Camacho Julian, Calvache Mateo, Villareal Alexis, Yunga Mateo


**Fecha**: 21-04-2026

## Ejemplos de inputs y transform

### 1. Limpieza de API
- **Input:** `JSON Input`.
- **Transform:** `Select Values` (Elimina campos innecesarios y renombra las claves a español).

<p align="center">
  <img width="504" height="130" alt="image" src="https://github.com/user-attachments/assets/b1adafee-0111-42f7-a9d5-01a975853a74" />
  <sub><strong>Figura 1.</strong> Flujo</sub>
</p>

<p align="center">
  <img width="696" height="63" alt="image" src="https://github.com/user-attachments/assets/58beb90c-cdad-4416-b752-9e213b47b4bc" />
  <sub><strong>Figura 2.</strong> Datos de entrada</sub>
</p>

<p align="center">
  <img width="405" height="63" alt="image" src="https://github.com/user-attachments/assets/7deab141-1d38-4c87-9b3c-72a2dc13ccc0" />
  <sub><strong>Figura 3.</strong> Datos de salida</sub>
</p>

### 2. Dividir campos mediante separador

- **Input:** `Data Grid` (Tabla estática que permite hardcodear valores)
- **Transform:** `Split field to rows` (Permite dividir valores mediante un separador definido)

<p align="center">
  <img src="https://github.com/user-attachments/assets/c2984284-49b4-41d7-8c3f-ac6210bbeb3b" alt="Data Grid" width="400" />
  <br>
  <sub><strong>Figura 4.</strong> Flujo</sub>
</p>


  <p align="center">
  <img src="https://github.com/user-attachments/assets/b04e23d8-28eb-4336-864d-6d96114efb5d" alt="Preview" width="400" />
  <br>
  <sub><strong>Figura 5.</strong> Datos de entrada</sub>
</p>

  <p align="center">
  <img src="https://github.com/user-attachments/assets/a9e0df61-7c4e-4fb5-bbe7-25b35ca87495" alt="Preview" width="710" />
  <br>
  <sub><strong>Figura 6.</strong> Datos de salida</sub>
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
  <sub><strong>Figura 7.</strong> Flujo de transformación: CSV Input → Sort Rows → Excel Writer</sub>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/8ba8b78b-b9fe-428f-b463-3312b3caf238" alt="Resultado Excel" width="400" />
  <br>
  <sub><strong>Figura 8.</strong> Archivo de salida con productos ordenados por precio</sub>
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
  <sub><strong>Figura 9.</strong> Flujo de transformación: XML Input → Add Constants → Text File Output</sub>
</p>

<p align="center">
  <img width="759" height="699" alt="image" src="https://github.com/user-attachments/assets/0ab6a72d-4a67-4b42-9ddc-75a969c15249" />
  <br>
  <sub><strong>Figura 10.</strong> Archivo de salida con columnas adicionales (pais y fuente)</sub>
</p>

### 5. Generación de correos institucionales únicos

Este ejercicio consiste en la generación de correos institucionales bajo el estándar: **`nombre.apellido@epn.edu.ec`**

El problema principal ocurre cuando varios estudiantes comparten el mismo primer nombre y primer apellido, lo que requiere generar un identificador único mediante sufijos numéricos secuenciales sin alterar la integridad del dataset original.

#### Fase 1: CSV file input para ingreso de datos

El proceso inicia con la lectura de la fuente de datos en formato **CSV**, garantizando compatibilidad universal.

##### CSV File Input

- **Encoding:** UTF-8, permite leer correctamente caracteres especiales como tildes y “ñ”.
- **Delimitador:** `;`, separación correcta de columnas.
- **Enclosure (`"`):** permite manejar textos con comas internas sin romper la estructura.  
- **Header row present:** Activado, ya que la primera fila contiene nombres de columnas.

<p align="center">
  <img width="1345" height="722" alt="image" src="https://github.com/user-attachments/assets/3ff89d94-bc11-475a-b9be-1741e0eaccf9" />
  <br>
  <sub><strong>Figura 11.</strong> Preview de haber ejecutado CSV File Input y corroborado que esté leído completamente el archivo.</sub>
</p>

#### Fase 2: Modified JavaScript Value para normalización y limpieza de atributos

Se estandarizan nombres y apellidos para evitar inconsistencias, porque habían ciertos caracteres especiales, se pueden ver en la figura 11, que se necesitaban limpiar para poder usar el primer nombre y primer apellido para la construcción del correo institucional del estudiante.

##### Procesos aplicados:

```javascript
// pasar a minúsculas
var nombres = NOMBRES.toLowerCase();
var apellidos = APELLIDOS.toLowerCase();
// función limpieza para correos
function limpiar(texto) {
  return texto
    // reemplazos del dataset
    .replace(/~/g, "n")
    .replace(/\|\|/g, "i")
    // quitar tildes
    .replace(/á/g, "a")
    .replace(/é/g, "e")
    .replace(/í/g, "i")
    .replace(/ó/g, "o")
    .replace(/ú/g, "u")
    .replace(/ñ/g, "n")
    // espacios extra
    .replace(/\s+/g, " ")
    .trim();
}
```
##### Extracción de componentes:

```javascript
// aplicar limpieza
nombres = limpiar(nombres);
apellidos = limpiar(apellidos);
// primer nombre y apellido
var nombre1 = nombres.split(" ")[0];
var apellido1 = apellidos.split(" ")[0];
```
Al final se crean dos nuevas columnas para obtener los resultados de la ejecución del script, nombre1 y apellido1, de tipo String.

<p align="center">
  <img width="1598" height="858" alt="image" src="https://github.com/user-attachments/assets/90f3bd7e-21b8-4473-9e45-dcf4241d16de" />
  <br>
  <sub><strong>Figura 12.</strong> Resultado de haber limpiado las columnas de nombres y apellidos al aplicar Modified JavaScript Value.</sub>
</p>

#### Fase 3: Concat Fields para la construcción del identificador para el inicio del correo

- **Campo para el resultado:** correobase
- **Separador:** . (para concatenar el nombre.apellido).

Ejemplo: juan + lara → juan.lara

<p align="center">
  <img width="1702" height="742" alt="image" src="https://github.com/user-attachments/assets/17da945d-6657-4cec-b564-0373e98cf7d9" />
  <br>
  <sub><strong>Figura 13.</strong> Resultado de haber aplicado Concat Fields, columna correobase creado.</sub>
</p>

#### Fase 4: Sort Rows para preparar a los resultados en correobase iguales

- **Campo:** correobase
- **Orden:** Ascendente

Se ordenó para poder identificar en grupos a los duplicados en la siguiente fase.

<p align="center">
  <img width="527" height="500" alt="image" src="https://github.com/user-attachments/assets/4b8f9f52-7dfc-4456-a7f2-4e7a1ab67ba2" />
  <br>
  <sub><strong>Figura 14.</strong> Columna correobase ordenada ascendentemente.</sub>
</p>

#### Fase 5: Group By para identificación y numeración de duplicados

- **Group Field:** correobase
- **Line number:** Activado
- **Reset por grupo:** Sí
- **Campo a ser creado:** num_fila
- **Include all rows:** Activado

Con ello se generará numeración secuencial por grupo de correos repetidos.

Ejemplo: 

- juan.lara → 1
- juan.lara → 2
- lidia.martinez → 1

<p align="center">
  <img width="785" height="553" alt="image" src="https://github.com/user-attachments/assets/de61d208-a70c-496e-bae4-116371a062ff" />
  <br>
  <sub><strong>Figura 15.</strong> Se observa como en la columa nueva num_file se identifican duplicados.</sub>
</p>

#### Fase 6: Formula para lógica de diferenciación de identificadores

- **Campo a ser creado:** correo_final

Dentro de la columna de formula se añadió lo siguiente:

```javascript
IF([num_fila] > 1;
   [correobase] & TEXT([num_fila] - 1; "00");
   [correobase])
```
Explicación:

1. Primer registro → sin cambios
2. Duplicados → sufijo numérico: 01, 02, 03, etc.

Ejemplo: juan.lara, juan.lara01 y juan.lara02

<p align="center">
  <img width="1915" height="861" alt="image" src="https://github.com/user-attachments/assets/0007df8b-88e3-428c-8244-e3081dd1c000" />
  <br>
  <sub><strong>Figura 16.</strong> La fórmula para el sufijo de correos duplicados funciona correctamente.</sub>
</p>

#### Fase 7: Add Constants para parametrización del dominio institucional

- **Campo a ser creado:** dominio
- **Valor:** @epn.edu.ec
- **Tipo:** String

Permite cambiar el dominio en un solo punto sin afectar la lógica del flujo, así también con la siguiente fase solo se unirá a la columna ya establecida de correo_final, en la que ya está el nombre.apellido o nombre.apellido01.

<p align="center">
  <img width="952" height="329" alt="image" src="https://github.com/user-attachments/assets/6b69476e-423f-4965-be98-3e80e46517ec" />
  <br>
  <sub><strong>Figura 17.</strong> Se agregó una constante para el dominio del correo.</sub>
</p>

#### Fase 8: Calculator para consolidación del correo electrónico final

- **Campo final a ser creado:** CORREO
- **Operación:** A + B
- **A:** correo_final
- **B:** dominio

Ejemplo: juan.lara01 + @epn.edu.ec → juan.lara01@epn.edu.ec

Permitó tener el resultado que se esperaba.

<p align="center">
  <img width="1054" height="699" alt="image" src="https://github.com/user-attachments/assets/71951128-d125-4dfa-ac63-88c53d4e3b71" />
  <br>
  <sub><strong>Figura 18.</strong> Se obtuvo el campo CORREO como se esperaba.</sub>
</p>

#### Fase 9: Select Values para depuración y estructuración del dataset final

Se eliminan campos que se crearon en el proceso de transformación:
- nombre1
- apellido1
- correobase
- num_fila
- correo_final
- dominio

Se mantienen campos que serán enviado a mi output:
- ID
- NOMBRES
- APELLIDOS
- CEDULA
- MODALIDAD
- NIVEL
- FECHA ADMISIÓN
- ESTADO ACTUAL
- FECHA ESTADO
- CORREO

#### Fase 10: Microsoft Excel Writer como output para carga de datos y generación del entregable final

- **Formato:** .xlsx
- **Versión:** Excel 2007+
- Validación con Get Fields

Después de establecer esos tres puntos, la intención es que los datos transformados se guarden en el archivo limpio generado.

<p align="center">
  <img width="849" height="538" alt="image" src="https://github.com/user-attachments/assets/5be6c78e-afea-4913-8ca3-04e63a93ba9b" />
  <br>
  <sub><strong>Figura 19.</strong> Proceso del ejercicio de generar correos.</sub>
</p>

<p align="center">
  <img width="1229" height="763" alt="image" src="https://github.com/user-attachments/assets/499d2470-9d1b-4102-bb46-e562e813679e" />
  <br>
  <sub><strong>Figura 20.</strong> Resultado obtenido.</sub>
</p>



