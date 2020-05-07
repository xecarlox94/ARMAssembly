.global fsel

fsel:
	SUB SP, #12
	
	@ R0 gpio address, R1 pin number, R2 mode

	STR R0, [SP]      	@ gpio address
	STR R2, [SP, #4]	@ mode
	STR LR, [SP, #8]    @ linking register
	
	
	MOV R0, R1			@ move pin number
	MOV R1, #0
	BL divmod			@ R0 remainder of division by 10, R1 register number

	MOV R2, #4
	MUL R1, R2, R1		@ determining correct select register
	LDR R6, [SP]		@ loading original gpio address register
	ADD R6, R1			@ move gpio pointer
	STR R6, [SP]		@ storing correct select register
	
	MOV R1, #3
	MUL R0, R1, R0		@ determining correct bitwise logical shit
	MOV R1, #0b111
	LSL R1, R0
	
	LDR R5, [R6]		@ read gpio register
	BIC R5, R1			@ clear the 3 mode bits
	
	LDR R1, [SP, #4]    @ loading mode
	CMP R1, #0
	BEQ	wreg			@ if mode is zero, ignore redundant write
	
	LSL R1, R0			@ shifting mode to right position
	ORR R5, R1			@ writing mode in the register

wreg:	
	STR R5, [R6]

	LDR LR, [SP, #8]
	
	ADD SP, #12
	
	B retf




divmod:
	CMP R0, #10
	BLT retf
	
	SUB R0, #10
	ADD R1, #1
	
	B divmod



retf:  BX LR
