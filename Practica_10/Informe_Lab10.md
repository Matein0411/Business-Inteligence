## 1. Creación del dataset y ejecución de Apriori

### 1.1. Creación del dataset

#### 1.1.1. Tabulación de datos

Se abrió MS Excel y se tabularon los datos como se muestra en la Figura 1.18.

<p align="center">
<img width="559" height="156" alt="image" src="https://github.com/user-attachments/assets/fe39946f-7b61-47db-9212-3c23591db213" />
<br>
<sub><b>Figura 1.1.1.</b> Dataset diario creado en Excel.</sub>
</p>

#### 1.1.2. Guardado en formato CSV

El archivo se guardó como CSV desde **File → Save As**, con el nombre **DailyItem Dataset** y el formato **CSV (Comma delimited)**. Luego se guardó en el **Desktop**, como se muestra en la Figura 1.19.

<p align="center">
<img width="936" height="578" alt="image" src="https://github.com/user-attachments/assets/1ee3454d-14cc-462d-b3e3-fdb440c9450d" />
<br>
<sub><b>Figura 1.1.2.</b> Guardado del archivo en formato CSV.</sub><br>
</p>

---

### 1.2. Ejecución del algoritmo Apriori

#### 1.2.1. Apertura de Weka

Se abrió Weka y, en el panel **Weka GUI Chooser**, se seleccionó **Explorer**, como se muestra en la Figura 1.20.

<p align="center">
<img width="600" height="495" alt="image" src="https://github.com/user-attachments/assets/a81e5034-70c0-46e8-a857-de8db19a0c87" /><br>
<sub><b>Figura 1.2.1.</b> Panel Weka GUI Chooser.</sub><br>
</p>

#### 1.2.2. Carga del dataset

En la pestaña **Preprocess**, se hizo clic en **Open file** y se seleccionó el archivo **DailyItem Dataset (.csv)** desde el **Desktop**. Una vez cargado el dataset, aparecieron los nombres de los atributos como se muestra en la Figura 1.21.

<p align="center">
<img width="886" height="665" alt="image" src="https://github.com/user-attachments/assets/6858b537-7516-4aa8-9502-b8d97fdca381" />
<br>
<sub><b>Figura 1.2.2.</b> Dataset cargado en Weka.</sub>
</p>

#### 1.2.3. Conversión de numérico a nominal

Una vez cargado el dataset, Weka lo consideró numérico por defecto. Como la minería de asociación no puede aplicarse directamente sobre datos numéricos, fue necesario convertirlos a nominal. Para ello, en la pestaña **Preprocess** se hizo clic en **Choose** y se seleccionó el filtro **unsupervised → NumericToNominal**. Después se volvió a hacer clic en **Choose**, como se muestra en la Figura 1.22.

<p align="center">
<img width="886" height="178" alt="image" src="https://github.com/user-attachments/assets/159c1210-cca3-41f6-a223-ade05aceaf47" />
<br>
<sub><b>Figura 1.2.3.</b> Selección del filtro NumericToNominal en Weka.</sub>
</p>

#### 1.2.4. Aplicación del filtro

Después de seleccionar el filtro **NumericToNominal**, se hizo clic en **Apply** para aplicarlo al dataset, como se muestra en la Figura 1.23.

<p align="center">
<img width="886" height="664" alt="image" src="https://github.com/user-attachments/assets/a4c8789c-f7c4-4a60-8efd-8a3672e33cd5" />
<br>
<sub><b>Figura 1.2.4.</b> Aplicación del filtro de numérico a nominal.</sub>
</p>

#### 1.2.5. Eliminación del atributo Transaction

Tras cargar el dataset y aplicar el filtro, se eliminaron los atributos que no aportaban a la minería de asociación. En este caso, el atributo **Transaction** no intervino en el análisis, por lo que se eliminó antes de ejecutar Apriori. Para ello, se seleccionó **Transaction** en el panel izquierdo y se hizo clic en **Remove**, como se muestra en la Figura 1.24.

