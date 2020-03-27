.global _start

_start:

	LDR R1, =A
	MOV R2, #0
	MOV R4, #MAX
	MOV R5, #4
	MOV R6, R1

_loop:
	CMP R2, R4
	BGE _endloop

	STR R2, [ R1 ]

	ADD R1, R5

	ADD R2, #1

	B _loop


_endloop:
	MOV R1, R6
	MUL R3, R4, R5
	ADD R2, R1, R3


_reverse:
	CMP R1, R2
	BGE _exit

	LDR R3, [R1]
	LDR R4, [R2]

	STR R3, [R2]
	STR R4, [R1]

	ADD R1, R5
	SUB R2, R5

	B _reverse

_exit:
	MOV R7, #1
	SWI 0

.data
.equ MAX, 10

A: .rept MAX
   .word 0
   .endr
