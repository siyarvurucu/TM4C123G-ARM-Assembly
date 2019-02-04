; Initialization of timer modules
			AREA 	routines, CODE, READONLY
			THUMB
			EXPORT 	measure_timer_init
TIMER1_CFG		EQU 	0x40031000
TIMER1_TAMR		EQU 	0x40031004
TIMER1_CTL		EQU 	0x4003100C
TIMER1_IMR		EQU 	0x40031018
TIMER1_RIS		EQU 	0x4003101C ; Timer Interrupt Status
TIMER1_ICR		EQU 	0x40031024 ; Timer Interrupt Clear
TIMER1_TAILR		EQU 	0x40031028 ; Timer interval
TIMER1_TAPR		EQU 	0x40031038 ; prescale
TIMER1_TAR		EQU	0x40031048 ; Timer register
	
GPIO_PORTB_DATA 	EQU 	0x400053FC ; data address to all pins 2 
GPIO_PORTB_DIR 		EQU 	0x40005400 
GPIO_PORTB_AFSEL 	EQU 	0x40005420 
GPIO_PORTB_DEN 		EQU 	0x4000551C
GPIO_PORTB_AMSEL 	EQU 	0x40005528 ; Analog enable
GPIO_PORTB_PCTL 	EQU 	0x4000552C ; Alternate Functions

;System Registers
SYSCTL_RCGCGPIO 	EQU 	0x400FE608 ; GPIO Gate Control
SYSCTL_RCGCTIMER 	EQU 	0x400FE604 ; GPTM Gate Control

measure_timer_init
			LDR 	R1, =SYSCTL_RCGCGPIO	 ; start GPIO clock
			LDR 	R0, [R1]
			ORR 	R0, R0, #0x2F 		; set bit 1 for port all
			STR 	R0, [R1]
			NOP 				; allow clock to settle
			NOP
			NOP
			
			LDR 	R1, =GPIO_PORTB_DIR	 ; set direction of PB4
			LDR 	R0, [R1]
			MOV 	R0, #0X00 		; set PB4 for input
			STR 	R0, [R1]
			
			LDR 	R1, =GPIO_PORTB_AFSEL   ; alternate function
			LDR 	R0, [R1]
			ORR 	R0, R0, #0x010
			STR 	R0, [R1]
			
			LDR 	R1, =GPIO_PORTB_PCTL 	; set alternate function to T0CCP0 on pb4
			LDR 	R0, [R1]
			ORR 	R0, R0, #0x00070000
			STR 	R0, [R1]
			
			LDR 	R1, =GPIO_PORTB_AMSEL  ; disable analog
			MOV 	R0, #0
			STR 	R0, [R1]
				
			LDR 	R1, =GPIO_PORTB_DEN     ; enable port digital
			LDR 	R0, [R1]
			ORR 	R0, R0, #0x010
			STR 	R0, [R1]
			
			LDR 	R1, =SYSCTL_RCGCTIMER   ; Start Timer1
			LDR 	R2, [R1]
			ORR 	R2, R2, #0x02
			STR 	R2, [R1]
			NOP 				; allow clock to settle
			NOP
			NOP
			
			LDR 	R1, =TIMER1_CTL 	; disable timer during setup 
			LDR 	R2, [R1]
			BIC 	R2, R2, #0x01
			STR 	R2, [R1]    
			
			LDR 	R1,=TIMER1_CFG
			MOV 	R2,#0X04		; 16 BIT
			STR 	R2,[R1]			
				
			LDR 	R1, =TIMER1_TAMR
			MOV 	R2, #0x07 		; edge time,capture
			STR 	R2, [R1]
			
			LDR 	R1,=TIMER1_CTL  	; edge detection both edges
			LDR	R2,[R1]
			ORR 	R2,R2,#0X0C
			STR 	R2,[R1]
			
			LDR 	R1,=TIMER1_TAILR
			MOV32 	R0,#0XFFFFFFFF
			STR 	R0,[R1]
			
			LDR 	R1,=TIMER1_TAPR
			MOV 	R0,#0x0F
			STR 	R0,[R1]
			
			LDR 	R1, =TIMER1_CTL
			LDR 	R2, [R1]
			ORR 	R2, R2, #0x03 		; set bit0 to enable
			STR 	R2, [R1] 		; and bit 1 to stall on debug
		
			BX LR
			
