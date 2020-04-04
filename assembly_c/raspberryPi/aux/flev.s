.global flev

flev:
	@ R0 gpio address, R1 pin number

	ADD R0, #52		@ move pointer to 13th register

	CMP R1, #32
	BLT levbit		@ if pin is larger than 31 

	ADD R0, #4		@ move pointer to 8th register
	SUB R1, #32		@ subtract the pin number

levbit:
	
	LDR R3, [R0]	@ load register
	
	LSR R3, R1		@ right logical shift to move bit to beginning
	
	AND R3, #0b1	@ get first bit
	
	MOV R0, R3		@ return bit value

	BX LR
