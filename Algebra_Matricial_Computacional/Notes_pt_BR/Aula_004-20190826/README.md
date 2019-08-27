Aula 04 - Dia 26/08/2019

Obtenção de determinantes de matrizes de grau 3.

det  + - +
elimina primeira linha

A = 
[  1  0  2 ]
[  5  2  4 ]
[ -1  2  0 ]


detA = 
       +1 * [  2  4 ]
            [  2  0 ]
       -0 * [  5  4 ]
            [ -1  0 ]
       +2 * [  5  2 ]
            [ -1  2 ]
           

EX2

A = 
[  2  5  7 ]
[  3  1  4 ]
[  6  8  2 ]

detA = 
       +2 * [  1  4 ]
            [  8  2 ]
       -5 * [  3  6 ]
            [  4  2 ]
       +7 * [  3  1 ]
            [  6  8 ]
=      +2 * [  2 -32]
       -5 * [  6 -24]
       +7 * [  24 -6]
=      +2 * [-30] - (5 * [-18]) + (+7 * [18])
=      -60 + 90 + 126 
=      +156



REGRA DE SAURUS (padrão Francine)


A = 
[  2  5  7 ]
[  3  1  4 ]
[  6  8  2 ]

A = 
[  2  5  7 ]  2  5
[  3  1  4 ]  3  1
[  6  8  2 ]  6  8

+ ([3 * 1 * 2] + [5 * 4 * 6] + [7 * 3 * 8])
- ([7 * 1 * 6] + [2 * 4 * 8] + [5 * 3 * 2])
= (6 + 120 + 168) - (42 + 64 + 30)
= (6 + 120 + 168) - (42 + 64 + 30)
= (294) - (136)
= 158


--------------------------------------------------------

Software: Maxima (ou Wxmaxima) 
pacman -S maxima wxmaxima

tem pra windows e outros linux tb

## Matriz inversa

Para ser possível inverter uma matriz, B*A = A*B = I

Dispositivo p/ inverter matriz de ordem 2:
1) Trocar os elementos de posição da diagonal principal
2) Trocar os sinais dos elementos da diagonal secundária
3) Calcular o determinante da matriz (se for zero, ela não tem inversa)
4) Dividir todos os elementos da "nova matriz" pelo determinante da matriz
   
   Ex.:
   Dados as matriz A e B, verifique se A é inversa de B, ou se B é inversa de A.

A =    
[  8   5 ]
[  3  -2 ]
B =    
[  2  -5 ]
[ -3   8 ]

detA = ([8 * -2] - [5*3]) = -16 -15 = -31

A⁻1 = -1/31  * 
[ -2  -5 ]
[ -3   8 ]

A⁻1 = -1/31  * 
[  2/31  5/31 ]
[  3/31 -8/31 ]