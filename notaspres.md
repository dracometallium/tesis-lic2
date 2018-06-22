<!-- vim: set spell spelllang=es syntax=markdown : -->

Pag. 1

Mi nombre es RC, el trabajo mi tesis se titula "_Un sistema paralelo de visíon
global para fútbol de robots orientado al uso educativo_". Mi tutor de tesis es
Javier Balladini, y conté con la codirección de Eduardo Grosclaude.

---

Pag. 2

En esta presentación voy a comenzar contándoles un poco que es un sistema de
visión global para fútbol de robots (en especifico para la liga de tamaño
pequeño). También les voy a explicar por que nos interesa utilizar este sistema
como una herramienta educativa y por que decidimos hacerlo paralelo.

Una vez establecido el marco voy a pasar a describirles el sistema que
desarrollamos. Para esto voy a contarles que oportunidades de paralelismo
encontramos, que consideraciones tuvimos que tener en cuenta para la división
de los datos, y la arquitectura del sistema. Luego les voy a mostrar que
experimentos realizamos para verificar que el sistema pueda ser utilizado
satisfactoriamente, y cuales son sus posibles usos educativos.

Al final de la presentación les voy a resumir las conclusiones a las cuales
llegamos y que posibles trabajos futuros vemos disponibles.

---

Pag. 3

Nos vamos a enforcar en la liga de tamaño pequeño de la RoboCup. En esta liga se
enfrentan dos equipos de seis robots cilíndricos que se mueven sobre un conjunto
de ruedas omnidireccionales y con autonomía reducida. Cada equipo tiene su
propia computadora encargada de realizar el planeamiento de los robots, y estas
a su vez perciben el ambiente a través de un sistema de visión global
compartido.

---

Pag. 4

Para poder identificar y detectar la orientación de cada robot, estos tienen un
conjunto de 5 parches en su parte superior, el parche central indica el equipo
del robot, y la pelota es de un color liso que no es utilizado por los parches.

Sobre las cachas un conjunto de cámaras capturan un video del ambiente y envían
los cuadros a la computadora donde se ejecuta el sistema de visión global. Cada
cuadro es procesado y se detecta la posición de los robots y pelota, luego
envían esos datos a cada una de las computadoras de los equipos. Con esa
información cada equipo desarrolla estrategias de juego y envían ordenes de
movimiento a los robots de su equipo a través de una red inalámbrica.

---

Pag. 5

Actualmente existen dos tamaños de cancha, las canchas de tamaño simple son de
4m * 6m, y las de tamaño doble son de 6m * 8m. Para capturar toda la cancha, en
las de tamaño simple se utilizan 2 cámaras, cada una sobre media cancha, y en
las de tamaño grande se utilizan 4 cámaras, dos por cada media cancha.

Desde el 2016 las canchas predeterminadas son las de tamaño doble. Este cambio
se realizo con el fin de permitir mayor libertad de movimiento y expandir el
árbol de estrategias posibles.

Una implicación importante del aumento del tamaño, es que se duplico la cantidad
de información que debe procesarse en cada cuadro, y es esperable que en el
futuro las canchas sigan aumentando su tamaño.

---

Pag. 6

Como el problema es de tiempo y ambiente real, pero controlado y con parámetros
bien definidos, consideramos que es ideal para la introducción a la visión por
computadora.

Pero la RoboCup ya tiene su propio sistema de visión global llamado
_SSL-VISION_. Este es un sistema basado en plugins que ejecuta utilizando solo
dos hilos de ejecución, uno para la captura y procesamiento de los cuadros, y el
otro para la interfaz de usuario.

Para que el software pueda cumplir con los requerimientos de tiempos mínimos
utilizando un solo hilo para la captura y procesamiento, los plugins tienen
optimizaciones avanzadas que pueden dificultar su uso como herramienta
educativa.

Ademas, el software no es escalable, aunque el tamaño de las canchas siga
aumentando.

---

Pag. 7

NOTA: Falta mencionar el sistema de Guille.

Con esos problemas en mente nos propusimos como objetivo la creación de un nuevo
sistema de visión global paralelo con fines educativos. El sistema debe cumplir
los siguientes objetivos:

- Plugins más sencillos para facilitar su uso educativo, aunque se deba
  sacrificar eficiencia.
- Que sea escalable.
- Que sea un framework orientado al desarrollo de aplicaciones paralelas, que
  permita explorar distintas técnicas de paralelismo.

---

Pag. 8

Analizando el problema encontramos dos oportunidades de paralelismo. En primer
lugar, dado que los cuadros son independientes entre si, se pueden analizar en
paralelo, esto no produciría cambios en la información, salvo por el orden. Por
otro lado, se puede dividir el cuadro y procesar cada parte de forma
independiente. En este caso hay que tener consideraciones especiales.

---

Pag. 9

Para poder identificar a un robot, todos los parches deben ser observables
dentro del mismo fragmento del cuadro. Por esto se debe establecer un área
compartida entre fragmentos adjuntos. Como se puede apreciar en la imagen, el
ancho mínimo de esta franja debe ser el ancho de un robot.

---

Pag. 10

Esta área compartida trae otro problema, el área total de los fragmentos sera
mayor que el área del cuadro original, lo que implica un incremento en los
píxeles a analizar.

Para reducir el área total se debe reducir el perímetro de los fragmentos. Dado
que se trabaja con el teselado de rectángulos, para que estos tengan el
perímetro mínimo se debe intentar que la relación entre su ancho y alto sean lo
más cercana a uno posible.

Otra condición que se impuso es que los fragmentos sean todos de igual tamaño, para
poder distribuir la carga de forma uniforme. Esto no siempre sera verdad, ya que
el tiempo de procesamiento de un cuadro no depende solo de su área, sino también
de los elementos encontrados en el, pero dado que esta información no se puede
obtener antes de procesar el cuadro, la heurística del tamaño nos parece la más
acertada.

En este punto ya se puede notar una particularidad, dada estas restricciones, si
un cuadro se divide en una cantidad de fragmentos prima, la imagen se dividirá
en franjas, aumentando bruscamente el área compartida.

---

Pag. 11

En el sistema existen dos tipos de tareas, las tareas a las que llamamos
estáticas, las cuales existen durante toda la ejecución del programa, son
únicas, y tienen un hilo de ejecución propio. Por otro lado las tareas a las que
llamamos de "tareas de búsqueda" (ya que son estas las que realmente realizan la
búsqueda de los robots y pelota) son tareas creadas para el procesamiento de un
cuadro o fragmento especifico, toman hilos de ejecución de un pool de hilos
compartido, y puede haber múltiples del mismo tipo, cada una procesando un
cuadro o fragmento distinto.

Las tareas estáticas son la generación de cuadros (ya sea de una cámara o un
video) y la generación de tareas de fragmentación de cuadros.

Las tareas de búsqueda son la fragmentación del cuadro y el procesamiento del
fragmento.

---

Pag. 12

Los cuadros generados son colocados en un buffer de cuadros, de donde la tarea
de generación de tareas de fractura de cuadros los toma. Esta, como su nombre lo
indica, genera una tarea de fractura para cada uno de los cuadros. Cada una de
estas últimas tareas dividen el cuadro en fragmentos y crean una tarea de
procesamiento de fragmento para cada uno de ellos.

---

Pag. 13

Cada fragmento sera procesado por una o más pilas de búsqueda de objetos. En el
caso del fútbol de robots el sistema originalmente utilizaba dos pilas, una para
la pelota y otra para los robots.

---

Pag. 14

Pero los resultados experimentales demostraron que el sistema tenia mejor
rendimiento utilizando una sola pila que realice ambas tareas.


