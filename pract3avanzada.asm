@ David Tanarro de las Heras

.extern _stack
.global start


.EQU 	N, 100
.EQU 	M, 5

.data
A: 		.word 9,8,3,2,10

.bss
cuenta_bonitos: 	.space 4

.text
start:
		ldr sp,=_stack
		mov fp,#0

		ldr r4, =A
		mov r1, #N
		mov r5, #0		@ j <- 0
		mov r6, #0		@ cuenta_bonitos
		mov r7, #M
		for1: cmp r5, r7
			bge fin_for1	@ (j < M)
			ldr r0, [r4]
			bl esBonito
			if1: cmp r0, #1
				bne noBoni
				add r6,r6,#1
			noBoni: add r5,r5,#1
					add r4,r4,#4
			b for1
		fin_for1:
		B .

esBonito: @@@@@@@@@@ PROLOGO
	push {r4-r7, fp}	@ Guarda los registros que haya que preservar en la pila
	add fp, sp, #16 	@ 16=4*5-4

	mov r4, #0 			@ Contador del for2: i <- 0
	mov r5, r0 			@ r5 <- X
	mov r6, r1			@ r6 <- N
	mov r7, #0			@ r7 <- 0
	@@@@@@@@@@ CUERPO
	for2: cmp r4, r6
		bge fin_for2				@ (i < N)
		add r7, r7, r4				@ sum += i
		if2: cmp r7, r5				@ sum != X && sum > X
			beq esBon
			bgt noBon
			add r4, r4, #1 				@ i++
			b for2
			esBon: 	mov r0, #1
					b fin_for2
			noBon:	mov r0, #0
					b fin_for2
	fin_for2:
	@@@@@@@@@@ EPILOGO
	pop {r4-r7, fp} 	@ Restaura los registros desde la pila
	bx lr 				@ mov pc, lr

		.end
