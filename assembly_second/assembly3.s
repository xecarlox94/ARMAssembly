.global _start


_start:
	MOV R2, #X
	MOV R3, #Y

	PUSH { R2 }
	PUSH { R3 }

	BL _sq1

	POP { R4 }

	B _exit

_sq1:
	POP { R6 }
	POP { R5 }

	MUL R4, R5, R5
	MUL R5, R6, R6
	ADD R5, R4

	PUSH { R5 }

	BX LR

_exit:
	MOV R0, R4
	MOV R7, #1
	SWI 0

.data
.equ X, 3
.equ Y, 4
