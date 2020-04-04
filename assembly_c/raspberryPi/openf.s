.global openf

openf:
	
	LDR	R0, .addr_file		@ get GPIO Controller addr
	LDR	R1, .flags		@ set flag permissions
	

	PUSH { LR }

	BL	open			@ call to get file handle
	
	POP { LR }
	
	BX LR
	



.addr_file:	.word	.file
.flags:		.word	1576962

.data
.file:	.ascii "/dev/mem\000"
