/*-----------------------------------------------------------------
**
**  Fichero:
**    pract3.asm  10/6/2014
**
**    Fundamentos de Computadores
**    Dpto. de Arquitectura de Computadores y Automática
**    Facultad de Informática. Universidad Complutense de Madrid
**
**  Propósito:
**    Ordena de mayor a menor un vector de enteros positivos
**
**  Notas de diseño:
**    Utiliza una subrutina que devuelve la posición del valor
**    máximo de un vector de enteros positivos
**
**---------------------------------------------------------------*/

.extern _stack
.global start

.EQU 	N, 8

.data
A: 	.word 7,3,25,4,75,2,1,1

.bss
B: 	.space N*4

.text
start:
	ldr sp,=_stack
	mov fp,#0

	mov r0, #0		@ Indicador valor maximo en array A: ind
	mov r1, #0		@ Contador del for1: j <- 0
	mov r2, #N 		@ Dimension array para pasar como parametro a MAXIMO: r2 <- N
	ldr r3, =A		@ r3 <- dir(A)
	ldr r4, =B		@ r4 <- dir(B)
	mov r6, #0		@ r6 <- 0

	for1: cmp r1, #N
		bge fin_for1				@ (j < N)
		bl MAXIMO					@ Llamada a subrutina maximo que calcula el indice del maximo de A en r0
		ldr r7, [r3, r0, lsl #2] 	@ Cargamos en r7 <- el contenido de la dir(A + (ind*4)), el maximo de A
		str r7, [r4, r1, lsl #2] 	@ Guardamos en el contenido de la dir(B + (j*4)) <- r7
		str r6, [r3, r0, lsl #2] 	@ Guardamos en el contenido de la dir(A + (ind*4)) <- 0
		add r1, r1, #1 				@ j++
		b for1
	fin_for1:
	B .

MAXIMO:
	@@@@@@@@@@ PROLOGO
	push {r4-r7, fp}	@ Guarda los registros que haya que preservar en la pila
	add fp, sp, #16 	@ 16=4*5-4
	mov r4, #0 			@ Contador del for2: i <- 0
	mov r5, r3 			@ r5 <- dir(A)
	mov r6, #0 			@ Valor maximo del array A <- 0
	@@@@@@@@@@ CUERPO
	for2: cmp r4, r2
		bge fin_for2				@ (i < N)
		ldr r7, [r5, r4, lsl #2] 	@ r7 <- v[i], v[i] es el contenido de la dir(A + (i*4))
		if: cmp r6, r7
			bge fin_if				@ (Valor maximo < v[i])
			mov r6, r7 				@ r6 <- v[i], Guardo en r6 el maximo r7 del array A
			mov r0, r4 				@ ind <- i, Guardo en r0 el indicador r4 del maximo del array A
		fin_if:
		add r4, r4, #1 				@ i++
		b for2
	fin_for2:
	@@@@@@@@@@ EPILOGO
	pop {r4-r7, fp} 	@ Restaura los registros desde la pila
	bx lr 				@ mov pc, lr
	.end


