
;LABEL DIRECTIVE VALUE COMMENT
			AREA main , CODE, READONLY
			THUMB
			EXPORT 	rotateright
			EXTERN  DELAYSome	
			EXTERN	rotateleft
GPIO_PORTB_DATA 	EQU 	0x400053FC
rotateright 					
			LDR 	R1, =GPIO_PORTB_DATA
			
loop		CMP 	R11,#0x00			; left button pressed?
			BEQ		rotateleft
			MOV  	R0, #0x01			; first input 0001
			STR  	R0, [R1]
			BL		DELAYSome			; wait after first step
			LSL 	R0,#0x01			; shift to second input
			STR  	R0, [R1]			; 0010
			BL		DELAYSome			
			LSL 	R0,#0x01			
			STR  	R0, [R1]			; 0100
			BL		DELAYSome
			LSL 	R0,#0x01
			STR  	R0, [R1]			; 1000
			BL		DELAYSome
			B 		loop
			END