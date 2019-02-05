			AREA   		init_isr, CODE,READONLY, ALIGN=2
			EXPORT 		ADC1_HANDLER
					
ADC1PSSI		EQU		0x40039028
ADC1RIS			EQU		0x40039004
ADC1SSFIFO0 		EQU		0x40039048
ADC1ISC			EQU		0x4003900C
YCOOR			EQU		0x20000410

	
ADC1_HANDLER		PROC
			PUSH		{R0,R1,R2,R3,R4,R5,LR}
			MOV 		R0,#0X080	  	; 128 , FOR Y-AXIS
				
			LDR		R2,=ADC1SSFIFO0
								
			LDR		R5,[R2]
			LDR		R5,[R2]
			LDR		R5,[R2]
			LDR		R5,[R2]
			LDR		R5,[R2]
			LDR		R5,[R2]
			LDR		R5,[R2]
			LDR		R5,[R2]
			UDIV		R5,R5,R0
				
			LDR  		R1,=YCOOR
			STR	 	R5,[R1]
				
			MOV		R0,#0X01
			LDR		R2,=ADC1ISC
			STR		R0,[R2]
				
			LDR		R2,=ADC1PSSI
			MOV		R0,#0X01
			STR		R0,[R2]
			POP		{R0,R1,R2,R3,R4,R5,LR}
			BX		LR
			ENDP
			END
				
			
				
				
