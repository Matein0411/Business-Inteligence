![](./image1.png){width="1.8534448818897638in"
height="2.953928258967629in"}

![](./image2.png){width="5.905555555555556in"
height="3.807638888888889in"}

![](./image3.png){width="5.905555555555556in"
height="4.415972222222222in"}

![](./image4.png){width="5.905555555555556in"
height="4.430555555555555in"}

![](./image5.png){width="5.905555555555556in" height="4.43125in"}

![](./image6.png){width="5.905555555555556in"
height="0.46319444444444446in"}

![](./image7.png){width="5.905555555555556in"
height="0.5951388888888889in"}

Cómo definir el número de clusters si la data está sin etiquetar?

Suma de errores cuadráticos

![](./image8.png){width="5.905555555555556in"
height="4.942361111111111in"}

![](./image9.png){width="3.1005949256342955in"
height="3.34086832895888in"}

![](./image10.png){width="4.793149606299212in"
height="2.971481846019248in"}

![](./image11.png){width="5.905555555555556in"
height="5.924305555555556in"}

![](./image12.png){width="5.905555555555556in"
height="4.4006944444444445in"}

![](./image13.png){width="4.26663167104112in"
height="4.311284995625547in"}

![](./image14.png){width="5.905555555555556in"
height="4.356944444444444in"}

# Pasos para realizar operaciones en Weka

## Paso 1: Configurar y aplicar el algoritmo Simple k-Means
* Se debe especificar el número de clústeres (`numClusters`) a tres[cite: 1].
* Se debe establecer la opción `displayStdDevs` en verdadero (`true`) para poder ver las desviaciones estándar[cite: 1].
* En el modo de clúster, se debe seleccionar el uso del conjunto de entrenamiento (`Use training set`)[cite: 1].
* Se debe seleccionar la opción para almacenar los clústeres para su visualización (`Store clusters for visualization`)[cite: 1].
* Se debe ignorar el atributo de la clase mediante la opción `Ignore attributes` y seleccionando `Class` en el cuadro de diálogo[cite: 1].

[Espacio para imagen]

## Paso 2: Evaluar y visualizar los clústeres
* Para comparar los resultados del algoritmo con los clústeres reales, se debe seleccionar `Classes to cluster evaluation` en el modo de clúster y volver a ejecutar el algoritmo[cite: 1].
* Los clústeres asignados se pueden visualizar en un gráfico; al hacer clic derecho en cualquier punto, se puede obtener más información sobre la muestra asociada[cite: 1].

[Espacio para imagen]

## Paso 3: Agregar clústeres al conjunto de datos
* En la pestaña de preprocesamiento (`Preprocess`), se debe cargar el conjunto de datos y seleccionar `No class` para que Weka no asuma ningún atributo como clase[cite: 1].
* Se debe ir a la opción `Choose` y seleccionar el filtro `AddCluster` sin aplicarlo inmediatamente[cite: 1].
* Se debe configurar el filtro eligiendo el agrupador `SimpleKMeans`, especificando `numClusters` como 3, e ignorando el atributo original cambiando `IgnoredAttributeIndices` a 5[cite: 1].
* Se debe aplicar el filtro haciendo clic en `Apply`, lo que ejecuta automáticamente el algoritmo y agrega un nuevo atributo llamado `cluster`[cite: 1].
* Se puede hacer clic en el botón `Edit` para abrir el visor y comparar los valores del nuevo atributo de clúster con la columna original[cite: 1].

[Espacio para imagen]

## Paso 4: Aplicar el algoritmo de clasificación (J48) a los clústeres
* En la pestaña `Preprocess`, se debe eliminar el atributo `Class` para que no se use durante la construcción del árbol de decisión[cite: 1].
* Se debe ir a la pestaña `Classify`, elegir el clasificador `J48` con las configuraciones predeterminadas y ejecutarlo[cite: 1].
* Al hacer clic derecho en el modelo en la lista de resultados, se obtiene una representación visual del árbol de decisión[cite: 1].

[Espacio para imagen]

## Paso 5: Podar el árbol de decisión
* Se debe hacer doble clic en la opción del clasificador `J48` para abrir el editor genérico de objetos[cite: 1].
* Se debe incrementar el número mínimo de objetos permitidos en las hojas del árbol (`minNumObj`) pasando de su valor por defecto de 2 a un valor de 10[cite: 1].

[Espacio para imagen]