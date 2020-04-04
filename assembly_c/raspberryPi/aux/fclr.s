.global fclr

fclr:
	@ R0 gpio address, R1 pin number

	ADD R0, #40		@ move pointer to 10th register

	CMP R1, #32
	BLT clrbit		@ if pin is larger than 31 

	ADD R0, #4		@ move pointer to 8th register
	SUB R1, #32		@ subtract the pin number

clrbit:

	MOV R2, #0b1
	
	LSL R2, R1		@ shift the value by pin number
	
	LDR R3, [R0]	@ load register
	
	BIC R3, R2		@ clear bit in the pin position
	
	STR R3, [R0]	@ store new register value

	BX LR
