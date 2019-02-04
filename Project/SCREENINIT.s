CURSORX0BASE		   	EQU	   	0x20000404
CURSORX1BASE		  	EQU	   	0x20000408	
CURSORX2BASE		   	EQU	   	0x2000040C
GPIO_PORTA_DATA        	EQU    	0x400043FC
	
	
						AREA   	Routines,READONLY,CODE
						EXTERN 	WRITE
						EXTERN 	DELAY100
						EXPORT 	SCREENINIT
						
SCREENINIT				PUSH 	{R0,R1,R2,LR}
						LDR  	R0 , =CURSORX0BASE
						MOV  	R1 , #0x2
						STR  	R1 , [R0]
						LDR 	R0 , =CURSORX1BASE
						MOV  	R1 , #0x7
						STR  	R1 , [R0]
						LDR  	R0 , =CURSORX2BASE
						MOV  	R1 , #0x2
						STR  	R1 , [R0]
						
						LDR 	R1,=GPIO_PORTA_DATA
						LDR		R0,[R1]
						BIC		R0,#0x80
						STR		R0,[R1]
						
						BL 		DELAY100
						
						LDR 	R1,=GPIO_PORTA_DATA
						LDR		R0,[R1]
						ORR		R0,#0x80
						STR		R0,[R1]


						MOV		R2,#0x21			;H=1	
						BL		WRITE
						
						MOV		R2, #0xA4			;VOP
						BL 		WRITE
						
						MOV		R2, #0xB8			;CONTRAST YANLIS SANIRIM
						BL 		WRITE
						
						MOV		R2, #0x04			;TEMPERATURE
						BL 		WRITE
						
						MOV		R2, #0x13			;BIAS MODE
						BL 		WRITE

						MOV		R2, #0x20			;H=0
						BL 		WRITE
						
						MOV		R2, #0x0C			;H=0
						BL 		WRITE
						
						LDR 	R1,=GPIO_PORTA_DATA		
						LDR		R0,[R1]
						ORR		R0,#0x40			;A6 = 1
						STR		R0,[R1]			
						
						MOV		R1, #504			;cleanthedisplay
						MOV		R2, #0x00
						
fill					BL		WRITE
						SUBS 	R1, #1
						BNE		fill
						
						POP 	{R0,R1,R2,LR}
						BX 		LR