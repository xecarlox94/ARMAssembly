.global _start


_start:

	LDR R0, [SP, #8]
	MOV R1, #O_RDONLY
	BL _open
	LDR R1, =fin
	STR R0, [R1]


	LDR R0, [SP, #12]
	MOV R1, #O_WRONLY
	ORR R1, #O_CREAT
	LDR R3, =access
	LDR R2, [R3]
	BL _open
	LDR R1, =fout
	STR R0, [R1]

_loop:
	LDR R1, =fin
	LDR R0, [R1]
	LDR R1, =char
	MOV R2, #1
	BL _read

	CMP R0, #0
	BEQ _endl

	MOV R0, #1
	LDR R1, =char
	MOV R2, #1
	BL _write

	LDR R1, =fout
	LDR R0, [R1]
	LDR R1, =char
	MOV R2, #1
	BL _write

	B _loop

_endl:
	LDR R1, =fin
	LDR R0, [R1]
	BL _close

	LDR R1, =fout
	LDR R0, [R1]
	BL _close

	B _exit


_write:
	MOV R7, #4
	SWI 0
	BX LR

_read:
	MOV R7, #3
	SWI 0
	BX LR

_open:
	MOV R7, #5
	SWI 0
	BX LR

_close:
	MOV R7, #6
	SWI 0
	BX LR

_exit:
	MOV R7, #1
	SWI 0

.data
.equ O_RDONLY, 0000
.equ O_WRONLY, 0001
.equ O_CREAT,  0100

access: .word 0644
char:   .word 0x00
fin:	.word 0x00
fout:	.word 0x00
