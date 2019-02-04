GPIO_PORTB_DATA 	EQU 	0x400053FC ; data address to all pins 2 
GPIO_PORTB_DIR 		EQU 	0x40005400 
GPIO_PORTB_AFSEL 	EQU 	0x40005420 
GPIO_PORTB_DEN 		EQU 	0x4000551C
GPIO_PORTB_PUR		EQU		0x40005510		
IOB 				EQU 	0x00F      ; 0123 output
GPIO_PORTB_IS		EQU		0x40005404
GPIO_PORTB_IBE		EQU		0x40005408	
GPIO_PORTB_IEV		EQU		0x4000540C
GPIO_PORTB_IM		EQU		0x40005410
GPIO_PORTB_ICR		EQU		0x4000541C
GPIO_PORTB_RIS		EQU		0x40005414	
NVIC_EN0_R			EQU		0xE000E100	

SYSCTL_RCGCGPIO 	EQU 	0x400FE608 
						
					AREA   |. text|, READONLY, CODE, ALIGN=2 
					THUMB 
					EXPORT 	gpioset 
										
gpioset				
					PUSH	{R0-R1}
					LDR 	R1, =SYSCTL_RCGCGPIO 
										
					LDR 	R0, [R1] 
					ORR 	R0, R0, #0x2F	
					STR 	R0, [R1] 
					NOP 
					NOP 
					NOP 				; let GPIO clock stabilize 
									
					LDR	 	R1, =GPIO_PORTB_DIR 	; config . of port B starts 
					LDR 	R0, [R1] 
					BIC 	R0, #0xFF 				; R0 = 0
					ORR 	R0, #IOB 				; or with 00001111
					STR 	R0, [R1] 
					LDR 	R1, =GPIO_PORTB_AFSEL   ; pin func controlled by gpio registers
					LDR 	R0, [R1] 				
					BIC 	R0, #0xFF 			
					STR 	R0, [R1] 				
					LDR 	R1, =GPIO_PORTB_DEN 
					LDR 	R0, [R1] 
					ORR 	R0, #0xFF 
					STR 	R0, [R1] 			
					LDR 	R1, =GPIO_PORTB_PUR		; button pins pulled up
					MOV 	R0, #0x0F0
					STR 	R0, [R1]
					MOV 	R0, #0x00
					LDR 	R1, =GPIO_PORTB_IS		; edge sensitive
					STR		R0,[R1]
					LDR		R1, =GPIO_PORTB_IBE
					STR		R0,[R1]
					LDR 	R1, =GPIO_PORTB_IEV		; edge sensitive
					MOV		R0,#0x0F0				; rising edge	
					STR		R0,[R1]
					LDR 	R1, =GPIO_PORTB_IM		; enable interrupt
					STR 	R0,[R1]
					LDR 	R1, =GPIO_PORTB_ICR 	; clear interrupt flag
					STR 	R0,[R1]
					MOV 	R0,#0x02
					LDR		R1,=NVIC_EN0_R			; enable portB interrupt
					STR		R0,[R1]
					
					POP		{R0-R1}
					BX		LR
		