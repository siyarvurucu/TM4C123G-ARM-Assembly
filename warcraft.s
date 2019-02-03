;LABEL		DIRECTIVE	VALUE		COMMENT
			EXTERN		chartodec
			EXTERN		OutStr
			EXPORT 		__main
			EXTERN 		CONVRT
			AREA 		main, READONLY, CODE
NUM			EQU			0x20000600

				
__main		BL 			chartodec		; take input, value in R5, decimal digits in NUM
			MOV			R1,R5			; R1 soulstones(SS) we have 
			MOV			R0,#0xffffffff	; minimum number of soulstones
			MOV			R7,#0x07		; modulo7 for portal 4
			MOV			R8,#0x03		; modulo3 for portal 4
			LDR 		R5,=NUM
			BL			func			; start
			B			guldanissad  	; minimum is found
			
func		
			CMP			R1,R0			; replace the minimum 
			IT			LO
			MOVLO		R0,R1
			CMP			R0,#0x00		; if it is zero, go celebrate
			BXEQ		LR
			PUSH		{LR}			

			
			CMP			R1,#99			; greater than 99?
			BLHI		P1				; goto Portal 1
			
			CMP			R1,#50			; greater than 50?		
			IT			HI
			TSTHI  		R1,#1			; is it odd?
			BLHI		P2				; goto Portal 2
			
			TST         R1,#1			; is it even?
			BLEQ		P3				; goto P3
			
			UDIV		R2,R1,R7		; divide by 7
			MLS			R3,R2,R7,R1		; remainder in R3
			CMP			R3,#0x00		; is it 7k?	
			BLEQ		P4				; goto Portal 4
			
		
			POP			{LR}			; end of a subtree
			BX			LR
			
										

P1  		PUSH		{LR}			
			PUSH		{R1}			
			SUB		    R1,#47			; -47 from portal 1
			BL			func			; new subtree begins when func called
			POP			{R1}
			POP			{LR}
			BX 			LR
		
P2			PUSH		{LR}
			PUSH 		{R1}
			MOV 		R4,R1			; load to r4 for CONVRT
			BL			CONVRT
			MOV			R3,#1			; odd numbers will multiply and accumulate in R3
loop
			LDRB		R2,[R5],#1		; load digit
			SUB			R2,R2,#0x030	; ascii to digit
			TST			R2,#1			; is digit odd?
			MULNE		R3,R3,R2		; if yes, multiply
			LDRB		R2,[R5]			; check next digit
			CMP			R2,#0x04		; end of digits?
			BNE			loop			
			SUB			R1,R3			; 53-5*3, SS update
			BL			func			
			POP			{R1}
			POP			{LR}
			BX 			LR

P3			PUSH		{LR}			; Portal 3
			PUSH        {R1}
			MOV			R1,R1, LSR #1	; divide by 2
			BL			func
			POP			{R1}
			POP			{LR}
			BX 			LR
			
P4			PUSH		{LR}			; Portal 4
			PUSH 		{R1}
			UDIV		R2,R1,R8		; subtract largest 3k
			MLS			R1,R2,R8,R1		; remainder is new SS
			BL			func
			POP			{R1}
			POP			{LR}
			BX 			LR
			
guldanissad		
			MOV			R4,R0
			BL			CONVRT
			BL			OutStr
			B 			__main
			END