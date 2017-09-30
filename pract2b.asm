/*-----------------------------------------------------------------
**
**  Fichero:
**    pract2b.asm  10/6/2014
**
**    Fundamentos de Computadores
**    Dpto. de Arquitectura de Computadores y Automática
**    Facultad de Informática. Universidad Complutense de Madrid
**
**  Propósito:
**    Ordena de mayor a menor un vector de enteros positivos
**
**  Notas de diseño:
**
**---------------------------------------------------------------*/

.global start

.EQU 	N, 8

.data
A: 		.word 7,3,25,4,75,2,1,1

.bss
B: 		.space N*4
max: 	.space 4
ind: 	.space 4

.text
start:
	mov r0,#0	@ j = 0
	mov r1,#0	@ i = 0
	ldr r2,=max	@ r2 <- dir(max)
	ldr r3,=A	@ r3 <- dir(A)
	ldr r4,=B	@ r4 <- dir(B)
	ldr r5,=ind	@ r5 <- dir(ind)
	str r0,[r5]	@ ind = 0

	for: cmp r0,#N
		bge fin_for1	@(j < N)
		mov r7,#0		@ r7 = 0
		str r7, [r2]	@ max = 0
		mov r1,#0 		@ i = 0

		for2: cmp r1,#N
			bge fin_for2 			@ (i < N)
			ldr r6,[r3,r1,lsl#2]	@ r6 <- A[i], cargamos en r6 el contenido de la dir(A+(i*4))
			ldr r8, [r2]			@ r8 <- max
			
			if: cmp r6,r8
				ble fin_if	@ (A[i] > max)
				str r6,[r2]	@ max = A[i]
				str r1,[r5]	@ ind = i
			fin_if:

			add r1,r1,#1	@ i++
			b for2
		fin_for2:
		
		ldr r10,[r5]			@ r10 <- ind
		ldr r9,[r3,r10,lsl#2]	@ r9 <- A[ind], cargamos en r9 el contenido de la dir(A+(ind*4))
		str r9,[r4,r0,lsl#2]	@ B[j] = A[ind], almacenamos r9 en la dir(B+(j*4))
		str r7,[r3,r10,lsl#2]	@ A[ind] = 0, como r7 == 0 entonces almacenamos r7 en el contenido de la dir(A+(ind*4))
		add r0,r0,#1			@ j++
		b for
	fin_for1: B .

	.end
