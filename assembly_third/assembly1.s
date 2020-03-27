.global _start

_start:

	MOV R0, #0
	LDR R1, =char
	MOV R2, #1

	BL _read


	MOV R0, #1
	LDR R1, =char
	MOV R2, #1

	BL _write


	LDR R4, [R1]
	CMP R4, #46
	B _exit

	B _start


_read:
	MOV R7, #3
	SWI 0
	BX LR


_write:
	MOV R7, #4
	SWI 0
	BX LR


_exit:
	MOV R7, #1
	SWI 0

.data
char: .word 0x00
