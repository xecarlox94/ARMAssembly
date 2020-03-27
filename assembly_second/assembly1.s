.global _start

_start:
	LDR R1, =A
	MOV R2, #0

_loop:
	CMP R2, #MAX
	BGE _search
	STR R2, [R1]
	ADD R1, #4
	ADD R2, #1
	B _loop

_search:
	MOV R0, #1
	MOV R1, #0
	MOV R2, #MAX
	SUB R2, #1
	MOV R6, #4

_searchLoop:
	CMP R2, R1
	BLT _fail

	ADD R3, R1, R2
	LSR R3, #1
	MUL R7, R6, R3

	LDR R4, =A
	ADD R4, R7

	LDR R5, [R4]
	CMP R5, #V
	BEQ _found

	BLT _left
	MOV R2, R3
	SUB R2, #1
	B _searchLoop

_left:
	MOV R1, R3
	ADD R1, #1
	B _searchLoop


_fail:
	MOV R0, #MAX
	B _exit

_found:
	MOV R0, R3

_exit:
	MOV R7, #1
	SWI 0

.data
.equ MAX, 25
.equ V, 50
A: .rept MAX
   .word 0
   .endr
