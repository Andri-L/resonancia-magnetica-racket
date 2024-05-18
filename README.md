# resonancia-magnetica-racket
Este fue un proyecto de programación funcional en el lenguaje Racket para presentarlo cómo una evaluación parcial en la _Universidad Tecnológica de Pereira_.

## Contexto de Los Requisitos del Proyecto
> Debe respetar el principio básico de la programación funcional que es el de la inmutabilidad esto es que “el valor de la memoria no
será modificada en el tiempo de ejecución “..aquí no existen las variables..”. Solo puede utilizar funciones para el manejo de string y
vectores; salvo las funcion string-set!, string-fill!, vector-set! que NO las podrá utilizar. Para una función condicional, solo utilice la
función if. NO puede utilizar las funciones cond, list, for, loop, while, lambda, let, set!, exit, matrices(No vistas en clase a la fecha).

> Utilice la librería grafica que desee y/o el lenguaje de la familia Racket para gráficos ( solo de https://racket-lang.org/) que desee.

> Se tomó la idea de la Universidad Carlos III de Madrid, España; de la serie “OCW-UC3M”
> Link: https://ocw.uc3m.es/pluginfile.php/3097/mod_page/content/12/examen_final.pdf
> Fecha: 2023.03.30

> La resonancia magnética es una técnica de diagnóstico por imagen en la que se obtiene
información de las características de diferentes puntos del cuerpo a partir de su respuesta a
un campo magnético variable. Supongamos que tenemos una matriz tridimensional de
puntos que representa una imagen adquirida por este método, en el que cada punto tiene un
valor entre 0 y 255, correspondiente a un distinto nivel de gris.

> La imagen será́ como la de un cuaderno de 100 hojas, donde cada hoja tendrá una cuadricula de 100 x 100 puntos,
esto es que genera un arreglo de 100 planos (fotografías) en Z(0,1,2,3,4...99), (listas y/o listas de listas de listas)

> Se quiere escribir un programa A. Que utilice solo string y B. Que utilice solo “cvector” y que permita detectar
aspectos en la imagen que pueden ser indicadores de una enfermedad. Como no tenemos los datos que generaría
la máquina de “Resonancia magnética”, genere usted el arreglo con datos aleatorios entre [0 y 255] para probar
sus funciones. Para ello se pide:

> 1. Escribir una función que, para un determinado punto en la imagen (identificado por sus coordenadas x, y ,z)
, detecte si es sospechoso. Se consideran sospechosos aquellos puntos para los que TODOS los puntos adyacentes
tengan un valor entre 20 y 40 (esto incluye los puntos pertenecientes al mismo plano, al plano inferior y al plano
superior).

> Nota: A la hora de analizar la imagen, no se analizarán los puntos de ninguno de los planos exteriores del cubo.
> Debe imprimirse las siguientes imagenes:

> ![Captura de la Imagen a la cuál debe asimilarse el programa](https://media.discordapp.net/attachments/404533914816872449/1241232808555446353/image.png?ex=664973a2&is=66482222&hm=8ca92c785baedefe2e1ceae4d1a0744012a80aa9d66d1d57fb950e3377ea9430&=&format=webp&quality=lossless)

> Nota: A la hora de analizar la imagen, no se analizarán los puntos de ninguno de los planos exteriores del cubo.

> 2. Se pide escribir una función que, para un determinado plano de la imagen, busque líneas sospechosas. Se
considera una línea sospechosa toda línea HORIZONTAL (paralelas al eje X) en la que haya al menos tres(3)
puntos sospechosos consecutivos, para esto se pide que imprima el plano(fotografía, en modo gráfico); ejemplo:
Ejemplo: Fotografía en el plano Z=37

![Captura de él ejemplo de la visualización de un plano en específico](https://media.discordapp.net/attachments/404533914816872449/1241233037316984973/image.png?ex=664973d9&is=66482259&hm=e4a5cb096e4f93a5acdec16596a373404df750d3edec67648938f17a3976f115&=&format=webp&quality=lossless)

> 3. Escribir un programa que emplee las funciones anteriormente descritas para identificar en una imagen si
hay alguna línea sospechosa y genere el siguiente informe(Ejemplo):
Plano en Z(Fotografía) Líneas sospechosas x plano(foto) Puntos sospechosos por plano(foto)

![Ejemplo del Informe](https://media.discordapp.net/attachments/404533914816872449/1241233267840127087/image.png?ex=66497410&is=66482290&hm=7e74c25b42acd6fe353e07b09cf1ffd6413072e1abcc9c2eabbc255abcd76a99&=&format=webp&quality=lossless)

> Los valores de todos los elementos de la matriz se supondrán ya cargados en memoria (no es necesario leerlos).
En caso de que existan líneas sospechosas en la imagen, el programa mostrará en qué plano hay más líneas
sospechosas (servirá para saber en qué lugar es mejor hacer una biopsia).

> ## Herramientas Usadas en el Desarrollo:
Se utilizó al 100% el lenguaje de programación Racket, con la intención de qué el programa siguiera lo mejor posible las prácticas de programación funcional. 
