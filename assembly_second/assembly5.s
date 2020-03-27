.global _start


_start:
	MOV R1, #1
	MOV R2, #X
	MOV R3, #Y

	BL _pow

	B _exit

_pow:
	CMP R3, #0
	BEQ _pEnd

	MUL R1, R2, R1
	SUB R3, #1

	PUSH { LR }

	BL _pow

	POP { LR }

_pEnd:  BX LR


_exit:
	MOV R0, R1
	MOV R7, #1
	SWI 0

.data
.equ X, 3
.equ Y, 5
