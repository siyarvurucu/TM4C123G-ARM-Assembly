ST				EQU		0x20000450
ADC0PSSI			EQU		0x40038028
ADC1PSSI			EQU		0x40039028
GPIO_PORTF_IM			EQU		0x40025410
COUNTERVAL			EQU		0x20000700
SHIPS				EQU		0x20000460
MINES				EQU		0x2000046C
AddressOfLastMine	    	EQU		0X20001500
Y_Axis				EQU		0x20000410
X_Axis				EQU		0x20000414
APINT				EQU		0xE000ED0C 
ADC0_IM				EQU		0x40038008
ADC1_IM				EQU		0x40039008
XCOORPREV			EQU		0x20000458
YCOORPREV			EQU		0x2000045C
PREVSTATE			EQU		0x20000454	; prev

				AREA 	main, CODE, READONLY
				THUMB
				EXTERN	adc_0_1_init
				EXTERN	pe2_pe3_init
				EXTERN	buttons_init
				EXTERN	LINEINIT
				EXTERN	UPDATECURSOR
				EXTERN  SCREENINIT
				EXTERN	PORTINIT
				EXTERN 	COUNTERINIT
				EXTERN	P1WON
				EXTERN	P2WON
				EXTERN	CLEARSCREEN
				EXTERN	CLEARBOUND
				EXPORT	__main
__main					
				CPSIE 	I
				BL	PORTINIT
				BL	SCREENINIT	 	 ; SPI INIT
				BL	adc_0_1_init 			
				BL	pe2_pe3_init
				BL	buttons_init