<p align="center">
<img width="886" height="666" alt="image" src="https://github.com/user-attachments/assets/c206aff3-bd49-4769-ad95-67f197eeff9e" />
<br>
<sub><b>Figura 1.2.5.</b> Eliminación del atributo Transaction.</sub>
</p>

#### 1.2.6. Selección de Apriori

Se hizo clic en la pestaña **Associate** de Weka. Luego se pulsó **Choose** y se seleccionó **Apriori** dentro de **associations**, como se muestra en la Figura 1.25.

<p align="center">
<img width="886" height="99" alt="image" src="https://github.com/user-attachments/assets/610f6c3e-7756-4a1c-9595-1b4e11bb5fd4" />
<br>
<sub><b>Figura 1.2.6.</b> Selección del algoritmo Apriori.</sub>
</p>

#### 1.2.7. Apertura del Generic Object Editor

Se hizo clic en el campo **Associator**, donde aparece escrito **Apriori**. Esto abrió la ventana de propiedades del algoritmo, es decir, el **Generic Object Editor**, como se muestra en la Figura 1.26.

<p align="center">
<img width="595" height="796" alt="image" src="https://github.com/user-attachments/assets/394a5f98-58aa-4825-8570-263fe0860a3b" />
<br>
<sub><b>Figura 1.2.7.</b> Apertura del Generic Object Editor.</sub>
</p>

#### 1.2.8. Configuración del algoritmo

En el **Generic Object Editor** se configuraron los valores de Apriori:

- En **lowerBoundMinSupport**, establecer el soporte mínimo en **0.5**.
- En **metricType**, seleccionar **Confidence**.
- En **minMetric**, establecer la confianza mínima en **0.75**.
- En **numRules**, indicar el número de reglas a encontrar, en este caso **10**.

Luego se hizo clic en **OK** para guardar la configuración.

#### 1.2.9. Ejecución del algoritmo

Finalmente, se hizo clic en **Start** para ejecutar el algoritmo Apriori sobre el dataset **DailyItem**. El resultado se mostró en la parte derecha de la ventana de Weka, como se observa en la Figura 1.27.

<p align="center">
<img width="203" height="226" alt="image" src="https://github.com/user-attachments/assets/aa6fde92-830a-4b0f-b562-b08f2806aa44" />
<br>
<sub><b>Figura 1.2.8.</b> Inicio de la ejecución del algoritmo Apriori.</sub>
</p>

#### 1.2.10. Interpretación de resultados

Se interpretaron los resultados generados, como se muestra en la Figura 1.28.

<p align="center">
<img width="886" height="665" alt="image" src="https://github.com/user-attachments/assets/cd46b91a-59fc-4343-8655-aa6f6348eb11" />
<br>
<sub><b>Figura 1.2.9.</b> Resultados después de ejecutar el algoritmo Apriori.</sub>
</p>

---

### Interpretación de resultados

La mejor regla de asociación obtenida al ejecutar el algoritmo Apriori sobre el dataset **DailyItem** fue **Jam → Cornflake**, con una confianza del **100%**. Esto significa que, cada vez que aparece *Jam*, también aparece *Cornflake* en esta combinación. Este resultado coincide con lo analizado en la sección anterior del capítulo.

---

## 4. Process of Performing Manual discretization

### 4.1. Creación del dataset

Se construyó en Excel un dataset de **60 estudiantes** con las siguientes columnas:

| Roll No. | Name | MST(20.0) | Quiz(15) | Lab(20.0) | ENDSEM(45.0) | Total(100.0) | Grade |
|---|---|---|---|---|---|---|---|

- `MST`, `Quiz`, `Lab` y `ENDSEM` se generaron de forma **independiente entre sí** (sin correlación perfecta), para que el ejercicio tuviera sentido: un estudiante puede ser alto en un componente y bajo en otro.
- `Total` = suma de las 4 notas.
- `Grade` se calculó a partir del `Total` con el esquema: A ≥75, B ≥60, C ≥50, D ≥40, E <40.

<p align="center">
<img width="646" alt="Dataset de 60 estudiantes en Excel" src="https://github.com/user-attachments/assets/16d14cfe-6707-4f71-8b8f-0758be07637c" /><br>
<sub><b>Figura 4.1.1.</b> Dataset de 60 estudiantes creado en Excel, con las columnas Roll No., Name, MST, Quiz, Lab, ENDSEM, Total y Grade.</sub>
</p>

