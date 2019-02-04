; Reads ascii from UART, converts to hex number, stored in register R5

;LABEL		DIRECTIVE	VALUE		COMMENT
		EXTERN 	 	InChar
		EXPORT 		asciitonumber
		EXTERN 		CONVRT
NUM_Addr    	EQU     	0x20000600
		AREA 		routines, READONLY, CODE
				
				
asciitonumber	PUSH		{LR}
		PUSH		{R0-R4}
		MOV		R3,#0x0A
		MOV		R2,#0x00
		MOV		R1,#0x00	;counter
		LDR		R0,=NUM_Addr
loop		BL		InChar
		CMP 		R5,#0x020	; If input char is space, sequence ended, start convert
		ITT		EQ
		MOVEQ		R5,#0x00
		BEQ 		convert
		SUB		R5,#0x030
		STRB		R5,[R0],#-0x01
		ADD 		R1,#0x01
		B		loop
			
convert 			
		LDRB		R2,[R0,R1]
		SUBS		R1,#0x01
		BEQ		fin
		ADD		R5,R2
		MUL		R5,R3
		B		go
fin			
		ADD		R5, R2

		POP		{R0-R4}
		POP		{LR}
		BX 		LR
			
		END
