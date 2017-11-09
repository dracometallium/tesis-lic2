<!-- vim: set spell spelllang=es syntax=markdown : -->

Mi nombre es RC, el trabajo mi tesis se titula "_Un sistema paralelo de visíon
global para fútbol de robots orientado al uso educativo_". Mi tutor de tesis es
Javier Balladini, y conté con la codirección de Eduardo Grosclaude.

---

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

Nos vamos a enfocar en la liga de tamaño pequeño de la RoboCup. En esta liga los
robots tienen la forma de cilindros de 9 centímetros de radio y 15 de alto, se
mueven sobre ruedas omnidireccionales, y tienen un _'pie'_ para propulsar la
pelota. Cada equipo esta formado por seis robots, que para para identificarlos y
detectar su orientación tienen un conjunto de 5 parches en su parte superior, el
parche central indica el equipo del robot.

Cada equipo cuenta con una computadora que controla el movimiento de los robots
y planea las estrategias, los robots por su parte solo tienen el poder de
procesamiento necesario como para ejecutar las ordenes de movimiento. La
información de la posición y orientación de los robots y pelota es recibida
desde un sistema de visión global que ejecuta en una maquina independiente a
cada equipo y que captura el ambiente desde un conjunto de cámaras colocadas
sobre la cancha.

---

Este diagrama resume la estructura física del sistema de visión global. La
cámara captura un video de la cancha y envía los cuadros al sistema de visión
global, este detecta la posición de los robots y pelota y envía esos datos a
cada una de las computadoras de los equipos. Con esa información estas
desarrollan estrategias y envían ordenes de movimiento a los robots de su
equipo.

---

Actualmente existen dos tamaños de cancha,  las canchas de tamaño simple son de
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
