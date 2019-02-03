;LABEL			DIRECTIVE	VALUE			COMMENT
			EXTERN 	 	InChar
			EXTERN 		OutChar
			EXTERN		OutStr
			EXPORT 		__main
			EXTERN 		CONVRT
NUM  	    		EQU     	0x20000600
			AREA 		main, READONLY, CODE
				
__main	
			LDR 		R2, =0x20000400
			MOV		R1, #0x04  		; counter, one ASCII character takes 1 byte
loop			BL		InChar     		; waits for the input
			STRB		R5,[R2], #-0x01 	; stores input to the address in R2
			SUBS		R1, #0x01		; decrement counter
			BNE 		loop
			ADD 		R2, #0x01		; correct the address
			LDRH		R4, [R2]		; load half word to R4
			LDR		R5,=NUM			; R5 address to converting loc.
			BL              CONVRT			; make convert
			BL		OutStr			; print it
Forever			B 		Forever
			END
