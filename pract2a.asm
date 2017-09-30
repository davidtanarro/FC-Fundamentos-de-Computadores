/*-----------------------------------------------------------------
**
**  Fichero:
**    pract2a.asm  10/6/2014
**
**    Fundamentos de Computadores
**    Dpto. de Arquitectura de Computadores y Automática
**    Facultad de Informática. Universidad Complutense de Madrid
**
**  Propósito:
**    Busca el valor máximo de un vector de enteros positivos
**
**  Notas de diseño:
**
**---------------------------------------------------------------*/

.global start

.EQU 	N, 8

.data
A: 		.word 7,3,25,4,75,2,1,1

.bss
max: 	.space 4

.text
start:
		mov r0, #0		@ i = 0
		ldr r1,=max		@ r1 <- dir(max)
		str r0,[r1]		@ max = 0
		
		ldr r2,=A		@ r2 <- dir(A)

	for: cmp r0,#N
		bge fin_for		@ (i < N)
		ldr r4,[r1]		@ r4 <- max
		ldr r3,[r2,r0,lsl#2]	@ r3 <- v[i], cargo en r3 el contenido de la dir(A+(i*4))
		if: cmp r3,r4
			bls fin_if	@ (v[i] > max)
			str r3,[r1]	@ max = v[i], almaceno r3 en la dir(max)
		fin_if:

		add r0,r0,#1	@ i++
		b for
	fin_for:  B .

	.end
