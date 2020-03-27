.global _start

_start:
	MOV R1, #A
	MOV R2, #B
	MOV R3, #C
	MOV R4, #X
	MOV R5, #Y

	MUL R6, R1, R4
	MUL R6, R4, R6

	MUL R1, R4, R5
	MUL R4, R2, R1

	MUL R2, R5, R5
	MUL R1, R3, R2

	ADD R1, R4
	ADD R1, R6

_exit:
	MOV R0, R1
	MOV R7, #1
	SWI 0

.data
.equ A, 2
.equ B, 3
.equ C, 4
.equ X, 5
.equ Y, 6


