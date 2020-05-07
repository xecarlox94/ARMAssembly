.global mapm


mapm:

	SUB SP, SP, #12

	STR	LR, [SP, #8]		@ store linking pointer

	STR	R0, [SP, #0]		@ Store file handle on top stack

	LDR	R0, .gpiobase		@ get GPIO_Base address
	STR	R0, [SP, #4]		@ store on SP+4

	MOV	R0, #0			@ R0=0
	MOV	R1, #4096		@ R1=page
	MOV	R2, #3			@ R2=3
	MOV	R3, #1			@ R3=1 (stdouts)

	BL	mmap			@ call libc fct for mmap

	LDR LR, [SP, #8]

	ADD SP, SP, #12

	BX LR

.gpiobase:	.word	0x3F200000	@ GPIO_Base for Pi 2

