# Viz_2022_Grupo_4

Tp final de la materia: "Visualización de la información". El tema es resolver un challenge de [VAST](https://vast-challenge.github.io/2022/) (Competición)

## Integrantes

* Bertolini Lucas
* Galíndez, Raúl
* Gentile, Matias
* Suster, Mateo


## Profesores

* Claudio Delrieux - cad@uns.edu.ar 
	* Laboratorio de Ciencias de las Imágenes - www.imaglabs.org
	* Universidad Nacional del Sur - www.uns.edu.ar
* Germán Rosati - german.rosati@gmail.com
	* EIDAES-UNSAM / CONICET
* Paula Feldman - paulaadifeldman1@gmail.com
	* CONICET


## Tema: Economía

Nos toca el "Challenge 3": **Economic considers the financial health of the city.** 

* Over time, 
	* are businesses growing or shrinking?
	* How are people changing jobs?
	* Are standards of living improving or declining over time?
	* Consider the financial status of Engagement's businesses and residents, and use visual analytic techniques to address these questions.

* Over the period covered by the dataset, 
	* which businesses appear to be more prosperous?
	* Which appear to be struggling?
	* Describe your rationale for your answers. 

* How does the financial health of the residents change over the period covered by the dataset?
	* How do wages compare to the overall cost of living in Engagement?
	* Are there groups that appear to exhibit similar patterns?
	* Describe your rationale for your answers.

* Describe the health of the various employers within the city limits. 
	* What employment patterns do you observe?
	* Do you notice any areas of particularly high or low turnover?

* Limit your response to 10 images and 500 words.


## Ideas

Por donde podemos responder?

- **activitylog**:
  - Tabla más rica. Info cada 5 minutos. Diferente status de la persona.
  - Campos "relevantes"
    - Jobid -> en que trabajo anda (trabajo pertenece a empleador)
    - Balance -> Saldo de plata que tiene
    - financial status -> Posibles valores 
        - Unknown
      	- NA
      	- Stable
      	- Unstable
    - currentMode -> Cuanto tiempo están en el trabajo?
    - hungerStatus -> Tiempo promedio con hambre?
    - dailyFoodBudget -> Puede haber alguna correlacion entre el presupuesto diario y la situacion financiera?
    - weeklyExtraBudget -> Puede haber alguna correlacion entre el presupuesto diario y la situacion financiera?
  - Join con demográficos
    - _Participants_ -> Hay info demografica
    - No pareciera variar en el tiempo
  - 

- jobs + employeers
  - Un employeer tiene puestos de trabajos
  - A veces estan ocupados y a veces libres
  - Posible gráfico:
    - Evolucion de trabajos vacantes y resueltos
    - Evolucion de cantidad de empleados por job_id
    - Evolucion de empleados por empleador

- Travel journal, podria servir
  - Location (Start and end)
  - Balance (Start and end)
  - Como se mueven y gastan. Toca ver si hay algo util.
  - Podremos cruzarlo con la info de la ubicacion de los locales. O sera muy desconectado uno de otro?


- **financialjournal**
  - Transaciones por categoria. No estan muy balanceadas, pero muestran transaccionalidad. 
    - No veo forma de conectarla con otras tablas
  - Categorias
    - 'wage' -> Salario. Valor positivo
    - 'food' -> Gasto en comida. Valor negativo
    - 'shelter' -> Gasto en 'refugio'/abrigo/Casa?. Valor negativo
    - 'Education' -> Gasto en educacion
  - Tablas agregadas: 
    - En vo_monthly_wage y en vo_daily_wage
    - Gasto por persona por (mes/dia). Por categoria, suma de ingresos, suma de egresos, balance
  - Chances de visualizar:
    - Lineas - Gasto promedio
    - Lineas - Gasto promedio + gastos individuales en distinto tono
    - Scatter individual, fecha-gasto
    - Scatter individual ingreso/egreso
  - Algun gasto es de mayor 'calidad' ¿?
    - Educacion podria ser mayor calidad de vida
    - Shelter y food gasto mas básicos
    - Aumento de ingreso, suele traducirse en mejor calidad de vida

### Preguntas // Clarificaciones

* Datos cada 5 minutos, si duerme o si está despierto. Como es? 
	* Debe ser medio falsie.

* Pubs y restaurantes. Tienen id medio arbitrarios, pocos y no arranca en 0. Se podra joinear con otras tablas? Digamos, un restaurante podria tener el mismo id que el employee? 
  * Si no fuera asi, no pareciera que se puede joinear con nada.

## Otros links

* Grupos: https://docs.google.com/spreadsheets/d/16eXIyc0YHMzcuYzlnSdzsrck2TOyh8MoxgsJnjFgouA/edit#gid=0
* Challenge: https://vast-challenge.github.io/2022/
* Datos: https://drive.google.com/file/d/1a1gMCQpw3kjmYbvygWd-yT-5dmPQ8EVN/view