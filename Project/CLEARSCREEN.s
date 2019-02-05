				AREA 	Routines, READONLY, CODE
				EXTERN	WRITE
				EXPORT 	CLEARSCREEN

CLEARSCREEN 			PUSH 		{R0,R1,R2,LR}
				MOV		R0, #504			
				MOV		R2, #0x00
ZERO				BL		WRITE
				SUBS		R0, #1
				BNE		ZERO
				POP		{R0,R1,R2,LR}
				BX		LR	
