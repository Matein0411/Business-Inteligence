# Cómo definir el número de clusters si la data está sin etiquetar

## Suma de errores cuadráticos

La forma más útil de decidir el número de clústeres es revisar cómo disminuye el error al probar distintos valores de $k$. Cuando la mejora empieza a hacerse pequeña, se suele considerar que se llegó a un punto adecuado.

## Pasos para realizar operaciones en Weka

### Paso 1: Configurar y aplicar el algoritmo Simple k-Means
* Se debe especificar el número de clústeres (`numClusters`) a tres.
* Se debe establecer la opción `displayStdDevs` en verdadero (`true`) para poder ver las desviaciones estándar.
* En el modo de clúster, se debe seleccionar el uso del conjunto de entrenamiento (`Use training set`).
* Se debe seleccionar la opción para almacenar los clústeres para su visualización (`Store clusters for visualization`).
* Se debe ignorar el atributo de la clase mediante la opción `Ignore attributes` y seleccionando `Class` en el cuadro de diálogo.

![](./image1.png){width="4.9in"}

![](./image2.png){width="4.9in"}

### Paso 2: Evaluar y visualizar los clústeres
* Para comparar los resultados del algoritmo con los clústeres reales, se debe seleccionar `Classes to cluster evaluation` en el modo de clúster y volver a ejecutar el algoritmo.
* Los clústeres asignados se pueden visualizar en un gráfico; al hacer clic derecho en cualquier punto, se puede obtener más información sobre la muestra asociada.

![](./image3.png){width="4.9in"}

![](./image4.png){width="4.9in"}

### Paso 3: Agregar clústeres al conjunto de datos
* En la pestaña de preprocesamiento (`Preprocess`), se debe cargar el conjunto de datos y seleccionar `No class` para que Weka no asuma ningún atributo como clase.
* Se debe ir a la opción `Choose` y seleccionar el filtro `AddCluster` sin aplicarlo inmediatamente.
* Se debe configurar el filtro eligiendo el agrupador `SimpleKMeans`, especificando `numClusters` como 3, e ignorando el atributo original cambiando `IgnoredAttributeIndices` a 5.
* Se debe aplicar el filtro haciendo clic en `Apply`, lo que ejecuta automáticamente el algoritmo y agrega un nuevo atributo llamado `cluster`.
* Se puede hacer clic en el botón `Edit` para abrir el visor y comparar los valores del nuevo atributo de clúster con la columna original.

![](./image5.png){width="4.9in"}

![](./image6.png){width="4.9in"}

![](./image7.png){width="4.9in"}

### Paso 4: Aplicar el algoritmo de clasificación (J48) a los clústeres
* En la pestaña `Preprocess`, se debe eliminar el atributo `Class` para que no se use durante la construcción del árbol de decisión.
* Se debe ir a la pestaña `Classify`, elegir el clasificador `J48` con las configuraciones predeterminadas y ejecutarlo.
* Al hacer clic derecho en el modelo en la lista de resultados, se obtiene una representación visual del árbol de decisión.

![](./image8.png){width="4.9in"}

![](./image9.png){width="4.9in"}

![](./image10.png){width="4.9in"}

### Paso 5: Podar el árbol de decisión
* Se debe hacer doble clic en la opción del clasificador `J48` para abrir el editor genérico de objetos.
* Se debe incrementar el número mínimo de objetos permitidos en las hojas del árbol (`minNumObj`) pasando de su valor por defecto de 2 a un valor de 10.

![](./image11.png){width="4.9in"}

![](./image12.png){width="4.9in"}

![](./image13.png){width="4.9in"}

![](./image14.png){width="4.9in"}