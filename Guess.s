;LABEL			DIRECTIVE	VALUE			COMMENT
			EXTERN 	 	InChar
			EXTERN 		OutChar
			EXTERN		OutStr
			EXPORT 		__main
			EXTERN 		CONVRT
			AREA 		main, READONLY, CODE
				
__main	
			BL 		InChar
			SUB		R5, #0x030		; hex to dec msb
			MOV		R3, #0x0A	        ; 10
			MUL		R3, R5 , R3		;
			BL		InChar
			SUB		R5, #0x030		; hex to dec lsb
			ADD 		R3, R3, R5		; two digit decimal created, R3 holds N
			CMP 		R3, #0x020 	 	; N should be less than 32
			BHS		error
			LDR 		R1, =0x00000000 	; holds base number
			B		func
			
func		
			SUB		R3, #0x01      	 	; n = n-1
			MOV		R2, #0x01		; 2^0 , to be shifted accordingly
			LSL		R2 , R2, R3     	; 2^R3
			ADD		R4, R2		        ; guessed number generated in R4
			LDR		R5, =0x20000600		; provide location for CONVRT
			BL 		CONVRT			; converted to decimal ascii
			BL		OutStr			; printed to screen
			BL		InChar			; waiting for input
			CMP 		R5, #0x043		; C
			BEQ		found
			CMP		R5, #0x055		; Up
			BEQ		func			
			CMP 		R5, #0x044		; Down
			ITT		EQ	
			SUBEQ		R4, R4, R2		;
			BEQ		func	
			B		error
found								
			BL		CONVRT
forever			B		forever

error 	   		B		error
		   
		   	END
