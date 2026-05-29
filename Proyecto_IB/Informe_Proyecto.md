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
<img width="1453" height="987" alt="image" src="https://github.com/user-attachments/assets/2be2b8b0-e3f7-4727-81f3-122553974668" />

Para estructurar los datos de este proyecto, se eligió implementar un Modelo Constelación (también conocido como Esquema Galaxia). Esta decisión se justifica porque este diseño permite tener múltiples tablas de hechos que comparten dimensiones comunes.

En el escenario elegido, se necesita evaluar dos eventos distintos de forma simultánea: la dotación de camas (oferta) y los egresos hospitalarios (demanda). En lugar de mezclar toda la información, el modelo constelación separa estos datos en dos tablas centrales, pero las conecta a las mismas dimensiones compartidas (como el establecimiento de salud y el tiempo). Gracias a esta arquitectura, el sistema soporta análisis más complejos, permitiendo que el tablero cruce y compare la capacidad física del hospital frente al volumen real de pacientes de manera exacta, sin generar duplicados ni errores de cálculo.

## PROCESO ETL

##  DIM_ESTABLECIMIENTO
**Fuente:** `camas_hospitalarias_2024.csv`

### Pasos:
1. **CSV file input** (`CSV_CAMAS`) → archivo `camas_hospitalarias_2024.csv`, separador `,`, enclosura `"`, header SÍ. Campos: `prov_ubi, cant_ubi, parr_ubi, area_ubi, clase, tipo, entidad, sector`.
2. **Select Values** (`SEL_CAMPOS_ESTAB`) → mantener únicamente `prov_ubi, cant_ubi, parr_ubi, area_ubi, clase, tipo, entidad, sector`.
3. **Sort rows** (`SORT_ESTAB`) → ordenar por `prov_ubi, cant_ubi, clase, tipo, entidad, sector`.
4. **Unique rows** (`UNIQUE_ESTAB`) → comparar `prov_ubi, cant_ubi, parr_ubi, area_ubi, clase, tipo, entidad, sector` para eliminar duplicados.
5. **Formula / Modified JavaScript** (`CALC_NK_ESTABLECIMIENTO`) → crear `nk_establecimiento` concatenando campos:
   ```
   TRIM(prov_ubi) + '|' + TRIM(cant_ubi) + '|' +
   TRIM(COALESCE(parr_ubi,'')) + '|' + TRIM(COALESCE(clase,'')) + '|' +
   TRIM(COALESCE(tipo,'')) + '|' + TRIM(COALESCE(entidad,'')) + '|' +
   TRIM(COALESCE(sector,''))
   ```
   En Modified JavaScript Value:
   ```javascript
   var nk = trim(prov_ubi) + '|' + trim(cant_ubi) + '|' +
            trim(parr_ubi == null ? '' : parr_ubi) + '|' +
            trim(clase    == null ? '' : clase)    + '|' +
            trim(tipo     == null ? '' : tipo)     + '|' +
            trim(entidad  == null ? '' : entidad)  + '|' +
            trim(sector   == null ? '' : sector);
   ```
6. **Database Lookup** (`LOOKUP_ESTAB_EXISTS`) → tabla `dw_salud.dim_establecimiento`, clave `nk_establecimiento`, retorna `id_establecimiento` (NULL si no existe; falla si múltiples).
7. **Filter rows** (`FILTER_NUEVOS_ESTAB`) → `id_establecimiento IS NULL`:
   - TRUE → insertar nuevos (Paso 8).
   - FALSE → actualizar SCD1 (Paso 9).
8. **Table Output** (`INS_DIM_ESTABLECIMIENTO`) → insertar en `dw_salud.dim_establecimiento`:
   `nk_establecimiento, prov_ubi, cant_ubi, parr_ubi, area_ubi, clase, tipo, entidad, sector`.
   `fecha_carga` y `fecha_actualizacion` con DEFAULT NOW().