reset				LDR	R1, =0xE000E000		; Stop SysTick timer
				MOV	R2, #0
				STR	R2, [R1,#16]
				LDR 	R1, =COUNTERVAL
				STR	R2, [R1]
				LDR     R0, =SHIPS
				LDR	R9, =ST
				MOV	R1, #0
				MOV	R2, #20
DELETE				STR	R1, [R0]		; Erase memory for new game
				ADD	R0, #4
				SUBS	R2,#1
				BNE	DELETE
				STR	R1, [R9]
				LDR	R0, =XCOORPREV
				STR	R1, [R0]
				LDR	R0, =YCOORPREV
				STR	R1, [R0]
				LDR	R0, =PREVSTATE
				STR	R1, [R0]
				LDR	R1,=0X2000046C
				LDR	R0,=AddressOfLastMine
				STR	R1,[R0]						
				LDR	R0,[R9]
					
				BL	CLEARSCREEN
				BL	CLEARBOUND
											
st0				BL	UPDATECURSOR
				LDR	R9,=ST
				LDR	R0,[R9]
				CMP 	R0,#0x0						
				BEQ	st0
			
				BL	LINEINIT	  	; INITLINE
						
				MOV	R0,#0x1
				LDR 	R1,=ADC0_IM		;enable adc interrupts
				STR	R0,[R1]
				LDR 	R1,=ADC1_IM
				STR	R0,[R1]
						
st1				BL	UPDATECURSOR
				LDR	R0,[R9]
				CMP	R0,#0x1
				BEQ	st1
						
						
				LDR	R0,=X_Axis		; Record the coord. of 1st ship
				LDR	R1,[R0]
				LDR	R0,=SHIPS
				STRB	R1,[R0]
				LDR	R2,=Y_Axis
				LDR	R1,[R2]
				STRB	R1,[R0,#1]
						
st2				BL	UPDATECURSOR
				LDR	R0,[R9]
				CMP	R0,#0x2
				BEQ	st2
						
				LDR	R0,=X_Axis		; Record the coord. of 2st ship
				LDR	R1,[R0]
				LDR	R0,=SHIPS
				STRB	R1,[R0,#3]
				LDR	R2,=Y_Axis
				LDR	R1,[R2]
				STRB	R1,[R0,#4]
						
st3				BL	UPDATECURSOR
				LDR	R0,[R9]
				CMP	R0,#0x3
				BEQ	st3						
			
				LDR	R0,=X_Axis		; Record the coord. of 3st ship
				LDR	R1,[R0]
				LDR	R0,=SHIPS
				STRB	R1,[R0,#6]
				LDR	R2,=Y_Axis
				LDR	R1,[R2]
				STRB	R1,[R0,#7]
						
st4				BL	UPDATECURSOR
				LDR	R0,[R9]
				CMP	R0,#0x4
				BEQ	st4	

				LDR	R0,=X_Axis		; Record the coord. of 4st ship
				LDR	R1,[R0]
				LDR	R0,=SHIPS
				STRB	R1,[R0,#9]
				LDR	R2,=Y_Axis
				LDR	R1,[R2]
				STRB	R1,[R0,#10]

st5				BL	UPDATECURSOR		; ON GPIO P1
				LDR	R0,[R9]
				CMP	R0,#0x05
				BEQ	st5
						
st6				BL	UPDATECURSOR		; ON GPIO P2
				LDR	R0,[R9]
				CMP	R0,#0x06
				BEQ	st6
			
				LDR     R1,=COUNTERVAL
				MOV	R0,#0x1
				STR	R0,[R1]
				BL	COUNTERINIT		; 0.5 SEC
					
				;LDR	R1,=GPIO_PORTF_IM 	; DISABLE GPIO
				;MOV	R0,#0x0
				;STR	R0,[R1]
				BL	CLEARSCREEN
				BL	LINEINIT
st7				BL	UPDATECURSOR		; ON TIMER
				LDR	R0,[R9]
				CMP	R0,#0x07
				BEQ	st7
					
			
			
				LDR	R1,=GPIO_PORTF_IM 	; ENABLE GPIO
				MOV	R0,#0x11
				STR	R0,[R1]
			
				LDR     R1,=COUNTERVAL
				MOV	R0,#0x14
				STR	R0,[R1]
				BL	COUNTERINIT
					
st8				BL	UPDATECURSOR		; ON TIMER, GPIO
				LDR	R0,[R9]
				CMP	R0,#13
				BLT	st8
						
				MOV	R0,#0x0
				LDR 	R1,=ADC0_IM		;disable adc interrupts
				STR	R0,[R1]
				LDR 	R1,=ADC1_IM
				STR	R0,[R1]
				;MOV 	R0,#0x0			; disable adc before calc
				;LDR	R1,=ADC0PSSI
				;STR	R0,[R1]
				;LDR	R1,=ADC1PSSI
				;STR	R0,[R1]
				; Calculate who won
				LDR	R1,=SHIPS       	; Ships Addr						
				SUB	R1,R1,#3		; -3 , room for increment
Ships					
				LDR	R0,=MINES		; Mines Addr.
				SUB	R0,R0,#3        	; -3 , room for increment
					
				ADD	R1,R1,#3		; Increment Ship
				LDRB	R4,[R1,#2]		; Ship Type
				CMP	R4,#3			; ships are over?
				BEQ	P2_WON			; All ships handled correctly
						
				LDRB	R2,[R1]			; X of ship
				LDRB	R3,[R1,#1]		; Y of ship
					
				CMP	R4,#1			
				BEQ	Battleship
						
Civillian			ADD	R0,R0,#3		; Next mine
			
				LDRB	R4,[R0,#2]
				CMP	R4,#0X3			; No mine left?
				BNE	Ships			; This civillians not killed
						
				LDRB	R5,[R0]			; X of mine
				SUBS	R5,R5,R2		; X_mine - X_ship
				BMI	Civillian
				CMP	R5,#0X8
				BGT	Civillian
						
				LDRB	R5,[R0,#1]      	; Y of mine
				SUBS	R5,R5,R3		; Y_mine - Y_ship
				BMI	Civillian
				CMP	R5,#0X8
				BGT	Civillian
								; Here,It means mine hit the ship
				B	P1_WON			; They were innocent :(
						
Battleship			ADD	R0,R0,#3		; Next mine
						
				LDRB	R4,[R0,#2]
				CMP	R4,#0X3			; No mine left?
				BNE	P1_WON			; This battleship remains alive
						
				LDRB	R5,[R0]			; X of mine
				SUBS	R5,R5,R2		; X_mine - X_ship
				BMI	Battleship		; goto next mine, if this one cant hit
				CMP	R5,#0X8
				BGT	Battleship
						
				LDRB	R5,[R0,#1]      	; Y of mine
				SUBS	R5,R5,R3		; Y_mine - Y_ship
				BMI	Battleship
				CMP	R5,#0X8
				BGT	Battleship
								; Here means mine hit the ship
				B	Ships			; Next ship
						
P1_WON				BL	CLEARSCREEN					
P1_WON0				BL	P1WON
				LDR	R0,=APINT
				LDR	R1,[R0]
				ORR	R1, #0x4
				STR	R1,[R0]
				B	reset
						
						
P2_WON				BL	CLEARSCREEN					
P2_WON0				BL	P2WON
				LDR	R0,=APINT
				LDR	R1,[R0]
				ORR	R1, #0x4
				STR	R1,[R0]
				B	reset
				END
