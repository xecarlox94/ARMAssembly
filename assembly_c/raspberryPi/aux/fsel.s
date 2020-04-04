.global fsel


fsel:

	SUB SP, #8

	STR R0, [SP]
	
	STR R1, [SP, #4]

	ADD SP, #8
	
	BX LR




divmod:
	
