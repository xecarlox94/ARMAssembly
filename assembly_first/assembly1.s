.global _start

_start:

	LDR R1, =A
	MOV R2, #0

	LDR R3, =B
	MOV R4, #MAX
	SUB R4, #1

_loop:
	CMP R2, #MAX
	BGE _exit

	STR R2, [ R1 ]
	STR R4, [ R3 ]

	ADD R1, #4
	ADD R3, #4

	ADD R2, #1
	SUB R4, #1

	B _loop





_exit:
	MOV R7, #1
	SWI 0

.data
.equ MAX, 100

A: .rept MAX
   .word 0
   .endr

B: .rept MAX
   .word 0
   .endr
