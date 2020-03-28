.global _start

_start:
	LDR R0, =tens
	MOV R1, #10
	MOV R2, #1
	MOV R3, #10

	BL _pow


	MOV R1, #10
	LDR R2, =tens
	ADD R2, #36


_nextc:
	LDR R3, [R2]
	MOV R4, #0

_loop10:
	CMP R0, R3
	BLT _showd

	SUB R0, R3
	ADD R4, #1
	B _loop10


_showd:
	ADD R4, #'0'
	LDR R5, =char
	STR R4, [R5]

	PUSH { R0 }
	PUSH { R1 }
	PUSH { R2 }

	MOV R0, #1
	LDR R1, =char
	MOV R2, #1

	PUSH { LR }
	BL _write

	POP { LR }
	POP { R2 }
	POP { R1 }
	POP { R0 }


_next10:
	SUB R1, #1
	CMP R1, #0
	BEQ _endp

	SUB R2, #4

	B _exit


_pow:
	STR R2, [R0]

	SUB R3, #1
	CMP R3, #0
	BEQ _endp

	MUL R2, R1
	ADD R0, #4

	B _pow

_endp:  BX LR


_write:
	MOV R7, #4
	SWI 0
	BX LR

_exit:
	MOV R7, #1
	SWI 0

.data
tens:   .rept 10
	.word 0x00
	.endr

char:   .word 0x00
