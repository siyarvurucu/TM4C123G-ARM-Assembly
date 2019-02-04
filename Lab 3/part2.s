;LABEL DIRECTIVE VALUE COMMENT
			AREA main , CODE, READONLY
			THUMB
			EXTERN 	InitSysTick 
			EXPORT 	__main
			EXTERN  DELAYSome
			EXTERN  gpioset
			EXTERN  DELAY100
			;EXTERN	GPIOB_HANDLER			
GPIO_PORTB_DATA 	EQU 	0x400053FC
__main 		
			LDR		R6,=0x00F00000	; time of output applied to driver
			BL 		gpioset
			; 0123 output 45 input
			LDR 	R1, =GPIO_PORTB_DATA
			MOV		R2,#0x01		; holds last step motor input
			MOV		R3,#0x00		; clearing output after a step

loop		LDR  	R0,[R1]
			CMP 	R0, #0x0D0		; right button?
			BLEQ	DELAY100
			CMP 	R0, #0x0D0
			BEQ		right
			CMP 	R0, #0x0E0		; left button?
			BLEQ	DELAY100		; debounce
			CMP 	R0, #0x0E0
			BEQ		left
			B		loop
right		LDR  	R0,[R1]
			CMP		R0,#0xF0	; button released?
			BNE		right
			LSL		R2,#0x01	; next right input
			CMP		R2,#0x0D0	; if 4th input is passed make it 0001
			IT		EQ			; 0001>0010>0100>1000>0001
			MOVEQ	R2,#0x01;
			STR		R2,[R1]
			BL		DELAYSome
			STR		R3,[R1]
			B 		loop
left		LDR  	R0,[R1]
			CMP		R0,#0xF0	; released?
			BNE		left
			LSR		R2,#0x01	; next left input
			CMP		R2,#0x00	; if 0 make it 1000
			IT		EQ
			MOVEQ	R2,#0x08;
			STR		R2,[R1]
			BL		DELAYSome
			STR		R3,[R1]
			
			B 		loop
			END