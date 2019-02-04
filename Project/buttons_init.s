GPIO_PORTF_DATA 	EQU 	0x400253FC ; data address to all pins 2 
GPIO_PORTF_DIR 		EQU 	0x40025400 
GPIO_PORTF_AFSEL 	EQU 	0x40025420 
GPIO_PORTF_DEN 		EQU 	0x4002551C
GPIO_PORTF_PUR		EQU		0x40025510		
GPIO_PORTF_IS		EQU		0x40025404
GPIO_PORTF_IBE		EQU		0x40025408	
GPIO_PORTF_IEV		EQU		0x4002540C
GPIO_PORTF_IM		EQU		0x40025410
GPIO_PORTF_ICR		EQU		0x4002541C
GPIO_PORTF_RIS		EQU		0x40025414	
NVIC_EN0_R			EQU		0xE000E100
GPIO_PORTF_LOCK		EQU		0x40025520
GPIO_PORTF_CR		EQU		0x40025524	
UNLOCK				EQU		0x4C4F434B
SYSCTL_RCGCGPIO 	EQU 	0x400FE608 
						
					AREA   |. text|, READONLY, CODE, ALIGN=2 
					THUMB 
					EXPORT 	buttons_init 
										
buttons_init				
					PUSH	{R0-R1}
					LDR 	R1, =SYSCTL_RCGCGPIO 
										
					LDR 	R0, [R1] 
					ORR 	R0, R0, #0x2F	
					STR 	R0, [R1] 
					NOP 
					NOP 
					NOP 				; let GPIO clock stabilize 
					

					LDR		R1, =GPIO_PORTF_LOCK
					LDR		R0, =UNLOCK
					STR		R0,[R1]
					LDR		R1, =GPIO_PORTF_CR
					MOV		R0,#0x011
					STR		R0,[R1]
					
					LDR	 	R1, =GPIO_PORTF_DIR 	; config . of port B starts 
					LDR 	R0, [R1] 
					ORR 	R0, #0X00 				; or with 00001111
					STR 	R0, [R1] 
					LDR 	R1, =GPIO_PORTF_AFSEL   ; pin func controlled by gpio registers
					LDR 	R0, [R1] 				
					BIC 	R0, #0xFF 			
					STR 	R0, [R1] 				
					LDR 	R1, =GPIO_PORTF_DEN 
					LDR 	R0, [R1] 
					ORR 	R0, #0xFF 
					STR 	R0, [R1] 			
					LDR 	R1, =GPIO_PORTF_PUR		; button pins pulled up
					MOV 	R0, #0x011
					STR 	R0, [R1]
					MOV 	R0, #0x00
					LDR 	R1, =GPIO_PORTF_IS		; edge sensitive
					STR		R0,[R1]
					LDR		R1, =GPIO_PORTF_IBE
					STR		R0,[R1]
					LDR 	R1, =GPIO_PORTF_IEV		; edge sensitive
					MOV		R0,#0x011				; rising edge	
					STR		R0,[R1]
					LDR 	R1, =GPIO_PORTF_IM		; enable interrupt
					STR 	R0,[R1]
					LDR 	R1, =GPIO_PORTF_ICR 	; clear interrupt flag
					STR 	R0,[R1]
					MOV 	R0,#0x40000000
					LDR		R1,=NVIC_EN0_R			; enable portB interrupt
					STR		R0,[R1]
					
					POP		{R0-R1}
					BX		LR
		