El archivo se guardó como `students.csv` (Archivo → Guardar como → CSV separado por comas).

---

### 4.2. Preparación antes de discretizar

- Se eliminaron las columnas **Roll No.** y **Name**, ya que no aportan a la minería de asociación.

<p align="center">
<img width="516" alt="Dataset sin Roll No. y Name" src="https://github.com/user-attachments/assets/dea752f1-3e9a-4e21-88cc-3f7ebf31f516" /><br>
<sub><b>Figura 4.2.1.</b> Dataset resultante tras eliminar las columnas Roll No. y Name, listo para la discretización.</sub>
</p>

---

### 4.3. Discretización manual (columna por columna)

Se repitió el siguiente proceso de forma **independiente para cada una** de las 4 columnas numéricas (MST, Quiz, Lab, ENDSEM):

1. Se ordenó la columna (de mayor a menor).
2. Los **12 registros con las notas más altas** → reemplazados por **H**.
3. Los **12 registros con las notas más bajas** → reemplazados por **L**.
4. Los **36 registros restantes** (el medio) → reemplazados por **M**.
5. **Manejo de empates:** cuando el valor justo en el punto de corte se repetía entre dos o más estudiantes, el corte se desplazó hacia el grupo del medio (M), para no separar el mismo valor numérico en dos categorías distintas. Esto significa que, en algunas columnas, el grupo H o L quedó con menos de 12 registros.

El dataset final, con las 4 columnas convertidas a L/M/H y la columna Grade intacta, se guardó como `MARKS_discretizado.csv`.

<p align="center">
<img width="511" alt="Dataset discretizado L/M/H" src="https://github.com/user-attachments/assets/14759808-40c9-4cab-bad5-8765c16c226c" /><br>
<sub><b>Figura 4.3.1.</b> Dataset final discretizado (columnas MST, Quiz, Lab y ENDSEM en L/M/H), guardado como MARKS_discretizado.csv.</sub>
</p>

---

### 4.4. Carga en Weka y ejecución del algoritmo

- Se cargó `students.csv` en Weka (**Preprocess → Open file**).

<p align="center">
<img width="1003" alt="Dataset cargado en Weka" src="https://github.com/user-attachments/assets/a6a32170-f19c-4aca-899e-297669cc29b2" /><br>
<sub><b>Figura 4.4.1.</b> Dataset cargado en Weka mediante la pestaña Preprocess → Open file.</sub>
</p>

- En la pestaña **Associate** se ejecutó el algoritmo Apriori en **4 variantes distintas**, combinando dos factores:
  1. **car = True** vs **car = False**
  2. Dataset **con M** (valores L/M/H) vs dataset **sin M** (M reemplazado por `?`, quedando solo L y H)

**Nota técnica:** PredictiveApriori no viene incluido por defecto en Weka 3.8.7; se instaló como paquete adicional desde **Tools → Package Manager** buscando `predictiveApriori`. Como alternativa, también se puede usar el algoritmo **Apriori** normal, variando el parámetro `car`.

---

### 4.5. Ejecución 1 — car = True, con M (L/M/H)

Generic Object Editor con car=True y dataset con M.

<p align="center">
<img width="476" alt="Generic Object Editor car=True con M" src="https://github.com/user-attachments/assets/8663dfa3-4426-4b60-b358-f7376008c7d5" /><br>
<sub><b>Figura 4.5.1.</b> Configuración del Generic Object Editor con car=True sobre el dataset con M (L/M/H).</sub>
</p>

<p align="center">
<img width="1001" alt="Resultados Ejecución 1" src="https://github.com/user-attachments/assets/3dd756cc-33a6-42bb-87aa-a4e7661479f6" /><br>
<sub><b>Figura 4.5.2.</b> Resultados de la Ejecución 1 en la pestaña Associate.</sub>
</p>

