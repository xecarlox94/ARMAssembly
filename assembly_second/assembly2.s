.global _start

_start:
	LDR R1, =str
	BL _length

_exit:
	MOV R0, R2
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
	BEQ _incr

	LSR R3, #8
	B _nextb

_incr:
	ADD R1, #4
	B _nextw

_endl:
	BX LR

.data
str: .asciz "01234"
.equ MASK, 0xff
.equ EOS, 0
