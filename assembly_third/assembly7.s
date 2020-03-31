.global main


.global printf
.global fopen
.global fclose
.global getc
.global putc

main:
	PUSH { R1 }

	LDR R0, [R1, #0x04]
	LDR R1, =r
	BL fopen

	LDR R1, =fin
	STR R0, [R1]

	POP { R1 }
	LDR R0, [R1, #8]
	LDR R1, =w
	BL fopen

	LDR R1, =fout
	STR R0, [R1]

	BL _loop

	LDR R1, =fin
	LDR R0, [R1]
	BL fclose

	LDR R1, =fout
	LDR R0, [R1]
	BL fclose

	B _exit

_loop:
	LDR R1, =fin
	LDR R0, [R1]
	BL getc

	CMP R0, #-1
	BEQ _endl

	LDR R2, =fout
	LDR R1, [R2]
	BL putc

	B _loop

_endl:  BX LR


_exit:
	MOV R7, #1
	SWI 0

.data
fin:  .word 0x00
fout: .word 0x00
r: .asciz "r"
w: .asciz "w"
