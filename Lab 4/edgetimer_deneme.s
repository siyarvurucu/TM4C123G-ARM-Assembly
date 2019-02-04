				AREA 	main, CODE, READONLY
				THUMB
				EXTERN	measure_timer_init
				EXPORT  __main

TIMER1_TAR		EQU		0x40031048 ; Timer register
TIMER1_RIS		EQU 	0x4003101C ; Timer Interrupt Status
TIMER1_ICR		EQU 	0x40031024 ; Clear interrupt	
__main 			BL  measure_timer_init
				LDR R1,=TIMER1_RIS
				LDR R2,=TIMER1_TAR
				LDR R3,=TIMER1_ICR
loop			LDR R0,[R1]
				ANDS R0,#0X04
				BEQ  loop
				
				LDR R5,[R2]
				MOV R0,#0x04
				STR R0,[R3]
				
				b	loop
				
				END
				