9. **Update** (`UPD_DIM_ESTABLECIMIENTO`) → actualizar `prov_ubi, cant_ubi, parr_ubi, area_ubi, clase, tipo, entidad, sector, fecha_actualizacion` con clave `nk_establecimiento` (SCD Tipo 1).

---
<img width="1460" height="435" alt="image" src="https://github.com/user-attachments/assets/382f7b9c-4764-440f-8c1d-0ac6f2749bce" />



## DIM_DIAGNOSTICO
**Fuente:** `egresos_hospitalarios_2024.csv`

### Pasos:
1. **CSV file input** → campos: `cau_cie10, causa3, cap221rx, cau221rx, cau298rx`
2. **Filter rows** → descartar filas donde `cau_cie10 IS NULL OR cau_cie10 = ''`
3. **Sort rows** → por `cau_cie10`
4. **Unique rows** → por `cau_cie10`
5. **Add constants** → agregar campos vacíos para las descripciones
   (se pueden enriquecer después con un catálogo CIE-10 externo):
   `descripcion_cie10 = ''`, `descripcion_causa3 = ''`, etc.
6. **Database Lookup** → buscar `cau_cie10` en `dim_diagnostico`
   - Si no existe (NULL) → **Table Output** para insertar
   - Si existe → **Dummy** (no hacer nada, SCD1 de diagnósticos es estable)

---

<img width="1352" height="344" alt="image" src="https://github.com/user-attachments/assets/fcfa78d7-934b-483a-b36b-285b835ee7c4" />


## DIM_RESIDENCIA

**Fuente:** `egresos_hospitalarios_2024.csv`

### Pasos:
1. **CSV file input** → campos: `prov_res, cant_res, parr_res, area_res, cod_pais, nom_pais`
2. **Sort + Unique** → por todos los campos de residencia
3. **Modified JavaScript** → construir `nk_residencia`:
   ```javascript
   var nk = trim(prov_res == null ? 'NA' : prov_res) + '|' +
            trim(cant_res == null ? 'NA' : cant_res) + '|' +
            trim(parr_res == null ? '' : parr_res)   + '|' +
            trim(area_res == null ? '' : area_res)   + '|' +
            trim(cod_pais == null ? 'ECU' : cod_pais);
   ```
4. **Database Lookup** → buscar `nk_residencia` en `dim_residencia`
5. **Filter** → nuevos → **Table Output** | existentes → **Dummy**

---

<img width="1366" height="349" alt="image" src="https://github.com/user-attachments/assets/f8ae3c45-778d-4c99-aa6e-8df2eed4955d" />

## DIM_PACIENTE

**Fuente:** `egresos_hospitalarios_2024.csv`

### Pasos:
1. **CSV file input** → campos: `sexo, cod_edad, edad, etnia, nac_pac, tipo_seg, dis_pac`
2. **Modified JavaScript** → calcular `rango_edad`:
   ```javascript
   var rango;
   var e = parseInt(edad);
   var c = parseInt(cod_edad);
   if (c == 1) {          // unidad = años
     if      (e < 1)   rango = '< 1';
     else if (e <= 4)  rango = '1-4';
     else if (e <= 14) rango = '5-14';
     else if (e <= 24) rango = '15-24';
     else if (e <= 34) rango = '25-34';
     else if (e <= 44) rango = '35-44';
     else if (e <= 54) rango = '45-54';
     else if (e <= 64) rango = '55-64';
     else              rango = '65+';
   } else if (c == 2) {   // unidad = meses
     rango = '< 1';
   } else {               // unidad = días
     rango = '< 1';
   }
   ```
3. **Modified JavaScript** → construir `nk_paciente`:
   ```javascript
   var nk = trim(sexo       == null ? 'I'  : sexo)     + '|' +
            trim(rango_edad == null ? 'NA' : rango_edad)+ '|' +
            trim(etnia      == null ? 'NA' : etnia)     + '|' +
            trim(nac_pac    == null ? 'NA' : nac_pac)   + '|' +
            trim(tipo_seg   == null ? 'NA' : tipo_seg)  + '|' +
            trim(dis_pac    == null ? 'NA' : dis_pac);
   ```
