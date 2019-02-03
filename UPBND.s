			; boundary update for number guessing. Pass N for 2^N upperbound, in R3
			
			AREA    	routines, READONLY, CODE, ALIGN=2
			THUMB
			EXPORT 		UPBND
			EXTERN		OutStr
			EXTERN		CONVRT
			EXTERN 		InChar


UPBND		
			SUB			R3, #0x01       ; n = n-1
			MOV			R2, #0x01		; 2^0 , to be shifted accordingly
			LSL			R2 , R2, R3     ; 2^R3
			ADD			R4, R2		    ; guessed number generated in R4
			BL 			CONVRT			; converted to decimal ascii
			BL			OutStr			; printed to screen
			BL			InChar			; waiting for input
			CMP 		R5, #0x043		; C
			BEQ			found
			CMP			R5, #0x055		; Up
			BEQ			UPBND			;
			CMP 		R5, #0x044		; Down
			ITT			EQ	
			SUBEQ		R4, R4, R2		;
			BEQ			UPBND	
			B			error
found									; found state
			MOV			R1, R4
			BL			OutStr
			BX			LR
error		B			error
			
			END