/*-----------------------------------------------------------------
**
**  Fichero:
**    pract1b.asm  10/6/2014
**
**    Fundamentos de Computadores
**    Dpto. de Arquitectura de Computadores y Automática
**    Facultad de Informática. Universidad Complutense de Madrid
**
**  Propósito:
**    Divide 2 números mediante el algoritmo de restas parciales
**
**  Notas de diseño:
**
**---------------------------------------------------------------*/

.global start

.data
A: .word 0x0A  @ Dividendo
B: .word 0x02  @ Divisor

.bss
C: .space 4    @ Resultado

.text
start:
		ldr r2,=A    @ Cargamos la direccion de A
		ldr r3,=B    @ Cargamos la direccion de B
		ldr r4,=C    @ Cargamos la direccion de C

		ldr r0,[r2]  @ Cargamos el contenido de A
		ldr r1,[r3]  @ Cargamos el contenido de B

		mov r5,#0

WHILE:  cmp r0,r1
		blt ENDWHILE @ Si A<B, rompemos el bucle

		sub r0,r0,r1 @ A = A - B
		add r5,r5,#1 @ C = C + 1

		b WHILE

ENDWHILE:

		str r5,[r4]

	    b .

		.end
