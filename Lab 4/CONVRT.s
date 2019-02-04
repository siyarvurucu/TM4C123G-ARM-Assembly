			; HEX TO DEC converter. Pass the hex in R4, location in R5
			
			AREA    	routines, READONLY, CODE, ALIGN=2
			THUMB
			EXPORT 		CONVRT	;
CONVRT 		
			PUSH	   	{R0-R4}
			MOV		R0, #10              ; Decimal
			
Loop			UDIV 		R1, R4, R0		 ;  We divide our number by ten and save quotient to R1
			MLS 		R2, R1, R0, R4  	 ; 	From quotient, we calculate the remainder, save it to R2
			ADD		R2, #0x30		 ;  R2 is our decimal digit, we add 0x30 to make it ASCII char. for digit
			STRB   		R2, [R5], #-1		 ;  Storing it to R5, decrementing R5. OutStr reads by incrementing so our LSB will be at last register.
			MOV 		R4, R1			 ;  Now quotient replaces our original number.
			CMP 		R1, #0			 ;  If it is zero, that means we just saved the last digit.
			BNE		Loop
			ADD		R5, #1			 ;  Correcting the address in R5
			POP		{R0-R4}
			BX		LR
			
			
			ALIGN                           
			END                             
