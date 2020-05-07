.global fset

fset:
	@ R0 gpio address, R1 pin number, R2 bit value

	ADD R0, #28		@ move pointer to 7th register

	CMP R1, #32
	BLT setbit		@ if pin is larger than 31 

	ADD R0, #4		@ move pointer to 8th register
	SUB R1, #32		@ subtract the pin number

setbit:

	LSL R2, R1		@ shift the value by pin number
	
	LDR R3, [R0]	@ load register
	
	ORR R3, R2		@ OR logical operation with register and shifted value
	
	STR R3, [R0]	@ store new register value

	BX LR
