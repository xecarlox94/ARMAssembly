.global _start


_start:
	MOV R1, #X

	BL _quad

	B _exit

_sq:
	MUL R2, R1, R1
	MOV R1, R2

	BX LR

_quad:
	PUSH { LR }

	BL _sq
	BL _sq

	POP { LR }

	BX LR



_exit:
	MOV R0, R1
	MOV R7, #1
	SWI 0

.data
.equ X, 4
