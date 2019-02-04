GPIO_PORTE_DATA		EQU 0x40024010 ; Access BIT2
GPIO_PORTE_DIR 		EQU 0x40024400 ; Port Direction
GPIO_PORTE_AFSEL	EQU 0x40024420 ; Alt Function enable
GPIO_PORTE_DEN 		EQU 0x4002451C ; Digital Enable
GPIO_PORTE_AMSEL 	EQU 0x40024528 ; Analog enable
GPIO_PORTE_PCTL 	EQU 0x4002452C ; Alternate Functions
	
SYSCTL_RCGCGPIO 	EQU 0x400FE608 ; GPIO Gate Control

					AREA 	routines, CODE, READONLY
					THUMB
					EXPORT 	pe3_adc0_set
						
pe3_adc0_set		PUSH	{R0-R1}
					LDR		R1,=SYSCTL_RCGCGPIO
					MOV		R0, #0X010		; port E
					STR		R0,[R1]
					
					LDR 	R1,=GPIO_PORTE_AFSEL
					MOV 	R0,#0X04		; AF select for pe3
					STR		R0,[R1]
					
					LDR 	R1,=GPIO_PORTE_DIR
					MOV		R0,#0x0			; input
					STR		R0,[R1]
					
					LDR 	R1,=GPIO_PORTE_AMSEL
					MOV 	R0,#0X04		; enable analog
					STR		R0,[R1]
					
					LDR 	R1,=GPIO_PORTE_DEN
					MOV		R0,#0X0
					STR		R0,[R1]
					
					POP		{R0-R1}
					BX		LR
					END