; second task

GPIO_PORTB_DATA 	EQU 	0x400053FC ; data address to all pins 2 
GPIO_PORTB_DIR 		EQU 	0x40005400 
GPIO_PORTB_AFSEL 	EQU 	0x40005420 
GPIO_PORTB_DEN 		EQU 	0x4000551C 
IOB 			EQU 	0xF0 	
SYSCTL_RCGCGPIO 	EQU 	0x400FE608 
PBinput			EQU	0x4000503C
PBoutput		EQU	0x400053C0

	
			AREA   	main, READONLY, CODE, ALIGN=2 
			THUMB 
			EXPORT 	__main
			EXTERN	DELAY100
			EXTERN	OutChar
__main						
			LDR 	R1, =SYSCTL_RCGCGPIO 
										
			LDR 		R0, [R1] 
			ORR 		R0, R0, #0x12 
			STR 		R0, [R1] 
			NOP 
			NOP 
			NOP 							; let GPIO clock stabilize 
									
			LDR	 	R1, =GPIO_PORTB_DIR 	; config . of port B starts 
			LDR 		R0, [R1] 
			BIC 		R0, #0xFF 				; R0 = 0
			ORR 		R0, #IOB 				; or with 1111000
			STR 		R0, [R1] 
			LDR 		R1, =GPIO_PORTB_AFSEL   ;make pin functions controlled by gpio registers
			LDR 		R0, [R1] 				
			BIC 		R0, #0xFF 			
			STR 		R0, [R1] 				;
			LDR 		R1, =GPIO_PORTB_DEN 
			LDR 		R0, [R1] 
			ORR 		R0, #0xFF 
			STR 		R0, [R1] 				; config . of port B ends
				
			LDR		R1, =GPIO_PORTB_DATA
			LDR		R5, =0x0041
loop			BL		OutChar
			LDR		R0, [R1]
			BL		DELAY100
			LSL		R0,#0x04
			STR		R0, [R1]
			LDR		R2,=0x032
FIVESEC			BL 		DELAY100
			SUBS		R2,#0x01
			CMP 		R2,#0x00
			BNE		FIVESEC
			B		loop			
			END
		

							
