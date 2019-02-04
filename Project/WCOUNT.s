SSIDR					EQU		0x40008008
SSICISR					EQU		0x4000800C
GPIO_PORTA_DATA			EQU		0x400043FC
	
					
						AREA 	Routines, READONLY, CODE
						EXTERN  WRITE
						EXPORT 	WCOUNT

WCOUNT					PUSH 	{R0-R4}					; Write the numbers written in the addresses placed in R4,R5 respectively
						PUSH 	{LR}
						LDR	 	R0, =GPIO_PORTA_DATA	; Screen initialization, X,Y coordinates are denoted to choose the counter area
						LDR 	R1, [R0]
						BIC	 	R1, #0x40
						STRB 	R1, [R0] 
						
						MOV  	R2, #0x20
						BL  	WRITE						
						MOV 	R2, #0x40
						BL  	WRITE					
						MOV 	R2, #0xC7
						BL  	WRITE
						
						LDR	 	R0, =GPIO_PORTA_DATA
						LDR  	R1, [R0]
						ORR		R1, #0x40
						STRB	R1, [R0] 
						
						MOV 	R1, #14					; Write the numbers byte by byte
WLOOP					LDR 	R2, [R4], #1
						BL 		WRITE
						SUB 	R1, #1
						CMP 	R1, #7
						MOVEQ 	R4, R5
						CMP		R1, #0
						BNE		WLOOP
						POP  	{LR}
						POP  	{R0-R4}
						BX 		LR
				
					
					
					
					