.global _start

_start:
	BL _pStrs

	LDR R1, =srcstr
	LDR R0, =dststr

	BL _strcpy

	BL _pStrs

	B _exit

_strcpy:
	LDRB R2, [R1]
	STRB R2, [R0]

	ADD R1, #1
	ADD R0, #1

	CMP R2, #0
	BNE _strcpy

	BX LR

_pStrs:
	PUSH { LR }

	LDR R1, =srcstr
	BL _print

	LDR R1, =dststr
	BL _print

	POP { LR }
	BX LR

_print:
	MOV R7, #4
	MOV R0, #1
	MOV R2, #maxSize

	SWI 0
	BX LR

_exit:
	MOV R7, #1
	SWI 0

.data
.equ maxSize, 14

srcstr:
	.asciz "1 string: src\n"

dststr:
	.asciz "2 string: dst\n"

