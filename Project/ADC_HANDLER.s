				AREA   	init_isr, CODE,READONLY, ALIGN=2
				EXPORT 	ADC0_HANDLER
				
ADC0PSSI		EQU		0x40038028
ADC0RIS			EQU		0x40038004
ADC0SSFIFO0		EQU		0x40038048
ADC0ISC			EQU		0x4003800C
XCOOR			EQU		0x20000414
	
ADC0_HANDLER	PROC
				PUSH	{R0,R1,R2,R3,R4,R5,LR}
				MOV		R3,#0X040     ; 64 , FOR X-AXIS
				
				LDR		R1,=ADC0SSFIFO0
				
				LDR		R5,[R1]
				LDR		R5,[R1]
				LDR		R5,[R1]
				LDR		R5,[R1]
				LDR		R5,[R1]
				LDR		R5,[R1]
				LDR		R5,[R1]
				LDR		R5,[R1]
				
				UDIV	R5,R5,R3
				
				LDR  	R1,=XCOOR
				STR	 	R5,[R1]
				
				MOV		R0,#0X01
				LDR		R1,=ADC0ISC
				STR 	R0,[R1]

				
				LDR		R1,=ADC0PSSI
				MOV		R0,#0X01
				STR 	R0,[R1]
				
				POP		{R0,R1,R2,R3,R4,R5,LR}
				BX		LR
				ENDP
				END
				
			
				
				