
			AREA 	main , CODE, READONLY
			THUMB
			EXPORT 	rotateleft
			EXTERN  DELAYSome
			EXTERN	rotateright
GPIO_PORTB_DATA 	EQU 	0x400053FC
rotateleft 	
			LDR 	R1, =GPIO_PORTB_DATA

loop		CMP 	R11,#0x01
			BEQ		rotateright
			MOV  	R0, #0x08	; 1000
			STR  	R0, [R1]
			BL		DELAYSome
			LSR 	R0,#0x01	; 0100 
			STR  	R0, [R1]
			BL		DELAYSome
			LSR 	R0,#0x01	; 0010
			STR  	R0, [R1]
			BL		DELAYSome
			LSR 	R0,#0x01	; 0001
			STR  	R0, [R1]
			BL		DELAYSome
			B 		loop
			END