```
Best rules found:

  1. Quiz(15)=L Total(100.0)=L 4 ==> Grade=E 4    acc:(0.96692)
  2. Lab(20.0)=L Total(100.0)=L 4 ==> Grade=E 4    acc:(0.96692)
  3. MST(20.0)=L Lab(20.0)=H 3 ==> Grade=B 3    acc:(0.94849)
  4. Quiz(15)=L ENDSEM(45.0)=L 3 ==> Grade=E 3    acc:(0.94849)
  5. Lab(20.0)=L ENDSEM(45.0)=L 3 ==> Grade=E 3    acc:(0.94849)
  6. Lab(20.0)=H ENDSEM(45.0)=H 3 ==> Grade=A 3    acc:(0.94849)
  7. MST(20.0)=L Quiz(15)=M ENDSEM(45.0)=H 3 ==> Grade=B 3    acc:(0.94849)
  8. Quiz(15)=M ENDSEM(45.0)=H Total(100.0)=M 3 ==> Grade=B 3    acc:(0.94849)
  9. MST(20.0)=H ENDSEM(45.0)=H 2 ==> Grade=A 2    acc:(0.91532)
 10. Quiz(15)=H Total(100.0)=H 2 ==> Grade=A 2    acc:(0.91532)
 11. Lab(20.0)=H ENDSEM(45.0)=L 2 ==> Grade=C 2    acc:(0.91532)
 12. ENDSEM(45.0)=L Total(100.0)=M 2 ==> Grade=C 2    acc:(0.91532)
 13. MST(20.0)=L Lab(20.0)=M ENDSEM(45.0)=M 2 ==> Grade=C 2    acc:(0.91532)
 14. MST(20.0)=M Lab(20.0)=H ENDSEM(45.0)=M 2 ==> Grade=B 2    acc:(0.91532)
 15. MST(20.0)=H Lab(20.0)=H Total(100.0)=M 2 ==> Grade=C 2    acc:(0.91532)
 16. MST(20.0)=H Lab(20.0)=H Total(100.0)=H 2 ==> Grade=A 2    acc:(0.91532)
 17. Quiz(15)=M Lab(20.0)=H ENDSEM(45.0)=M 2 ==> Grade=B 2    acc:(0.91532)
 18. MST(20.0)=M Quiz(15)=L Lab(20.0)=M ENDSEM(45.0)=H 2 ==> Grade=B 2    acc:(0.91532)
 19. Quiz(15)=H Lab(20.0)=H ENDSEM(45.0)=M Total(100.0)=M 2 ==> Grade=B 2    acc:(0.91532)
 20. MST(20.0)=H Total(100.0)=H 6 ==> Grade=A 5    acc:(0.70608)
```

---

### 4.6. Ejecución 2 — car = False, con M (L/M/H)

`car = False`: ya no se fuerza que Grade sea el consecuente; se generan reglas de asociación generales entre cualquier combinación de atributos (MST, Quiz, Lab, ENDSEM, Grade).

<p align="center">
<img width="1002" alt="Resultados Ejecución 2" src="https://github.com/user-attachments/assets/9e3747b2-fc50-4e16-a0ef-f0d517d954ee" /><br>
<sub><b>Figura 4.6.1.</b> Resultados de la Ejecución 2 (car=False, con M).</sub>
</p>

