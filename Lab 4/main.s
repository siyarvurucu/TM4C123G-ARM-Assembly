			AREA 	main, CODE, READONLY
			THUMB

			EXTERN	PULSE_INIT
			EXTERN	measure_timer_init
			EXTERN	CONVRT
			EXTERN 	OutStr
			EXPORT  __main

TIMER1_TAR		EQU		0x40031048 ; Timer register
TIMER1_RIS		EQU 	0x4003101C	; Timer Interrupt Status
TIMER1_ICR		EQU 	0x40031024 ; Clear interrupt	
GPIO_PORTF_DATA	EQU 	0x40025010 ; Pf2
__main		BL		measure_timer_init
			BL 		PULSE_INIT
			LDR	 R5,=0X20000601 ; memory loc. for period
			LDR  R0,=0X54207375 ; writing us T (microsec period)
			STR  R0,[R5],#0X04  ; move loc.
			MOV	 R0,#0X040A     ; new line (0A), finish output (04)
			STR	 R0,[R5]
			
			LDR	 R5,=0X20000701 ; memory loc. for pulse width
		    LDR  R0,=0X7375     ; writing us width
			STR	 R0,[R5],#0X02
			LDR  R0,=0X64697720 
			STR	 R0,[R5],#0X04  
			LDR  R0,=0X040A6874 
			STR  R0,[R5]
			
			LDR  R5,=0X20000401	; memory loc. for duty cycle
			LDR  R0,=0X040A25   ; writing %
			STR  R0,[R5]
			
			MOV	 R0,#0x0
			LDR	 R6,=GPIO_PORTF_DATA  ; pf2
			LDR  R3,=TIMER1_ICR 
			LDR  R2,=TIMER1_TAR
			LDR	 R1,=TIMER1_RIS

; Check if output is high after interrupt flag is set,
; for first time record only. Takes record three times
; before calculation. Recordings happen as following;
;____1¯¯¯¯¯¯¯¯¯¯¯¯2________3¯¯¯¯¯¯¯¯¯¯¯¯|________1¯¯¯¯ 
			
loop		LDR  R0,[R1]  ; interrupt flag set?
			ANDS R0,#0X04
			BEQ	 loop     
			LDR  R0,[R6]  ; is it high?
			SUBS R0,R0,#0X04
			BNE  loop
			LDR	 R8,[R2]  ; record first time
			ORR  R0,#0x04 ; clear flag
			STR	 R0,[R3]  
			
loop2		LDR  R0,[R1]  ; interrupt flag set?
			ANDS R0,#0X04
			BEQ	 loop2 
			LDR	 R9,[R2]  ; record second time
			ORR  R0,#0X04
			STR	 R0,[R3]			
			
loop3		LDR R0,[R1]   ; interrupt flag set?
			ANDS R0,#0X04
			BEQ	 loop3    
			LDR	 R10,[R2] ; record third time
			ORR  R0,#0X04 
			STR	 R0,[R3]
			
			ADD  R9,R9,#0X020   ; those are constant errors
			ADD  R10,R10,#0X050 ; causing 3us and 6us shift
								; undependent from frequency
								
			MOV  R7,#0X010      ; divide difference by 16
			LDR  R5,=0X20000600 ; because timer1 counted 16 times faster
			SUB  R4,R8,R10      ; t1-t3
			UDIV R4,R4,R7       ; divide by 16
			BL	 CONVRT          
			BL   OutStr         ; this is period in microsec
			
			MOV  R7,#0X010      ; divide by 16
			LDR  R5,=0X20000700
			SUB	 R4,R8,R9       ; t1-t2
			UDIV R4,R4,R7
			BL	 CONVRT
			BL   OutStr         ; pulse width in microsec
			
			SUB	 R0,R8,R10      ; t1-t3
			UDIV R0,R0,R7       ; /16
			MOV  R7,#0X064      ; =100
			LDR  R5,=0X20000400
			MUL  R4,R4,R7       ; R4 was t1-t2
			UDIV R4,R4,R0       ; 100*(t1-t2)/(t1-t3)
			BL 	 CONVRT
			BL   OutStr         ; duty cycle in percent

			B	 loop           ; restart
			END