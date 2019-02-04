ADCACTSS	EQU		0x40038000
ADCEMUX		EQU		0x40038014
ADCSSCTL3	EQU		0x400380A4
ADCPC		EQU   	0x40038FC4
RCGCADC		EQU		0x400FE638
			AREA 	routines, CODE, READONLY
			THUMB
			EXPORT 	ADC0_set

ADC0_set	
			PUSH	{R0-R1}
			
			LDR		R1,=RCGCADC
			MOV		R0,#0X01
			STR		R0,[R1]
			NOP						
			NOP		
			NOP
			NOP 
			NOP 
			NOP
			NOP
			NOP
			NOP 
			NOP
			
			LDR		R1,=ADCACTSS ; disable sequencer 3
			MOV		R0,#0X0
			STR		R0,[R1]
			
			LDR		R1,=ADCEMUX
			MOV		R0,#0X0
			STR		R0,[R1]	     ; clear bits 15:12

			LDR		R1,=ADCSSCTL3
			MOV		R0,#0x06	 ; set IE0, END0
			STR		R0,[R1]
			
			LDR		R1,=ADCPC
			MOV 	R0,#0X01
			STR		R0,[R1]		 ; select 125 ksps
			
			LDR		R1,=ADCACTSS ; enable sequencer 3
			MOV		R0,#0x08
			STR		R0,[R1]
			
			POP		{R0-R1}
			BX		LR

			END