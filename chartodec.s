;LABEL			DIRECTIVE	VALUE		COMMENT
			EXTERN 	 	InChar
			EXPORT 		chartodec
			EXTERN 		CONVRT
NUM  	   		EQU     	0x20000600
			AREA 		routines, READONLY, CODE
				
				
chartodec		PUSH		{LR}
			PUSH		{R0-R4}
			MOV		R3,#0x0A
			MOV		R2,#0x00
			MOV		R1,#0x00	;counter
			LDR		R0,=NUM
loop			BL		InChar
			CMP 		R5,#0x020
			ITT		EQ
			MOVEQ		R5,#0x00
			BEQ 		go
			SUB		R5,#0x030
			STRB		R5,[R0],#-0x01
			ADD 		R1,#0x01
			B		loop
			
go 			
			LDRB		R2,[R0,R1]
			SUBS		R1,#0x01
			BEQ		fin
			ADD		R5,R2
			MUL		R5,R3
			B		go
fin			
			ADD		R5, R2

			POP		{R0-R4}
			POP		{LR}
			BX 		LR
			
			END
