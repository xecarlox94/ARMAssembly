.global _start


_start:
	LDR R1, [SP, #8]
	LDR R2, =argv1
	STR R1, [R2]


	BL _length

	MOV R0, #1
	LDR R3, =argv1
	LDR R1, [R3]
	BL write

	MOV R7, #1
	SWI 0

_length:
	MOV R2, #0
_nextw:
	LDR R3, [R1]
	MOV R5, #4

_nextb:
	MOV R4, R3
	AND R4, #MASK
	CMP R4, #EOS
	BEQ _endl

	ADD R2, #1
	SUB R5, #1
	CMP R5, #0
	BEQ _inc

	LSR R3, #8
	b _nextb

_inc:	ADD R1, #4
	B _nextw

_endl:	BX LR


write:
	MOV R7, #4
	SWI 0
	BX LR


.data
.equ MASK, 0x000000ff

.equ EOS, 0

argv1: .word 0x00
