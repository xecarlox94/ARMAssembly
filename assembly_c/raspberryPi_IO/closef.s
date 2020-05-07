.global closef



closef:

	@ R0 hsa the file handler

	PUSH { LR }
	
	BL close
	
	POP { LR }
	
	BX LR
	
