ADCPSSI		EQU		0x40038028
ADCRIS		EQU		0x40038004
ADCSSFIFO3 	EQU		0x400380A8
ADCISC		EQU		0x4003800C
MEMORY		EQU		0X20000600	

			AREA 	main, CODE, READONLY
			THUMB

			EXTERN	pe3_adc0_set
			EXTERN	ADC0_set
			EXTERN	CONVRT
			EXTERN 	OutStr
			EXPORT  __main
			EXTERN	part_one
			EXTERN	part_two
			EXTERN	CONVRT_exp5
			EXTERN	part_three
__main		
			BL		pe3_adc0_set
			BL		ADC0_set

			LDR		R5,=0X20000601
			MOV		R0,#0X040A	; for writing
			STR		R0,[R5]
			
			LDR		R1,=ADCPSSI
			LDR		R2,=ADCSSFIFO3
			LDR		R3,=ADCISC
			LDR		R6,=ADCRIS
			LDR		R7,=0X0FFF  ; max adc value
			LDR		R8,=330		; represents 3.30 volt
			LDR		R9,=0X014   ; 20, for 0.2 volt check
			LDR		R10,=0X00	; previous sample
loop		MOV		R0,#0X08
			LDR		R5,=MEMORY
			STR		R0,[R1]     ; set bit 3 in ADCPSSI to take new sample
check		LDR		R0,[R6]	    ; raw interrupt?
			ANDS	R0,#0x08    ; check bit 3
			BEQ		check       ; check until ready
			
			LDR		R4,[R2]		; load value
			STR		R0,[R3]		; clear ISC
			MUL		R4,R4,R8	; 330 times measurement divided by FFF gives voltage
			UDIV	R4,R4,R7
			;BL 	part_one	; 
			;BL		part_two    ;
			BL		part_three
			B		loop
			END