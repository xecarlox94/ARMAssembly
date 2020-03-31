.global _start


_start:
	LDR R0, =f1
	BL printf

	LDR R0, =f2
	LDR R1, =n
	BL scanf

	LDR R0, =n
	LDR R1, [R0]

	CMP R1, #5
	BEQ _true

	LDR R0, =f4
	B _print

_true:
	LDR R0, =f3

_print:
	BL printf

_exit:
	MOV R7, #1
	SIW 0


.global printf

.global scanf

.data
f1: .asciz "How many beans make 5? "
f2: .asciz "%d"
f3: .asciz "Well done!\n"
f4: .asciz "%d beans do not make 5!\n"
n: .word 0x00
