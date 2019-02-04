						AREA   	init_isr, CODE,READONLY, ALIGN=2
						EXPORT 	Button_Handler
						EXTERN	DELAY100
Y_Axis					EQU		0x20000410
X_Axis					EQU		0x20000414
STATES					EQU		0X20000450
AddressOfLastMine			EQU		0X20001500
OBJECTS_TYPE			EQU		0X2000045F
GPIO_PORTF_ICR			EQU		0x4002541C
GPIO_PORTF_MIS			EQU		0x40025418
GPIO_PORTF_IM			EQU		0x40025410
Button_Handler			PROC
						PUSH	{R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,LR}	
						BL		DELAY100
						LDR 	R0,=STATES
						LDR		R1,[R0]				; R1 holds state
						LDR		R3,=GPIO_PORTF_MIS
						LDR		R2,[R3]				; R7 holds which button is pressed
					
	
st0						CMP		R1,#0
						BNE		st1to4
						ADD		R1,#1
						STRB	R1,[R0]
						B		exit
						
st1to4					CMP		R1,#4
						BGT		st5
						
						; CHECK SHIP PLACEMENT START
						
						LDR		R3,=X_Axis		; Border check start
						LDR		R4,[R3]
						CMP		R4,#56			
						BGT		exit
						LDR		R3,=Y_Axis		
						LDR		R4,[R3]
						CMP		R4,#23			
						BGT		exit			; Border check ends
						CMP		R1,#1											
						BEQ		AddShip			; If first ship, add directly	
						ADD		R5,R1,#0			
											
prev_ship				SUB		R5,#1
						CMP		R5,#0
						BEQ		AddShip			; no ship left 
						LDR		R3,=OBJECTS_TYPE
						SUB		R3,R3,#2
						MOV		R0,#3
						MUL		R0,R5,R0
						ADD		R3,R3,R0
						LDRB	R0,[R3]			; R0 holds prev X
						LDR  	R4,=X_Axis
						LDRB	R1,[R4]			; R1 holds current X
						SUB		R0,R1,R0
						CMP		R0,#7
						BGT		prev_ship
						CMP		R0,#-7
						BLT		prev_ship
						ADD		R3,R3,#1
						LDRB	R0,[R3]			; R0 holds prev y
						LDR		R4,=Y_Axis
						LDRB	R1,[R4]			; R1 holds current y
						SUB		R0,R1,R0
						CMP		R0,#7
						BGT		prev_ship
						CMP		R0,#-7
						BLT		prev_ship
						B		exit
						
						; CHECK SHIP PLACEMENT END
						
AddShip					LDR 	R0,=STATES
						LDRB	R1,[R0]
						ADD		R3,R1,#1
						STRB	R3,[R0]
						LDR		R3,=OBJECTS_TYPE
						MOV		R0,#3
						MUL		R0,R1,R0
						ADD		R3,R3,R0
						CMP		R2,#0x10
						MOVEQ	R2,#0x2
						STRB	R2,[R3]
						B		exit
													
st5						CMP		R1,#5
						BNE		st6
						ADD		R1,#1
						STRB	R1,[R0]	  ; P1 last look
						B		exit
						
st6						CMP		R1,#6	  ; Screen Clear
						BNE		st7
						ADD		R1,#1
						STRB	R1,[R0]	  
						B		exit
						
st7						CMP		R1,#7	  ; 0.5 sec show
						BNE		st8
						B		exit	  ; this state handled by timer				

st8						CMP		R1,#13	  
						BGE		exit
						CMP		R2,#0x01
						BEQ		mine
						MOV		R1,#13
						STRB	R1,[R0]
						B		exit
mine					ADD		R1,#1			; Mine object is 3 Byte, X Y 3
						STRB	R1,[R0]
						LDR		R0,=AddressOfLastMine
						LDR		R2,[R0]
						MOV		R1,#3			; 3 means object is a mine
						STRB	R1,[R2,#2]
						LDR		R3,=X_Axis
						LDR		R1,[R3]
						STRB	R1,[R2]
						LDR		R3,=Y_Axis
						LDR		R1,[R3]
						STRB	R1,[R2,#1]
						ADD		R2,R2,#3
						STR		R2,[R0]
						B		exit
						
exit					LDR 	R1,=GPIO_PORTF_ICR	; clear flags
						MOV		R0,#0xFF		
						STR		R0,[R1]
						
						POP		{R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,LR}
						BX		LR
						ENDP
						END