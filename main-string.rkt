#lang racket

(require graphics/graphics)

#|
- Fecha de publicación: 6/Abril/2024
- Hora: 1:00AM
- Versión de su código fuente: 1.1.69 
- Autor. Ing(c) Andrés Felipe Londoño Bedoya
- Nombre del lenguaje utilizado: Racket
- Versión del lenguaje utilizado: 8.12
- Presentado a: Doctor Ricardo Moreno Laverde 
- Universidad Tecnológica de Pereira 
- Programa de Ingeniería de Sistemas y Computación 
- Descripción del programa: Este programa genera una resonancia magnética de 100x100x100 hecha en strings para buscar puntos y lineas sospechosos en un plano específico. Al final genera un informe de todo lo encontrado.  
- Salvedad: para que no se detenga el programa, subir velocidad de espera de todas las funciones dormir (sleep) de 0.1 en 0.1 sí el programa no se ejecuta en 30 segundos.
- Salvedad: Para cada una de las entradas manuales, solo se aceptan valores enteros mayores que cero y menores que 99. (Tanto para la entrada de la coordenada en X, Y, Z y el plano a buscar)
- Salvedad: Para la facilidad de la revisión del código, los valores del rango en el que se generan los valores aleatorios de la resonancia magnética se encuentran entre 21 y 40.
|#