```
Best rules found:

  1. Grade=C 17 ==> Total(100.0)=M 17    acc:(0.99431)
  2. MST(20.0)=M Quiz(15)=M Total(100.0)=M 11 ==> ENDSEM(45.0)=M 11    acc:(0.9922)
  3. Grade=E 8 ==> Total(100.0)=L 8    acc:(0.98799)
  4. Grade=A 8 ==> Total(100.0)=H 8    acc:(0.98799)
  5. Lab(20.0)=L ENDSEM(45.0)=M 8 ==> MST(20.0)=M 8    acc:(0.98799)
  6. MST(20.0)=M Quiz(15)=H 7 ==> Total(100.0)=M 7    acc:(0.985)
  7. Lab(20.0)=M ENDSEM(45.0)=L 7 ==> Total(100.0)=L 7    acc:(0.985)
  8. MST(20.0)=M Quiz(15)=M Grade=C 7 ==> ENDSEM(45.0)=M Total(100.0)=M 7    acc:(0.985)
  9. MST(20.0)=M Lab(20.0)=L Total(100.0)=M 7 ==> ENDSEM(45.0)=M 7    acc:(0.985)
 10. MST(20.0)=L Grade=B 6 ==> Total(100.0)=M 6    acc:(0.98028)
 11. Quiz(15)=M Lab(20.0)=M Grade=C 6 ==> ENDSEM(45.0)=M Total(100.0)=M 6    acc:(0.98028)
 12. MST(20.0)=L ENDSEM(45.0)=M 5 ==> Total(100.0)=M 5    acc:(0.97261)
 13. Quiz(15)=H Grade=B 5 ==> ENDSEM(45.0)=M Total(100.0)=M 5    acc:(0.97261)
 14. Lab(20.0)=L Grade=C 5 ==> MST(20.0)=M ENDSEM(45.0)=M 5    acc:(0.97261)
 15. Lab(20.0)=L Grade=C 5 ==> MST(20.0)=M Total(100.0)=M 5    acc:(0.97261)
 16. Lab(20.0)=H Grade=B 5 ==> ENDSEM(45.0)=M 5    acc:(0.97261)
 17. MST(20.0)=M Quiz(15)=M ENDSEM(45.0)=L 5 ==> Total(100.0)=L 5    acc:(0.97261)
 18. MST(20.0)=M Lab(20.0)=L Grade=C 5 ==> ENDSEM(45.0)=M Total(100.0)=M 5    acc:(0.97261)
 19. MST(20.0)=M Lab(20.0)=M Grade=C 5 ==> ENDSEM(45.0)=M Total(100.0)=M 5    acc:(0.97261)
 20. MST(20.0)=H Quiz(15)=M ENDSEM(45.0)=M 5 ==> Lab(20.0)=M 5    acc:(0.97261)
```

---

### 4.7. Preparación del dataset sin M

Para descartar los valores intermedios y quedarse solo con combinaciones extremas de desempeño:

1. En Excel, se reemplazaron todos los valores **M** por **?** usando **Buscar y reemplazar** (Ctrl+H), con la opción *"Coincidir con el contenido de toda la celda"* activada para no afectar los encabezados de columna.
2. El archivo se guardó con un nombre distinto: `MARKS_sin_M.csv`.
3. Los `?` se interpretan como valores perdidos en Weka, por lo que se ignoran al generar las reglas, dejando solo las combinaciones de **L** y **H**.

<p align="center">
<img width="445" alt="Dataset sin M" src="https://github.com/user-attachments/assets/ca232511-4253-4e9c-9130-e02dc25bcb69" /><br>
<sub><b>Figura 4.7.1.</b> Dataset con los valores M reemplazados por ?, guardado como MARKS_sin_M.csv.</sub>
</p>

---

### 4.8. Ejecución 3 — car = True, sin M (solo L/H)

Generic Object Editor con car=True y dataset sin M.

<p align="center">
<img width="1006" alt="Generic Object Editor car=True sin M" src="https://github.com/user-attachments/assets/f3faad0c-ffb6-4303-a8a9-ea3d85ae1ca7" /><br>
<sub><b>Figura 4.8.1.</b> Resultados con car=True sobre el dataset sin M (solo L/H).</sub>
</p>

