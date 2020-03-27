.global _start

_start:
	MOV R2, #X

	MOV R1, R2
	LSR R1, #1

_loop:
	CMP R1, #0
	BLE _exit

	MUL R3, R1, R1
	CMP R3, R2
	BGT _exit

	SUB R1, #1

	B _loop

_exit:
	MOV R0, R1
	MOV R7, #1
	SWI 0

.data
.equ X, 27