4. **Sort + Unique** → por `nk_paciente`
5. **Database Lookup + Filter → Table Output** (mismo patrón que dimensiones anteriores)

---


<img width="1331" height="361" alt="image" src="https://github.com/user-attachments/assets/f3055fe0-4662-4c76-b208-9f3650d24328" />

## FACT_CAMAS_HOSPITALARIAS

**Fuente:** `camas_hospitalarias_2024.csv`

### Pasos:

#### 1 · CSV file input
Todos los campos del archivo.

#### 2 · Replace in string (limpieza)
- Reemplazar comas por punto en campos numéricos si el CSV usa coma decimal.
- Reemplazar vacíos `""` por `0` en todos los campos `dot*` y `dis*`.

#### 3 · Modified JavaScript — construir NK establecimiento
```javascript
var nk = trim(prov_ubi) + '|' + trim(cant_ubi) + '|' +
         trim(parr_ubi == null ? '' : parr_ubi) + '|' +
         trim(clase    == null ? '' : clase)    + '|' +
         trim(tipo     == null ? '' : tipo)     + '|' +
         trim(entidad  == null ? '' : entidad)  + '|' +
         trim(sector   == null ? '' : sector);
```

#### 4 · Add constants
- Campo `fecha_reporte_str = '2024-01-01'`

#### 5 · Database Lookup → id_establecimiento
- Tabla: `dw_salud.dim_establecimiento`
- Clave: `nk_establecimiento = nk_establecimiento (calculado en step 3)`
- Retornar: `id_establecimiento`
- Si NULL → Error log (el establecimiento DEBE existir ya que dim se cargó primero)

#### 6 · Database Lookup → id_tiempo
- Tabla: `dw_salud.dim_tiempo`
- Clave: `fecha = fecha_reporte_str` (como DATE)
- Retornar: `id_tiempo`

#### 7 · Select Values
Mapear todos los campos fuente a los campos de la fact.
Asegurarse de que los campos numéricos sean INTEGER o SMALLINT:
- Usar **"Metadata"** tab para forzar tipo numérico en `dotmedic`, `camas_dnor`, etc.

#### 8 · Table Output / Insert-Update
- Tabla: `dw_salud.fact_camas_hospitalarias`
- **Usar Insert-Update** con clave `(id_establecimiento, id_tiempo)`
  para soportar recargas parciales sin duplicar.

---

<img width="1408" height="632" alt="image" src="https://github.com/user-attachments/assets/ab192015-aff7-4ccf-9eb5-f580f5726ead" />


## FACT_EGRESOS_HOSPITALARIOS

**Fuente:** `egresos_hospitalarios_2024.csv`

**Volumen:** ~1.13 millones de filas → configurar `rowset size = 50000`

### Pasos:

#### 1 · CSV file input
Todos los campos del archivo. Configurar:
- **Lazy conversion: SÍ** (mejora rendimiento en archivos grandes)
- **NIO buffer size: 1MB**