```
Best rules found:

  1. Quiz(15)=L Total(100.0)=L 4 ==> Grade=E 4    acc:(0.97555)
  2. Lab(20.0)=L Total(100.0)=L 4 ==> Grade=E 4    acc:(0.97555)
  3. MST(20.0)=L Lab(20.0)=H 3 ==> Grade=B 3    acc:(0.96471)
  4. Quiz(15)=L ENDSEM(45.0)=L 3 ==> Grade=E 3    acc:(0.96471)
  5. Lab(20.0)=L ENDSEM(45.0)=L 3 ==> Grade=E 3    acc:(0.96471)
  6. Lab(20.0)=H ENDSEM(45.0)=H 3 ==> Grade=A 3    acc:(0.96471)
  7. MST(20.0)=H ENDSEM(45.0)=H 2 ==> Grade=A 2    acc:(0.94427)
  8. Quiz(15)=H Total(100.0)=H 2 ==> Grade=A 2    acc:(0.94427)
  9. Lab(20.0)=H ENDSEM(45.0)=L 2 ==> Grade=C 2    acc:(0.94427)
 10. MST(20.0)=H Lab(20.0)=H Total(100.0)=H 2 ==> Grade=A 2    acc:(0.94427)
 11. MST(20.0)=H Total(100.0)=H 6 ==> Grade=A 5    acc:(0.77551)
 12. Lab(20.0)=H Total(100.0)=H 5 ==> Grade=A 4    acc:(0.7267)
 13. MST(20.0)=L ENDSEM(45.0)=H 4 ==> Grade=B 3    acc:(0.66837)
 14. ENDSEM(45.0)=L Total(100.0)=L 10 ==> Grade=E 7    acc:(0.63967)
 15. ENDSEM(45.0)=H Total(100.0)=H 7 ==> Grade=A 5    acc:(0.63457)
 16. Total(100.0)=L 12 ==> Grade=E 8    acc:(0.62295)
 17. Total(100.0)=H 12 ==> Grade=A 8    acc:(0.62295)
 18. MST(20.0)=L ENDSEM(45.0)=L 3 ==> Grade=E 2    acc:(0.59792)
 19. MST(20.0)=H Quiz(15)=H 3 ==> Grade=A 2    acc:(0.59792)
 20. Quiz(15)=L Lab(20.0)=L 3 ==> Grade=E 2    acc:(0.59792)
```

---

### 4.9. Ejecución 4 — car = False, sin M (solo L/H)

Generic Object Editor con car=False y dataset sin M.

<p align="center">
<img width="1002" alt="Generic Object Editor car=False sin M" src="https://github.com/user-attachments/assets/6ddc21f0-f7d7-442a-a19d-93384e1543cb" /><br>
<sub><b>Figura 4.9.1.</b> Resultados con car=False sobre el dataset sin M (solo L/H).</sub>
</p>

```
Best rules found:

  1. Grade=E 8 ==> Total(100.0)=L 8    acc:(0.98274)
  2. Grade=A 8 ==> Total(100.0)=H 8    acc:(0.98274)
  3. Quiz(15)=L Total(100.0)=L 4 ==> Grade=E 4    acc:(0.94439)
  4. Lab(20.0)=L Total(100.0)=L 4 ==> Grade=E 4    acc:(0.94439)
  5. MST(20.0)=L Lab(20.0)=H 3 ==> Grade=B 3    acc:(0.91356)
  6. MST(20.0)=L ENDSEM(45.0)=L 3 ==> Total(100.0)=L 3    acc:(0.91356)
  7. MST(20.0)=L Total(100.0)=L 3 ==> ENDSEM(45.0)=L 3    acc:(0.91356)
  8. Quiz(15)=L ENDSEM(45.0)=L 3 ==> Total(100.0)=L Grade=E 3    acc:(0.91356)
  9. Lab(20.0)=L ENDSEM(45.0)=L 3 ==> Total(100.0)=L Grade=E 3    acc:(0.91356)
 10. Lab(20.0)=H ENDSEM(45.0)=H 3 ==> Total(100.0)=H Grade=A 3    acc:(0.91356)
 11. ENDSEM(45.0)=L Grade=D 3 ==> Total(100.0)=L 3    acc:(0.91356)
 12. MST(20.0)=L Grade=E 2 ==> ENDSEM(45.0)=L Total(100.0)=L 2    acc:(0.85829)
 13. MST(20.0)=H ENDSEM(45.0)=H 2 ==> Total(100.0)=H Grade=A 2    acc:(0.85829)
 14. Quiz(15)=L Total(100.0)=H 2 ==> ENDSEM(45.0)=H 2    acc:(0.85829)
 15. Quiz(15)=H Total(100.0)=H 2 ==> MST(20.0)=H Grade=A 2    acc:(0.85829)
 16. Quiz(15)=H Grade=A 2 ==> MST(20.0)=H Total(100.0)=H 2    acc:(0.85829)
 17. Lab(20.0)=H ENDSEM(45.0)=L 2 ==> Grade=C 2    acc:(0.85829)
 18. ENDSEM(45.0)=L Grade=C 2 ==> Lab(20.0)=H 2    acc:(0.85829)
 19. MST(20.0)=H Lab(20.0)=H Total(100.0)=H 2 ==> Grade=A 2    acc:(0.85829)
 20. Grade=E 8 ==> ENDSEM(45.0)=L Total(100.0)=L 7    acc:(0.79178)
```
### 10.7 Aplicación del Algoritmo Apriori en Weka en un Dataset más grande del Mundo Real

