.global main


main:
	SUB SP, SP, #16

	LDR R0, .addr_file
	LDR R1, .flags
	BL open


@	STR R0, [SP, #12]
@	STR R0, [SP, #0]
@	LDR R3, =.gpiobase
@	STR R3, [SP, #4]
@	MOV R0, #0
@	MOV R1, #4096
@	MOV R2, #3
@	MOV R3, #1
@	BL mmap

@	STR R0, [SP, #16]
@	LDR R1, [SP, #16]

fsel:

@	LDR R0, [R1, #4]
@	MOV R2, #0b111
@	MOV R4, #9
@	LSL R2, R2, R4
@	BIC R0, R2


@	MOV R3, #0b1
@	MOV R4, #9
@	LSL R3, R4
@	ORR R0, R0, R3

@	STR R0, [R1, #4]

fset:

@	LDR R1, [SP, #16]

@	MOV R0, #0b1
@	MOV R4, #13
@	LSL R0, R4

@	STR R0, [R1, #28]



closef:

@	LDR R0, [SP, #12]
@	BL close


exit:
@	ADD SP, SP, #16

@	MOV R7, #1
@	SWI 0



.addr_file: .word .file
.flags:     .word 1576962
.gpiobase:  .word 0x3F200000

.data
.file: .ascii "/dev/mem\000"
