GPIO_PORTB_DATA 	EQU 	0x400053FC ; data address to all pins 2 
GPIO_PORTB_DIR 		EQU 	0x40005400 
GPIO_PORTB_AFSEL 	EQU 	0x40005420 
GPIO_PORTB_DEN 		EQU 	0x4000551C
GPIO_PORTB_PUR		EQU		0x40005510
IOB 				EQU 	0xF0 	
SYSCTL_RCGCGPIO 	EQU 	0x400FE608 
PBinput				EQU		0x4000503C
PBoutput			EQU		0x400053C0

	
					AREA   	main, READONLY, CODE, ALIGN=2 
					THUMB 
					EXPORT 	__main
					EXTERN	DELAY100
					EXTERN	OutStr
					EXTERN	OutChar
					EXTERN	CONVRT
__main				
					LDR		R5,=0x20000600
					LDR 	R1, =SYSCTL_RCGCGPIO 
										
					LDR 	R0, [R1] 
					ORR 	R0, R0, #0x12 
					STR 	R0, [R1] 
					NOP 
					NOP 
					NOP 							; let GPIO clock stabilize 
									
					LDR	 	R1, =GPIO_PORTB_DIR 	; config . of port B starts 
					LDR 	R0, [R1] 
					BIC 	R0, #0xFF 				; R0 = 0
					ORR 	R0, #IOB 				; or with 11110000	
					STR 	R0, [R1] 
					LDR 	R1, =GPIO_PORTB_AFSEL   ;make pin functions controlled by gpio registers
					LDR 	R0, [R1] 				
					BIC 	R0, #0xFF 			
					STR 	R0, [R1] 				;
					LDR 	R1, =GPIO_PORTB_DEN 
					LDR 	R0, [R1] 
					ORR 	R0, #0xFF 
					STR 	R0, [R1] 				; config . of port B ends
					LDR		R1,	=GPIO_PORTB_PUR
					LDR		R0, [R1]
					ORR		R0, #0x0F
					STR		R0, [R1]
					LDR		R1, =GPIO_PORTB_DATA

loop				LDR		R0,[R1]
					CMP		R0,#0x0F
					BEQ		loop
					CMP		R0,#0x0E
					BEQ		firstcolumn
					CMP		R0,#0x0D
					BEQ		secondcolumn
					CMP 	R0,#0x0B
					BEQ		thirdcolumn
					CMP		R0,#0x07
					BEQ.W	fourthcolumn
					
					B		loop
					
firstcolumn			MOV		R0,#0xE0
					STR		R0,[R1]
					BL		DELAY100
					LDR		R0,[R1]
					CMP		R0,#0xEE
					ITT		EQ
					MOVEQ	R4,#0x01
					BEQ		print
					
					MOV		R0,#0xD0
					STR 	R0,[R1]
					BL 		DELAY100
					LDR		R0,[R1]
					CMP		R0,#0xDE
					ITT		EQ
					MOVEQ	R4,#0x05
					BEQ		print
					
					MOV		R0,#0xB0
					STR 	R0,[R1]
					BL 		DELAY100
					LDR		R0,[R1]
					CMP		R0,#0xBE
					ITT		EQ
					MOVEQ	R4,#0x09
					BEQ		print
					
					MOV		R0,#0x70
					STR 	R0,[R1]
					BL 		DELAY100
					LDR		R0,[R1]
					CMP		R0,#0x7E
					ITT		EQ
					MOVEQ	R4,#0x0D
					BEQ		print
	
					LDR		R0,=0x00
					STR		R0,[R1]			
					B 		loop
					
secondcolumn		MOV		R0,#0xE0
					STR		R0,[R1]
					BL		DELAY100
					LDR		R0,[R1]
					CMP		R0,#0xED
					IT		EQ
					MOVEQ	R4,#0x02
					BEQ		print
					
					MOV		R0,#0xD0
					STR 	R0,[R1]
					BL 		DELAY100
					LDR		R0,[R1]
					CMP		R0,#0xDD
					ITT		EQ
					MOVEQ	R4,#0x06
					BEQ		print
					
					
					MOV		R0,#0xB0
					STR 	R0,[R1]
					BL 		DELAY100
					LDR		R0,[R1]
					CMP		R0,#0xBD
					ITT		EQ
					MOVEQ	R4,#0x0A
					BEQ		print
					
					
					MOV		R0,#0x70
					STR 	R0,[R1]
					BL 		DELAY100
					LDR		R0,[R1]
					CMP		R0,#0x7D
					ITT		EQ
					MOVEQ	R4,#0x0E
					BEQ		print
					
					LDR		R0,=0x00
					STR		R0,[R1]
					
					B 		loop
					
thirdcolumn			MOV		R0,#0xE0
					STR		R0,[R1]
					BL		DELAY100
					LDR		R0,[R1]
					CMP		R0,#0xEB
					ITT		EQ
					MOVEQ	R4,#0x03
					BEQ		print
					
					MOV		R0,#0xD0
					STR 	R0,[R1]
					BL 		DELAY100
					LDR		R0,[R1]
					CMP		R0,#0xDB
					ITT		EQ
					MOVEQ	R4,#0x07
					BEQ		print
					
					
					MOV		R0,#0xB0
					STR 	R0,[R1]
					BL 		DELAY100
					LDR		R0,[R1]
					CMP		R0,#0xBB
					ITT		EQ
					MOVEQ	R4,#0x0B
					BEQ		print
					
					
					MOV		R0,#0x70
					STR 	R0,[R1]
					BL 		DELAY100
					LDR		R0,[R1]
					CMP		R0,#0x7B
					ITT		EQ
					MOVEQ	R4,#0x0F
					BEQ		print
					
					LDR		R0,=0x00
					STR		R0,[R1]
					B 		loop		
fourthcolumn		MOV		R0,#0xE0
					STR		R0,[R1]
					BL		DELAY100
					LDR		R0,[R1]
					CMP		R0,#0xE7
					ITT		EQ
					MOVEQ	R4,#0x04
					BEQ		print
					
					MOV		R0,#0xD0
					STR 	R0,[R1]
					BL 		DELAY100
					LDR		R0,[R1]
					CMP		R0,#0xD7
					ITT		EQ
					MOVEQ	R4,#0x08
					BEQ		print
					
					MOV		R0,#0xB0
					STR 	R0,[R1]
					BL 		DELAY100
					LDR		R0,[R1]
					CMP		R0,#0xB7
					ITT		EQ
					MOVEQ	R4,#0x0C
					BEQ		print
					
					
					MOV		R0,#0x70
					STR 	R0,[R1]
					BL 		DELAY100
					LDR		R0,[R1]
					CMP		R0,#0x77
					ITT		EQ
					MOVEQ	R4,#0x010
					BEQ		print
					
					LDR		R0,=0x00
					STR		R0,[R1]
					
					B 		loop
					
print				BL		CONVRT
					BL		OutStr
					LDR		R0,=0x00
					STR		R0,[R1]
					B		loop
					
					END
					
					


							
