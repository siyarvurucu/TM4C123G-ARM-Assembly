ADC0ACTSS	EQU		0x40038000
ADC0EMUX	EQU		0x40038014
ADC0SSCTL0	EQU		0x40038044
ADC0PC		EQU   	0x40038FC4
RCGCADC		EQU		0x400FE638
ADC0PSSI	EQU		0x40038028
ADC0IM		EQU		0x40038008
	
ADC1ACTSS	EQU		0x40039000
ADC1EMUX	EQU		0x40039014
ADC1SSCTL0	EQU		0x40039044
ADC1PC		EQU   	0x40039FC4
ADC1PSSI	EQU		0x40039028
ADC1IM		EQU		0x40039008
ADC1SSMUX0	EQU		0X40039040
	
NVIC_EN0	EQU		0xE000E100
NVIC_EN1	EQU		0xE000E104
NVIC_PRI_32 EQU		0xE000E40C
NVIC_PRI_41 EQU		0xE000E430
	
			AREA 	routines, CODE, READONLY
			THUMB
			EXPORT 	adc_0_1_init

adc_0_1_init	
			PUSH	{R0-R1}
			
			LDR		R1,=RCGCADC
			MOV		R0,#0X03
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
			NOP 
			NOP 
			NOP
			NOP
			NOP
			NOP 
			NOP
			
			LDR		R1,=ADC0ACTSS ; disable sequencers
			MOV		R0,#0X0
			STR		R0,[R1]
			
			LDR		R1,=ADC0EMUX
			MOV		R0,#0X0
			STR		R0,[R1]	     ; clear bits 15:12

			LDR		R1,=ADC0SSCTL0
			MOV		R0,#0x60000000	 ; set IE0, END0
			STR		R0,[R1]
			
			LDR		R1,=ADC0PC
			MOV 	R0,#0X07
			STR		R0,[R1]		   ; select 125 ksps
			
			LDR		R1,=ADC0IM
			MOV 	R0,#0X01
			STR		R0,[R1]		 
			; ADC 1
			
			
			LDR		R1,=ADC1ACTSS ; disable sequencers
			MOV		R0,#0X0
			STR		R0,[R1]
			
			LDR		R1,=ADC1EMUX
			MOV		R0,#0X00
			STR		R0,[R1]	     ; clear bits 15:12

			LDR		R1,=ADC1SSCTL0
			MOV		R0,#0x60000000 ; set IE7, END7
			STR		R0,[R1]
			
			LDR		R1,=ADC1SSMUX0
			MOV		R0,#0X11111111
			STR		R0,[R1]
			
			LDR		R1,=ADC1PC
			MOV 	R0,#0X07
			STR		R0,[R1]		 ; select 125 ksps
			
			LDR		R1,=ADC1IM
			MOV 	R0,#0X01
			STR		R0,[R1]
			
			LDR		R1,=NVIC_EN0
			LDR		R2,=NVIC_EN1
			LDR		R0,=0x00004000
			STR		R0,[R1]
			LDR		R0,=0x00010000
			STR		R0,[R2]
			
			LDR		R1,=NVIC_PRI_32
			MOV		R0,#0X800000
			STR		R0,[R1]
			
			LDR		R1,=NVIC_PRI_41
			MOV		R0,#0X80
			STR		R0,[R1]
		
			LDR		R1,=ADC1ACTSS ; enable sequencer 0
			MOV		R0,#0x01
			STR		R0,[R1]
			
			LDR		R1,=ADC0ACTSS ; enable sequencer 0
			MOV		R0,#0x01
			STR		R0,[R1]
			
			
			LDR		R1,=ADC0PSSI
			LDR		R2,=ADC1PSSI
			MOV		R0,#0X01
			STR		R0,[R1]     ; set bit 1 in ADC0PSSI to take new sample
			STR		R0,[R2]     ; set bit 1 in ADC1PSSI to take new sample
			
			LDR 	R1,=ADC0IM		;disable adc interrupts
			LDR 	R2,=ADC1IM
			MOV		R0,#0x0
			STR		R0,[R1]
			STR		R0,[R2]	
			
			POP		{R0-R1}
			BX		LR

			END