# <center> **ESCUELA POLITÉCNICA NACIONAL** </center>

**Integrantes**
* Betancourt Alison
* Calvache Mateo
* Camacho Julián
* Villareal Alexis
* Yunga Mateo

## **Índice de Contenidos**

1. [Índice de Figuras](#índice-de-figuras)
2. [Predecir](#predecir)
3. [Referencias bibliográficas](#referencias-bibliográficas)
4. [Declaración de porcentaje de uso de IA](#declaración-de-porcentaje-de-uso-de-ia)

### **Índice de Figuras**
* [Figura 1. Resultados del modelo Naive Bayes en Weka.](#figura-1)
* [Figura 2. Código Python para calcular la predicción con Naive Bayes.](#figura-2)
* [Figura 3. Salida general de la evaluación del clasificador sobre el conjunto de entrenamiento.](#figura-3)
* [Figura 4. Probabilidad calculada para la clase SÍ jugar.](#figura-4)
* [Figura 5. Probabilidad calculada para la clase NO jugar.](#figura-5)
* [Figura 6. Selección de la herramienta ArffViewer desde el menú Tool.](#figura-6)
* [Figura 7. Edición del archivo de prueba dentro de ArffViewer.](#figura-7)
* [Figura 8. Registro de prueba con el atributo de clase en blanco.](#figura-8)
* [Figura 9. Carga del archivo weather.nominal.arff en la pestaña Preprocess.](#figura-9)
* [Figura 10. Configuración del clasificador NaiveBayes en la pestaña Classify.](#figura-10)
* [Figura 11. Selección de la opción Supplied test set para usar el archivo de prueba.](#figura-11)
* [Figura 12. Configuración de la salida PlainText para las predicciones.](#figura-12)
* [Figura 13. Predicción de la instancia desconocida como Play: Yes.](#figura-13)
* [Figura 14. Resultados obtenidos al repetir la prueba con el clasificador J48.](#figura-14)

---

<div align="center">
  <img width="748" height="528" alt="image" src="https://github.com/user-attachments/assets/4efb3307-fe22-43f4-8f17-5669099eb5d1" />
  <div>Figura 1. Resultados del modelo Naive Bayes en Weka.</div>
</div>



<div align="center">
  <img width="455" height="336" alt="image" src="https://github.com/user-attachments/assets/9b08e146-ce69-4939-bb5a-d0f727d17bb8" />
  <div>Figura 2. Código Python para calcular la predicción con Naive Bayes.</div>
</div>



<div align="center">
  <img width="1001" height="754" alt="image" src="https://github.com/user-attachments/assets/f1ea3a12-6c67-43ff-87c1-77a76db2ac09" />
  <div>Figura 3. Salida general de la evaluación del clasificador sobre el conjunto de entrenamiento.</div>
</div>


```=== Run information ===

Scheme:       weka.classifiers.bayes.NaiveBayes 
Relation:     weather.symbolic
Instances:    14
Attributes:   5
              outlook
              temperature
              humidity
              windy
              play
Test mode:    evaluate on training data

=== Classifier model (full training set) ===

Naive Bayes Classifier

                Class
Attribute         yes     no
               (0.63) (0.38)
=============================
outlook
  sunny            3.0    4.0
  overcast         5.0    1.0
  rainy            4.0    3.0
  [total]         12.0    8.0

temperature
  hot              3.0    3.0
  mild             5.0    3.0
  cool             4.0    2.0
  [total]         12.0    8.0

humidity
  high             4.0    5.0
  normal           7.0    2.0
  [total]         11.0    7.0

windy
  TRUE             4.0    4.0
  FALSE            7.0    3.0
  [total]         11.0    7.0



Time taken to build model: 0 seconds

=== Evaluation on training set ===

Time taken to test model on training data: 0 seconds

=== Summary ===

Correctly Classified Instances          13               92.8571 %
Incorrectly Classified Instances         1                7.1429 %
Kappa statistic                          0.8372
Mean absolute error                      0.2917
Root mean squared error                  0.3392
Relative absolute error                 62.8233 %
Root relative squared error             70.7422 %
Total Number of Instances               14     

=== Detailed Accuracy By Class ===

                 TP Rate  FP Rate  Precision  Recall   F-Measure  MCC      ROC Area  PRC Area  Class
                 1.000    0.200    0.900      1.000    0.947      0.849    0.922     0.947     yes
                 0.800    0.000    1.000      0.800    0.889      0.849    0.911     0.911     no
Weighted Avg.    0.929    0.129    0.936      0.929    0.926      0.849    0.918     0.934     

=== Confusion Matrix ===

 a b   <-- classified as
 9 0 | a = yes
 1 4 | b = no
```

```python
def naive_bayes_play(outlook, temperature, humidity, windy):
  P_yes = 0.63
  P_no = 0.38
  total_yes = 12.0
  total_no = 8.0
  probs = {
      'yes': {
          'outlook': {'sunny': 3.0 / total_yes, 'overcast': 5.0 / total_yes, 'rainy': 4.0 / total_yes},
          'temperature': {'hot': 3.0 / total_yes, 'mild': 5.0 / total_yes, 'cool': 4.0 / total_yes},
          'humidity': {'high': 4.0 / 11.0, 'normal': 7.0 / 11.0},
          'windy': {'true': 4.0 / 11.0, 'false': 7.0 / 11.0},
      },
      'no': {
          'outlook': {'sunny': 4.0 / total_no, 'overcast': 1.0 / total_no, 'rainy': 3.0 / total_no},
          'temperature': {'hot': 3.0 / total_no, 'mild': 3.0 / total_no, 'cool': 2.0 / total_no},
          'humidity': {'high': 5.0 / 7.0, 'normal': 2.0 / 7.0},
          'windy': {'true': 4.0 / 7.0, 'false': 3.0 / 7.0},
      }
  }

  def calc_prob(clase):
    return (
        (P_yes if clase == 'yes' else P_no) *
        probs[clase]['outlook'][outlook] *
        probs[clase]['temperature'][temperature] *
        probs[clase]['humidity'][humidity] *
        probs[clase]['windy'][windy]
    )

  prob_yes = calc_prob('yes')
  prob_no = calc_prob('no')
  total = prob_yes + prob_no
  prob_yes /= total
  prob_no /= total

  print(f"\n🔍 Resultados:")
  print(f"Probabilidad de SÍ jugar: {prob_yes:.4f}")
  print(f"Probabilidad de NO jugar: {prob_no:.4f}")

  return 'yes' if prob_yes > prob_no else 'no'

print("Ingrese los datos del clima:")
outlook = input("→ Outlook (sunny / overcast / rainy): ").strip().lower()
temperature = input("→ Temperature (hot / mild / cool): ").strip().lower()
humidity = input("→ Humidity (high / normal): ").strip().lower()
windy = input("→ Windy (true / false): ").strip().lower()

prediccion = naive_bayes_play(outlook, temperature, humidity, windy)
print(f"\n Predicción final: {'JUGAR' if prediccion == 'yes' else 'NO JUGAR'}")
```

<div align="center">
  <img width="365" height="200" alt="image" src="https://github.com/user-attachments/assets/b81c2705-015c-433d-937c-f19b00eec4d4" />
  <div>Figura 4. Probabilidad calculada para la clase SÍ jugar.</div>
</div>


<div align="center">
  <img width="357" height="202" alt="image" src="https://github.com/user-attachments/assets/eebf3459-0e7a-402a-b864-c7147010fb6d" />
  <div>Figura 5. Probabilidad calculada para la clase NO jugar.</div>
</div>


## Predecir
1. Se hizo clic en la opción Tool del menú y se seleccionó ArffViewer.


<div align="center">
  <img width="390" height="151" alt="Screenshot 2026-06-30 185406" src="https://github.com/user-attachments/assets/97fb8bfb-59b6-4726-a0c5-531278b7c560" />
  <div>Figura 6. Selección de la herramienta ArffViewer desde el menú Tool.</div>
</div>


3. Se hizo clic en File → Open y se seleccionó el archivo weather.nominal.arff.
4. Luego, se seleccionaron todos los registros en ArffViewer, excepto uno, ya que ese se reservó como registro de prueba.
Se hizo clic en Edit → Delete Instances.
5. A continuación, se modificaron los valores del registro restante, asignándoles los valores que se utilizaron como instancia de prueba, mediante las herramientas de edición disponibles en el ArffViewer.
6. Se dejó en blanco el atributo de clase, ya que se deseó que su valor fuera predicho por el clasificador.


<div align="center">
  <img width="716" height="399" alt="Screenshot 2026-06-30 185527" src="https://github.com/user-attachments/assets/3dadfc64-c078-4b8b-8c00-93684ae1d071" />
  <div>Figura 7. Edición del archivo de prueba dentro de ArffViewer.</div>
</div>

<div align="center">
  <img width="363" height="137" alt="image" src="https://github.com/user-attachments/assets/1d1a4d77-d9ac-4a84-9917-9c14c008c112" />
  <div>Figura 8. Registro de prueba con el atributo de clase en blanco.</div>
</div>


7. Después de modificar los valores de la(s) fila(s), se guardó el archivo con el nombre test.arff.
8. Luego, se fue a la pestaña Preprocess y se hizo clic en la opción Open file, seleccionando el archivo weather.nominal.arff.


<div align="center">
  <img width="1006" height="754" alt="Screenshot 2026-06-30 191335" src="https://github.com/user-attachments/assets/a98b5c1c-e719-4c7a-a308-3a4fa21230bd" />
  <div>Figura 9. Carga del archivo weather.nominal.arff en la pestaña Preprocess.</div>
</div>


9. A continuación, se seleccionó la pestaña Classify y se eligió el clasificador NaiveBayes.
10. Se hizo clic en el botón Start, lo que permitió construir el clasificador.


<div align="center">
  <img width="1003" height="753" alt="image" src="https://github.com/user-attachments/assets/14f7ec5c-d7d2-415e-b36f-4b2ed8d39a9b" />
  <div>Figura 10. Configuración del clasificador NaiveBayes en la pestaña Classify.</div>
</div>


11. Se seleccionó la opción Supplied test set y se hizo clic en el botón Set.
12. Posteriormente, se abrió el archivo con Open File y se seleccionó test.arff. 


<div align="center">
  <img width="1006" height="754" alt="image" src="https://github.com/user-attachments/assets/2b349baf-be7d-461c-bbe4-4538f8b4a529" />
  <div>Figura 11. Selección de la opción Supplied test set para usar el archivo de prueba.</div>
</div>


13. En More Options, se seleccionó PlainText en Output predictions.


<div align="center">
  <img width="425" height="477" alt="image" src="https://github.com/user-attachments/assets/010b04e5-690f-4021-92b2-2c26a6d761ef" />
  <div>Figura 12. Configuración de la salida PlainText para las predicciones.</div>
</div>


14. Finalmente, se hizo clic en el botón Start para aplicar el clasificador sobre la(s) instancia(s) de prueba.
15. En este caso, el clasificador predijo una instancia desconocida como Play: Yes.


<div align="center">
  <img width="1001" height="753" alt="image" src="https://github.com/user-attachments/assets/8928bad3-b897-4c3b-9656-51a17327a9e2" />
  <div>Figura 13. Predicción de la instancia desconocida como Play: Yes.</div>
</div>


16. Se repitió lo mismo para J48:


<div align="center">
  <img width="1005" height="752" alt="image" src="https://github.com/user-attachments/assets/f3892bc4-129d-4356-a1e1-6469d24f3d5e" />
  <div>Figura 14. Resultados obtenidos al repetir la prueba con el clasificador J48.</div>
</div>

## Referencias bibliográficas

1. Microsoft, "Algoritmo Bayes naive de Microsoft", *[Microsoft Learn](https://learn.microsoft.com/)*, 2026. [En línea]. Disponible en: https://learn.microsoft.com/es-es/analysis-services/data-mining/microsoft-naive-bayes-algorithm. [Accedido: 30-jun-2026].

## Declaración de porcentaje de uso de IA

Se estimó un 15% de uso de IA en la elaboración de este informe. Ese porcentaje se justificó porque la IA se utilizó únicamente como apoyo puntual para ajustar la redacción a tercera persona y tiempo pasado, además de ayudar a incorporar las nuevas secciones solicitadas; en cambio, el contenido técnico, la secuencia de pasos, las capturas y la mayor parte del desarrollo fueron elaborados de forma manual.