#### 2 · Modified JavaScript — transformaciones de negocio
```javascript
// 1. Campo es_fallecido
var fallecido = (con_egrpa != null &&
                 (con_egrpa.indexOf('muerto') >= 0 ||
                  con_egrpa.indexOf('falleci') >= 0 ||
                  con_egrpa.indexOf('3') == 0 ||   // ajustar según catálogo
                  con_egrpa.indexOf('4') == 0));

// 2. Construir NK establecimiento
var nk_estab = trim(prov_ubi) + '|' + trim(cant_ubi) + '|' +
               trim(parr_ubi == null ? '' : parr_ubi) + '|' +
               trim(clase    == null ? '' : clase)    + '|' +
               trim(tipo     == null ? '' : tipo)     + '|' +
               trim(entidad  == null ? '' : entidad)  + '|' +
               trim(sector   == null ? '' : sector);

// 3. Construir NK paciente
var nk_pac = trim(sexo     == null ? 'I'  : sexo)  + '|' +
             trim(rango_edad) + '|' +   // calculado en paso previo o aquí
             trim(etnia    == null ? 'NA': etnia)   + '|' +
             trim(nac_pac  == null ? 'NA': nac_pac) + '|' +
             trim(tipo_seg == null ? 'NA': tipo_seg)+ '|' +
             trim(dis_pac  == null ? 'NA': dis_pac);

// 4. Construir NK residencia
var nk_res = trim(prov_res == null ? 'NA' : prov_res) + '|' +
             trim(cant_res == null ? 'NA' : cant_res) + '|' +
             trim(parr_res == null ? '' : parr_res)   + '|' +
             trim(area_res == null ? '' : area_res)   + '|' +
             trim(cod_pais == null ? 'ECU': cod_pais);
```

#### 3 · Stream lookup (en memoria) — más rápido que DB lookup para facts grandes

Para cada dimensión, cargar previamente una tabla de lookup en caché:

**Sub-paso A — Cargar dim_establecimiento a caché:**
```
Table input: SELECT id_establecimiento, nk_establecimiento
             FROM dw_salud.dim_establecimiento
→ Stream lookup sobre nk_estab → retorna id_establecimiento
```

**Sub-paso B — Cargar dim_paciente a caché:**
```
Table input: SELECT id_paciente, nk_paciente FROM dw_salud.dim_paciente
→ Stream lookup sobre nk_pac → retorna id_paciente
```

**Sub-paso C — Cargar dim_diagnostico a caché:**
```
Table input: SELECT id_diagnostico, cau_cie10 FROM dw_salud.dim_diagnostico
→ Stream lookup sobre cau_cie10 → retorna id_diagnostico
```

**Sub-paso D — Cargar dim_residencia a caché:**
```
Table input: SELECT id_residencia, nk_residencia FROM dw_salud.dim_residencia
→ Stream lookup sobre nk_res → retorna id_residencia
```

**Sub-paso E — Lookup dim_tiempo (ingreso y egreso):**
```
Table input: SELECT id_tiempo, fecha FROM dw_salud.dim_tiempo
→ Stream lookup sobre fecha_ingr → id_tiempo_ingreso
→ Stream lookup sobre fecha_egr  → id_tiempo_egreso
```
Nota: fecha_ingr y fecha_egr deben estar en formato `DATE` (usar **Select Values / Metadata** para convertir desde String si es necesario).

#### 4 · Filter rows — control de calidad
Descartar filas donde algún id de dimensión sea NULL y enviarlas a log de errores:
- Condición: `id_establecimiento IS NOT NULL AND id_paciente IS NOT NULL AND id_diagnostico IS NOT NULL`
- Ruta ERROR → **Text file output** (`errores_egresos_YYYY.log`)
- Ruta OK → continúa al paso siguiente

#### 5 · Select Values
Seleccionar y ordenar sólo los campos que van a la fact:
`id_establecimiento, id_tiempo_ingreso, id_tiempo_egreso, id_paciente,
 id_diagnostico, id_residencia, mes_inv, especialidad_egreso,
 dia_estad, es_fallecido, con_egrpa`

#### 6 · Table Output (Bulk insert)
- Tabla: `dw_salud.fact_egresos_hospitalarios`
- **Use batch updates: SÍ**
- **Batch size: 5000** (equilibrio entre memoria y velocidad)
- **Truncate table: SÍ** si es carga inicial; NO si es carga incremental

---

<img width="815" height="897" alt="image" src="https://github.com/user-attachments/assets/095929ae-6d11-437e-bb06-e3be25553a88" />


## Análisis de insights clave obtenidos (OLAP)

## Recomendaciones al negocio