; DECLARACIÓN DE VALORES INICIALES:
(define defaultEmptyValue #\□)
(define defaultSuspiciousValue #\■)

; FUNCIÓN PARA CREAR EL STRING CON VALORES ALEATORIOS
( define ( makeString count #:str (str "") )
    ( if ( zero? count )
        str
        ( makeString ( - count 1 ) #:str ( string-append str ( string ( integer->char ( random 21 41 ) ) ) ) )
    ) ; end if
) ; end define makeString

; FUNCIÓN PARA CREAR EL STRING CON VALORES ALEATORIOS DE 10000 EN 10000
( define ( makeStringByLayer count #:str ( str "" ) ) 
    ; de 10000 en 10000, 100 veces, sleep 0.2, 26 segundos
    ; de 10000 en 10000, 100 veces, sleep 0.001, 6 segundos

    ( sleep 0.01 )
    ( if ( zero? count )
        str
        ( makeStringByLayer ( - count 1 ) #:str ( string-append str ( makeString 10000 ) ) )
    ) ; end if zero?
) ; end define makeStringByLayer

; FUNCIÓN PARA LA CONVERSIÓN DE EL PUNTO EN EL STRING A COORDENADAS
( define ( getPointCoords point )
    ( define z ( quotient point 10000 ))
    ( define y ( quotient ( remainder point 10000) 100 ) )
    ( define x ( remainder ( remainder point 10000) 100 ) )
    ( values x y z )
) ; end define getPointCoords

; CONVERSIÓN DE LAS COORDENADAS A EL PUNTO EN EL STRING
( define ( getPointFromCoords x y z )
    ( + ( * 10000 z ) ( * 100 y ) x )
) ; end define getPointFromCoords

; OBTENER EL VALOR DE UN PUNTO EN EL STRING
( define ( getCoordsValue x y z magneticResonance )
    ( define point ( getPointFromCoords x y z ) )
    ( char->integer ( string-ref magneticResonance point ) )
) ; end define getCoordsValue

; DEVUELVE SI UN PUNTO ES SOSPECHOSO O NO
( define ( evaluateSuspiciousPoint point magneticResonance )
    ( define-values (x y z) ( getPointCoords point ) )
    ( if 
        ( and 
            ; layer z - 1
            ( and 
                (> (getCoordsValue x y ( - z 1 ) magneticResonance) 20)
                (< (getCoordsValue x y ( - z 1 ) magneticResonance) 40)
                (> (getCoordsValue ( - x 1 ) y ( - z 1 ) magneticResonance) 20)
                (< (getCoordsValue ( - x 1 ) y ( - z 1 ) magneticResonance) 40)
                (> (getCoordsValue ( + x 1 ) y ( - z 1 ) magneticResonance) 20)
                (< (getCoordsValue ( + x 1 ) y ( - z 1 ) magneticResonance) 40)
                (> (getCoordsValue x ( - y 1 ) ( - z 1 ) magneticResonance) 20)
                (< (getCoordsValue x ( - y 1 ) ( - z 1 ) magneticResonance) 40)
                (> (getCoordsValue x ( + y 1 ) ( - z 1 ) magneticResonance) 20)
                (< (getCoordsValue x ( + y 1 ) ( - z 1 ) magneticResonance) 40)
                (> (getCoordsValue ( - x 1 ) ( - y 1 ) ( - z 1 ) magneticResonance) 20)
                (< (getCoordsValue ( - x 1 ) ( - y 1 ) ( - z 1 ) magneticResonance) 40)
                (> (getCoordsValue ( + x 1 ) ( - y 1 ) ( - z 1 ) magneticResonance) 20)
                (< (getCoordsValue ( + x 1 ) ( - y 1 ) ( - z 1 ) magneticResonance) 40)
                (> (getCoordsValue ( - x 1 ) ( + y 1 ) ( - z 1 ) magneticResonance) 20)
                (< (getCoordsValue ( - x 1 ) ( + y 1 ) ( - z 1 ) magneticResonance) 40)
                (> (getCoordsValue ( + x 1 ) ( + y 1 ) ( - z 1 ) magneticResonance) 20)
                (< (getCoordsValue ( + x 1 ) ( + y 1 ) ( - z 1 ) magneticResonance) 40)
            )
            ; layer z 
            ( and 
                (> (getCoordsValue ( - x 1 ) y z magneticResonance) 20)
                (< (getCoordsValue ( - x 1 ) y z magneticResonance) 40)
                (> (getCoordsValue ( + x 1 ) y z magneticResonance) 20)
                (< (getCoordsValue ( + x 1 ) y z magneticResonance) 40)
                (> (getCoordsValue x ( - y 1 ) z magneticResonance) 20)
                (< (getCoordsValue x ( - y 1 ) z magneticResonance) 40)
                (> (getCoordsValue x ( + y 1 ) z magneticResonance) 20)
                (< (getCoordsValue x ( + y 1 ) z magneticResonance) 40)
                (> (getCoordsValue ( - x 1 ) ( - y 1 ) z magneticResonance) 20)
                (< (getCoordsValue ( - x 1 ) ( - y 1 ) z magneticResonance) 40)
                (> (getCoordsValue ( + x 1 ) ( - y 1 ) z magneticResonance) 20)
                (< (getCoordsValue ( + x 1 ) ( - y 1 ) z magneticResonance) 40)
                (> (getCoordsValue ( - x 1 ) ( + y 1 ) z magneticResonance) 20)
                (< (getCoordsValue ( - x 1 ) ( + y 1 ) z magneticResonance) 40)
                (> (getCoordsValue ( + x 1 ) ( + y 1 ) z magneticResonance) 20)
                (< (getCoordsValue ( + x 1 ) ( + y 1 ) z magneticResonance) 40)
            ) 
            ; layer z + 1 
            ( and 
                (> (getCoordsValue x y ( + z 1 ) magneticResonance) 20)
                (< (getCoordsValue x y ( + z 1 ) magneticResonance) 40)
                (> (getCoordsValue ( - x 1 ) y ( + z 1 ) magneticResonance) 20)
                (< (getCoordsValue ( - x 1 ) y ( + z 1 ) magneticResonance) 40)
                (> (getCoordsValue ( + x 1 ) y ( + z 1 ) magneticResonance) 20)
                (< (getCoordsValue ( + x 1 ) y ( + z 1 ) magneticResonance) 40)
                (> (getCoordsValue x ( - y 1 ) ( + z 1 ) magneticResonance) 20)
                (< (getCoordsValue x ( - y 1 ) ( + z 1 ) magneticResonance) 40)
                (> (getCoordsValue x ( + y 1 ) ( + z 1 ) magneticResonance) 20)
                (< (getCoordsValue x ( + y 1 ) ( + z 1 ) magneticResonance) 40)
                (> (getCoordsValue ( - x 1 ) ( - y 1 ) ( + z 1 ) magneticResonance) 20)
                (< (getCoordsValue ( - x 1 ) ( - y 1 ) ( + z 1 ) magneticResonance) 40)
                (> (getCoordsValue ( + x 1 ) ( - y 1 ) ( + z 1 ) magneticResonance) 20)
                (< (getCoordsValue ( + x 1 ) ( - y 1 ) ( + z 1 ) magneticResonance) 40)
                (> (getCoordsValue ( - x 1 ) ( + y 1 ) ( + z 1 ) magneticResonance) 20)
                (< (getCoordsValue ( - x 1 ) ( + y 1 ) ( + z 1 ) magneticResonance) 40)
                (> (getCoordsValue ( + x 1 ) ( + y 1 ) ( + z 1 ) magneticResonance) 20)
                (< (getCoordsValue ( + x 1 ) ( + y 1 ) ( + z 1 ) magneticResonance) 40)
            ) ; end and layer z + 1
        ) ; end and layer z - 1
        #t
        #f
    ); end if
) ; end define evaluateSuspiciousPoint 

; FUNCIÓN QUE BUSCA LOS PUNTOS SOSPECHOSOS EN UNA FOTO
( define ( findSuspiciousPoints layer magneticResonance #:positiveCounter ( positiveCounter 0 ) #:str ( str "" ) #:counter ( counter 0 ) )
    (if ( or ( matchWithFirstRow? counter ) ( matchWithLastRow? counter ) ( matchWithLeftColumn? counter ) ( matchWithRightColumn? counter ) )
        ; if :
        ( begin
            ( sleep 0.01 )
            ; ( displayln counter ) display que sirve para mostrar exactamente el punto que se evalua cómo exepcion gracias al if
            ( findSuspiciousPoints layer magneticResonance  #:str ( string-append str ( string defaultEmptyValue ) ) #:counter ( + counter 1 ) )
        ) ; end begin
        ; else :
        (if ( > counter 10000 )
            ; if true:
            str
            ; else :
            ( if ( evaluateSuspiciousPoint (+ counter (* layer 10000 ) ) magneticResonance )
                ( findSuspiciousPoints layer magneticResonance #:positiveCounter ( + positiveCounter 1 ) #:str ( string-append str (string defaultSuspiciousValue ) ) #:counter ( + counter 1 ) )
                ( findSuspiciousPoints layer magneticResonance  #:str ( string-append str ( string defaultEmptyValue ) ) #:counter ( + counter 1 ) )
            ) ; end if
        ) ; end if
    ) ; end if
) ; end define findSuspiciousPoints

; AUXILIAR QUE DETERMINA SI UN PUNTO ESTÁ EN LA PRIMERA FILA
( define ( matchWithFirstRow? point )
    ( if ( < point 100 )
        #t
        #f
    ) ; end if
) ; end define matchWithFirstRow?

; AUXILIAR QUE DETERMINA SI UN PUNTO ESTÁ EN LA ÚLTIMA FILA
( define ( matchWithLastRow? point )
    ( if ( and ( > point 9900 ) ( < point 10001 ) )
        #t
        #f
    ) ; end if
) ; end define matchWithLastRow?

; AUXILIAR QUE DETERMINA SI UN PUNTO ESTÁ EN LA COLUMNA IZQUIERDA
( define (matchWithLeftColumn? point #:counter ( counter 100 ) )
    ( if ( < counter 0 )
        #f
        ( if ( = point ( * counter 100 ) ) ; formula general de la columna izquierda (sucesión aritmetica)
            #t
            ( matchWithLeftColumn? point #:counter ( - counter 1 ) )
        ) ; end if
    ) ; end if 
) ; end define matchWithLeftColumn?

; AUXILIAR QUE DETERMINA SI UN PUNTO ESTÁ EN LA COLUMNA DERECHA
( define ( matchWithRightColumn? point #:counter ( counter 100 ) )
    ( if ( < counter 0 ) 
        #f
        ( if ( = point ( + ( * counter 100 ) 99 ) ) ; formula general de la columna derecha (sucesión aritmetica)
            #t
            ( matchWithRightColumn? point #:counter ( - counter 1 ) )
        ) ; end if
    ) ; end if
) ; end define matchWithRightColumn?

; FUNCIÓN QUE CUENTA LAS LINEAS SOSPECHOSAS
( define ( countSuspiciousLines layer magneticResonance #:counter ( counter 0 ) #:lineCounter ( lineCounter 0 ) #:itsALine? ( itsALine? #f ) )
    ( define x (remainder counter 100) )

    ( define ( isInTheLastOfTheRow? x )
        ( if ( or ( = x 98 ) ( = x 99) )
            #t
            #f
        ) ; end if
    ) ; end define isInTheLastOfTheRow?

    ( if ( or (matchWithFirstRow? counter) (matchWithLastRow? counter) (matchWithLeftColumn? counter) (matchWithRightColumn? counter) )
        ( countSuspiciousLines layer magneticResonance #:counter ( + counter 1 ) #:lineCounter lineCounter #:itsALine? #f )
        ( if ( > counter 10000 )
            lineCounter
            ( if ( isInTheLastOfTheRow? x )
                ( countSuspiciousLines layer magneticResonance #:counter ( + counter 1 ) #:lineCounter lineCounter #:itsALine? #f )
                ( if 
                    ( and 
                        ( evaluateSuspiciousPoint ( + counter ( * layer 10000 ) ) magneticResonance )
                        ( evaluateSuspiciousPoint ( + ( + counter 1 ) ( * layer 10000 ) ) magneticResonance )
                        ( evaluateSuspiciousPoint ( + ( + counter 2 ) ( * layer 10000 ) ) magneticResonance )
                    ) ; end and
                    (if ( or
                        ( or (matchWithFirstRow? ( + counter 1 ) ) (matchWithLastRow? ( + counter 1 ) ) (matchWithLeftColumn? ( + counter 1 ) ) (matchWithRightColumn? ( + counter 1 ) ) )
                        ( or (matchWithFirstRow? ( + counter 2 ) ) (matchWithLastRow? ( + counter 2 ) ) (matchWithLeftColumn? ( + counter 2 ) ) (matchWithRightColumn? ( + counter 2 ) ) )
                        ) ; end or
                        ( countSuspiciousLines layer magneticResonance #:counter ( + counter 1 ) #:lineCounter lineCounter #:itsALine? #f )
                        ( if (boolean=? itsALine? #t)
                            ( countSuspiciousLines layer magneticResonance #:counter ( + counter 1 ) #:lineCounter lineCounter #:itsALine? #t )
                            ( countSuspiciousLines layer magneticResonance #:counter ( + counter 1 ) #:lineCounter ( + lineCounter 1 ) #:itsALine? #t )
                        ) ; end if
                    ) ; end if
                    ( countSuspiciousLines layer magneticResonance #:counter ( + counter 1 ) #:lineCounter lineCounter #:itsALine? #f )
                ) ; end if
            ) ; end if
        ) ; end if
    ) ; end if
) ; end define countSuspiciousLines

; FUNCION QUE CUENTA Y DIBUJA LAS LINEAS SOSPECHOSAS
( define ( evaluateSuspiciousLines 
    layer 
    suspiciousPointsPlane 
    viewportPointTwo
    #:draw? ( draw? #f )
    #:itsALine? ( itsALine? #f ) 
    #:lineCounter ( lineCounter 0 ) 
    #:counter ( counter 0 )
    #:str ( str "" )
    )
    ; PASO LA PRUEBA: (printf "~a ~a ~a ~a ~a" layer suspiciousPointsPlane draw? itsALine? lineCounter)
    ( define x (remainder counter 100) )
    ; ( define y (quotient counter 100) )
    ( define counter2 (+ counter 1) )
    ( define counter3 (+ counter 2) )

    ( define ( isInTheLastOfTheRow? x )
        ( if ( or ( = x 98 ) ( = x 99) )
            #t
            #f
        ) ; end if
    ) ; end define isInTheLastOfTheRow?

    ; sucesión aritmetica (más la suma en función a los valores adyacentes requeridos) para la linea a imprimir en x
    ( define ( xDraw counter #:number ( number 0 ) ) 
        ( + ( * ( remainder ( + counter number 1 ) 100 ) 7 ) 23 ) 
    ) ; end define xDraw
    
    ; sucesión aritmetica (más la suma en función a los valores adyacentes requeridos) para la linea a imprimir en y
    ( define ( yDraw counter #:number ( number 0 ) )
        ( + ( * ( quotient ( + counter number 100 ) 100 ) 7 ) 23 ) 
    ) ; end define yDraw

    ( if (> counter 10000 )
        ( void )
        ( if ( isInTheLastOfTheRow? x )
            ( evaluateSuspiciousLines layer suspiciousPointsPlane viewportPointTwo #:itsALine? #f #:lineCounter lineCounter #:counter ( + counter 1 ) #:str ( string-append str ( string defaultEmptyValue ) ) )
            ( if 
                ( and 
                    ( string=? ( string ( string-ref suspiciousPointsPlane counter  ) ) ( string defaultSuspiciousValue ) )
                    ( string=? ( string ( string-ref suspiciousPointsPlane counter2 ) ) ( string defaultSuspiciousValue ) )
                    ( string=? ( string ( string-ref suspiciousPointsPlane counter3 ) ) ( string defaultSuspiciousValue ) )
                ) ; end and
                ( if (boolean=? itsALine? #t )
                    (begin
                        ( ( draw-solid-rectangle viewportPointTwo ) (make-posn (xDraw counter           ) (yDraw counter           )) 7 7 "Red" )
                        ( ( draw-solid-rectangle viewportPointTwo ) (make-posn (xDraw counter #:number 1) (yDraw counter #:number 1)) 7 7 "Red" )
                        ( ( draw-solid-rectangle viewportPointTwo ) (make-posn (xDraw counter #:number 2) (yDraw counter #:number 2)) 7 7 "Red" )
                        ( evaluateSuspiciousLines layer suspiciousPointsPlane viewportPointTwo #:itsALine? #t #:lineCounter lineCounter #:counter ( + counter 1 ) #:str ( string-append str ( string defaultSuspiciousValue ) ) )
                    ) ; end begin
                    (begin
                        ( ( draw-solid-rectangle viewportPointTwo ) (make-posn (xDraw counter           ) (yDraw counter           )) 7 7 "Red" )
                        ( ( draw-solid-rectangle viewportPointTwo ) (make-posn (xDraw counter #:number 1) (yDraw counter #:number 1)) 7 7 "Red" )
                        ( ( draw-solid-rectangle viewportPointTwo ) (make-posn (xDraw counter #:number 2) (yDraw counter #:number 2)) 7 7 "Red" )
                        ( evaluateSuspiciousLines layer suspiciousPointsPlane viewportPointTwo #:itsALine? #t #:lineCounter ( + lineCounter 1 ) #:counter ( + counter 1 ) #:str ( string-append str ( string defaultSuspiciousValue ) ) )
                    ) ; end begin
                ) ; end if
                ( evaluateSuspiciousLines layer suspiciousPointsPlane viewportPointTwo #:itsALine? #f #:lineCounter lineCounter #:counter ( + counter 1 ) #:str ( string-append str ( string defaultEmptyValue ) ) )
            ) ; end if
        ) ; end if
    ) ; end if
) ; end define evaluateSuspiciousLines

#|
    PENDIENTE:
    - Terminar la gráfica del punto 1, me falta las columnas y las filas
    - Graficar el punto 3
|#

; GENERAR EL STRING DE LA RESONANCIA MAGNÉTICA
( define magneticResonance ( makeStringByLayer 100 ) )

; SOLICITAR DATOS:
( displayln "Porfavor, ingrese el punto a buscar: " )
( display "Coordenada en X: " )
( define xPoint ( read ) )
( display "Coordenada en Y: " )
( define yPoint ( read ) )
( display "Coordenada en Z: " )
( define zPoint ( read ) )
( display "Ingrese el plano a buscar: " )
( define layer ( read ) )

; CREAR EL PLANO DE PUNTOS SOSPECHOSOS
( define suspiciousPointsPlane ( findSuspiciousPoints layer magneticResonance ) )

; FUNCIÓN PARA CONTAR LOS PUNTOS SOSPECHOSOS DE UNA CADENA EN UNA CAPA EN ESPECIFICO
(define (countSuspiciousPoints suspiciousPointsPlane suspiciousValue layer pointsCounter counter)
    
    ( if (>= counter 10000)
        pointsCounter
        ( if (char=? (string-ref suspiciousPointsPlane counter) suspiciousValue)
            (countSuspiciousPoints suspiciousPointsPlane suspiciousValue layer (+ pointsCounter 1) (+ counter 1) )
            (countSuspiciousPoints suspiciousPointsPlane suspiciousValue layer  pointsCounter      (+ counter 1) )
        ) ; end if
    ) ; end if 
) ; end define countSuspiciousPoints

; GRAFICAR PUNTO 1
( open-graphics )
( define viewportPointOne (open-viewport "Punto 1" 946 336) )
( ( draw-viewport viewportPointOne ) "Lemon Chiffon" )
( ( ( draw-pixmap-posn "menuPointOne.png" ) viewportPointOne ) (make-posn 0 0) )

; graficar plano z - 1 :
((draw-string viewportPointOne) (make-posn 80  130) ( ~r ( getCoordsValue ( - xPoint 1 ) ( - yPoint 1 ) ( - zPoint 1 ) magneticResonance ) ) )
((draw-string viewportPointOne) (make-posn 111 130) ( ~r ( getCoordsValue xPoint         ( - yPoint 1 ) ( - zPoint 1 ) magneticResonance ) ) )
((draw-string viewportPointOne) (make-posn 142 130) ( ~r ( getCoordsValue ( + xPoint 1 ) ( - yPoint 1 ) ( - zPoint 1 ) magneticResonance ) ) )

((draw-string viewportPointOne) (make-posn 80  161) ( ~r ( getCoordsValue ( - xPoint 1 ) yPoint         ( - zPoint 1 ) magneticResonance ) ) )
((draw-string viewportPointOne) (make-posn 111 161) ( ~r ( getCoordsValue xPoint         yPoint         ( - zPoint 1 ) magneticResonance ) ) )
((draw-string viewportPointOne) (make-posn 142 161) ( ~r ( getCoordsValue ( + xPoint 1 ) yPoint         ( - zPoint 1 ) magneticResonance ) ) )

((draw-string viewportPointOne) (make-posn 80  192) ( ~r ( getCoordsValue ( - xPoint 1 ) ( + yPoint 1 ) ( - zPoint 1 ) magneticResonance ) ) )
((draw-string viewportPointOne) (make-posn 111 192) ( ~r ( getCoordsValue xPoint         ( + yPoint 1 ) ( - zPoint 1 ) magneticResonance ) ) )
((draw-string viewportPointOne) (make-posn 142 192) ( ~r ( getCoordsValue ( + xPoint 1 ) ( + yPoint 1 ) ( - zPoint 1 ) magneticResonance ) ) )

; graficar z :
((draw-string viewportPointOne) (make-posn 404 130) ( ~r ( getCoordsValue ( - xPoint 1 ) ( - yPoint 1 ) zPoint         magneticResonance ) ) )
((draw-string viewportPointOne) (make-posn 435 130) ( ~r ( getCoordsValue xPoint         ( - yPoint 1 ) zPoint         magneticResonance ) ) )
((draw-string viewportPointOne) (make-posn 466 130) ( ~r ( getCoordsValue ( + xPoint 1 ) ( - yPoint 1 ) zPoint         magneticResonance ) ) )

((draw-string viewportPointOne) (make-posn 404 161) ( ~r ( getCoordsValue ( - xPoint 1 ) yPoint         zPoint         magneticResonance ) ) )
; centro
((draw-string viewportPointOne) (make-posn 466 161) ( ~r ( getCoordsValue ( + xPoint 1 ) yPoint         zPoint         magneticResonance ) ) )

((draw-string viewportPointOne) (make-posn 404 192) ( ~r ( getCoordsValue ( - xPoint 1 ) ( + yPoint 1 ) zPoint         magneticResonance ) ) )
((draw-string viewportPointOne) (make-posn 435 192) ( ~r ( getCoordsValue xPoint         ( + yPoint 1 ) zPoint         magneticResonance ) ) )
((draw-string viewportPointOne) (make-posn 466 192) ( ~r ( getCoordsValue ( + xPoint 1 ) ( + yPoint 1 ) zPoint         magneticResonance ) ) )

; graficar z + 1 :
((draw-string viewportPointOne) (make-posn 720 130) ( ~r ( getCoordsValue ( - xPoint 1 ) ( - yPoint 1 ) ( + zPoint 1 ) magneticResonance ) ) )
((draw-string viewportPointOne) (make-posn 751 130) ( ~r ( getCoordsValue xPoint         ( - yPoint 1 ) ( + zPoint 1 ) magneticResonance ) ) )
((draw-string viewportPointOne) (make-posn 782 130) ( ~r ( getCoordsValue ( + xPoint 1 ) ( - yPoint 1 ) ( + zPoint 1 ) magneticResonance ) ) ) 

((draw-string viewportPointOne) (make-posn 720 161) ( ~r ( getCoordsValue ( - xPoint 1 ) yPoint         ( + zPoint 1 ) magneticResonance ) ) )
((draw-string viewportPointOne) (make-posn 751 161) ( ~r ( getCoordsValue xPoint         yPoint         ( + zPoint 1 ) magneticResonance ) ) )
((draw-string viewportPointOne) (make-posn 782 161) ( ~r ( getCoordsValue ( + xPoint 1 ) yPoint         ( + zPoint 1 ) magneticResonance ) ) )

((draw-string viewportPointOne) (make-posn 720 192) ( ~r ( getCoordsValue ( - xPoint 1 ) ( + yPoint 1 ) ( + zPoint 1 ) magneticResonance ) ) )
((draw-string viewportPointOne) (make-posn 751 192) ( ~r ( getCoordsValue xPoint         ( + yPoint 1 ) ( + zPoint 1 ) magneticResonance ) ) )
((draw-string viewportPointOne) (make-posn 782 192) ( ~r ( getCoordsValue ( + xPoint 1 ) ( + yPoint 1 ) ( + zPoint 1 ) magneticResonance ) ) )

; columnas y filas :
((draw-string viewportPointOne) (make-posn 411 100) ( ~r (- xPoint 1) ) )
((draw-string viewportPointOne) (make-posn 443 100) ( ~r xPoint ) )
((draw-string viewportPointOne) (make-posn 476 100) ( ~r (+ xPoint 1) ) )

((draw-string viewportPointOne) (make-posn 378 130) ( ~r (- yPoint 1) ) )
((draw-string viewportPointOne) (make-posn 378 162) ( ~r yPoint ) )
((draw-string viewportPointOne) (make-posn 378 190) ( ~r (+ yPoint 1) ) )

; valores exteriores :
((draw-string viewportPointOne) (make-posn 512 28) ( ~r xPoint ) )
((draw-string viewportPointOne) (make-posn 542 28) ( ~r yPoint ) )
((draw-string viewportPointOne) (make-posn 572 28) ( ~r zPoint ) )

((draw-string viewportPointOne) (make-posn 217 257) ( ~r ( - zPoint 1 ) ) )
((draw-string viewportPointOne) (make-posn 541 257) ( ~r zPoint         ) )
((draw-string viewportPointOne) (make-posn 855 257) ( ~r ( + zPoint 1 ) ) )

; GRAFICAR PUNTO 2
( open-graphics )
( define viewportPointTwo (open-viewport "Punto 2" 730 730) )
( ( draw-viewport viewportPointTwo ) "Lemon Chiffon" )
( ( ( draw-pixmap-posn "pointTwo.png" ) viewportPointTwo ) (make-posn 0 0) )

; FUNCIÓN QUE DIBUJA UNA MALLA EN EL PUNTO 2
(define ( createGrid axis counter )
    ( if ( zero? counter )
        ( void )
        ( if ( string=? axis "x" )
            ( begin
                ( ( draw-line viewportPointTwo ) ( make-posn 30 ( + ( * counter 7 ) 23 ) ) ( make-posn 730 ( + ( * counter 7 ) 23 ) ) "Black" )
                ( createGrid axis ( - counter 1 ) )
            ) ; end begin
            ; else "for axis y"
            ( begin
                ( ( draw-line viewportPointTwo ) ( make-posn ( + ( * counter 7 ) 23 ) 30 ) ( make-posn ( + ( * counter 7 ) 23 ) 730 ) "Black" )
                ( createGrid axis ( - counter 1 ) )
            ) ; end begin
        ) ; end if
    ) ; end if
) ; end define createGrid

(createGrid "x" 100)
(createGrid "y" 100)

(evaluateSuspiciousLines layer suspiciousPointsPlane viewportPointTwo)

(createGrid "x" 100)
(createGrid "y" 100)

( sleep 0.1 )

(define (createReport)
    ( printf "~a | ~a | ~a" "Plano en Z" "Líneas sospechosas x plano(foto)" "Puntos sospechosos por plano(foto)" )
    ( newline )
    (sleep 0.1)
    ( define (createReportAux counter)
        ( if ( >= counter 99 )
            ( void )
            ( begin
                ( printf "~a          |         ~a                      |          ~a" counter ( countSuspiciousLines counter magneticResonance ) ( countSuspiciousPoints ( findSuspiciousPoints counter magneticResonance ) defaultSuspiciousValue counter 0 0 ) )
                ( newline )
                ( createReportAux ( + counter 1 ) )
            ) ; end begin
        ) ; end if
    ) ; end define createReportAux
    ( createReportAux 1 )
) ; end define createReport

( sleep 0.1 )

(createReport)