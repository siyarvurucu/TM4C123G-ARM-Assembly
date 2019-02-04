;PORTA BASE ADDRESS 0x40004000
GPIO_PORTA_DATA        EQU         0x400043FC
GPIO_PORTA_DIR         EQU         0x40004400
GPIO_PORTA_AFSEL       EQU         0x40004420
GPIO_PORTA_DEN         EQU         0x4000451C
GPIO_PORTA_PCTL        EQU     	   0x4000452C 
RCGCGPIO               EQU         0x400FE608
PCTL_DEFAULT           EQU         0x00202200 

SSICR0                 EQU         0x40008000
SSICR1                 EQU         0x40008004
SSICPSR                EQU         0x40008010
RCGCSSI                EQU         0x400FE61C
RCGCSSIWTF             EQU         0x400FE104




;LABEL 		DIRECTIVE	 VALUE	 COMMENT
			AREA		 routines, CODE, READONLY
			THUMB
			EXPORT		 PORTINIT


;LABEL 		DIRECTIVE	 VALUE	 	COMMENT
PORTINIT	PROC
			PUSH	{R0,R1,R2,LR}
			LDR 	R1,=RCGCGPIO ;Clock register
			LDR 	R0, [R1]
			ORR 	R0, #0x01 		;turn on clock 
			STR 	R0, [R1]
			NOP						;wait untill GPIO is ready
			NOP
			NOP
			
			LDR 	R1, =GPIO_PORTA_DEN
			MOV 	R0, #0xEC ; enable Port(2,3,5,6,7) as digital port
			STR 	R0, [R1]

			LDR		R1,=GPIO_PORTA_DIR
			LDR		R0,[R1]
			ORR		R0,R0,#0xEC			; THE 1'S ARE OUT
			STR		R0,[R1]

		
			
			LDR		R1, =GPIO_PORTA_DATA
			LDR		R0,[R1]
			ORR		R1,#0x80		;nokia reset
			STR		R1,[R0]
			
			LDR 	R1, =GPIO_PORTA_AFSEL ;disable affsel
			LDR		R0, [R1]
			ORR		R0, #0x2C			; configure clk, ce, tx
			STRB	R0,[R1]  
			
			LDR		R1,=GPIO_PORTA_PCTL
			LDR		R0,[R1]
			LDR		R2,=PCTL_DEFAULT
			ORR		R0,R2				; ptcl SSI0 config. (2,3,5)
			STR		R0,[R1]

;SPICONF
			LDR		R1, =RCGCSSI
			LDR		R0,[R1]
			ORR		R0,R0,#0x01		;enable SSI Module0 (datasheet 348)
			STR		R0,[R1]
			NOP						;wait for SSI peripheral to be ready
			NOP
			NOP
			NOP
			NOP
			NOP
			NOP
			
			
			LDR 	R1,=SSICR1		 
			LDR 	R0,[ R1 ]
			BIC		R0,#0x06				; SSI operaion disabled 
			STR		R0,[ R1 ] 	

			;LDR		R1, =SSICPSR
			;LDR		R0,[R1]
			;ORR		R0, R0, #0x10				;prescale
			;STR		R0,[R1]
			
			LDR		R1, =SSICR0
			LDR		R0,[R1]	
			MOV		R0, #0xC7		;clock/255 and 8bit  data
			STR		R0,[R1]
			
			LDR 		R1, =SSICR1		
			LDR			R0, [R1]
			ORR			R0, #0x02				; ssi enabled
			STR			R0, [R1]
			
			POP 	{R0,R1,R2,LR}
			
			BX		LR
			ENDP
			END