Se procedió a tabular los datos en Excel, guardando posteriormente el archivo en formato CSV con el nombre DailyItem2 Data set. La estructura del archivo se aprecia en la siguiente imagen:

<img width="492" height="178" alt="image" src="https://github.com/user-attachments/assets/543cf300-50b4-4890-b05e-69a881e19a1e" />

Para ejecutar el algoritmo, se inició Weka y se seleccionó la opción "Explorer". Dentro de la pestaña "Preprocess", se importó el archivo CSV generado en el paso anterior mediante el botón
"Open file"

<img width="884" height="671" alt="image" src="https://github.com/user-attachments/assets/7cf8dfb5-5437-46c4-a280-5173a0f1e24b" />

Al cargar el archivo, Weka interpreta inicialmente las columnas como valores numéricos. Dado que el algoritmo Apriori requiere datos nominales, fue necesaria una conversión.
En el apartado de filtros (Filter), se seleccionó el botón "Choose" y se navegó a la ruta:
• filters > unsupervised > attribute > NumericToNominal.
Finalmente, se confirmó la acción haciendo clic en "Apply".

<img width="883" height="284" alt="image" src="https://github.com/user-attachments/assets/f7507ffa-f8b5-44d3-9d19-42dde280026c" />

Se eliminó el atributo "Transaction" del panel izquierdo para centrar el análisis en los ítems relevantes. Para ello, se seleccionó dicho atributo y se presionó el botón "Remove", como se muestra a continuación:

<img width="590" height="760" alt="image" src="https://github.com/user-attachments/assets/d6d4008f-e1ed-4a69-841b-55591c4381e2" />

Se accedió a la pestaña "Associate" ubicada en la barra de navegación superior. Allí, se seleccionó Apriori como el algoritmo de reglas de asociación a utilizar

<img width="573" height="180" alt="image" src="https://github.com/user-attachments/assets/1fba9a0c-86bc-4200-9bf3-c111b68b1217" />

Al hacer clic sobre el campo de texto del algoritmo, se abrió la ventana "Generic Object Editor". Se modificaron los parámetros predeterminados para ajustar el análisis:
• Se estableció el lowerBoundMinSupport en 0.5, el metricType en Confidence y el minMetric en 0.75.

<img width="587" height="782" alt="image" src="https://github.com/user-attachments/assets/c21d62e4-b77d-44a9-aa16-7d6004c47f95" />

Finalmente, se ejecutó el algoritmo presionando el botón "Start". A continuación, se presentan los resultados obtenidos:

<img width="884" height="662" alt="image" src="https://github.com/user-attachments/assets/c065f72f-d3c3-4325-b7ac-697e8b51b96d" />

## Interpretación de resultados: 
El análisis realizado sobre el conjunto de cinco transacciones, configurado con un soporte mínimo de 0.5 y una confianza de 0.75, reveló como hallazgo principal una fuerte asociación positiva entre la compra de Cornflakes y Mermelada.
Específicamente, la regla más significativa indica que la adquisición de Cornflakes implica la compra de Mermelada con una confianza del 100% y un Lift de 1.25, lo que demuestra una dependencia directa entre ambos productos. Adicionalmente, se identificaron relaciones frecuentes bidireccionales entre el Pan y la Mermelada con una confianza del 75%, aunque la correlación entre cereales y mermelada se mantiene como el patrón más robusto y predictivo dentro de la muestra estudiada.
