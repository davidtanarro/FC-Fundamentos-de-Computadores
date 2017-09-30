/*-----------------------------------------------------------------
**
**  Fichero:
**    pract1a.asm  10/6/2014
**
**    Fundamentos de Computadores
**    Dpto. de Arquitectura de Computadores y Automática
**    Facultad de Informática. Universidad Complutense de Madrid
**
**  Propósito:
**    Compara 2 números y se queda con el mayor
**
**  Notas de diseño:
**
**---------------------------------------------------------------*/

.global start
.data
X: 		.word 0x13
Y: 		.word 0x0A

.bss
Mayor: 	.space 4

.text
start:
		LDR R4, =X
		LDR R3, =Y
		LDR R5, =Mayor
		LDR R1, [R4]
		LDR R2, [R3]
		CMP R1, R2
		BLE else
		STR R1, [R5]
		B FIN
else: 	STR R2, [R5]
FIN: 	B .

		.end
