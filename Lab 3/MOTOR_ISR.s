				AREA   	init_isr, CODE,READONLY, ALIGN=2
				EXPORT 	GPIOB_HANDLER
				EXTERN  DELAY100
GPIO_PORTB_ICR			EQU		0x4000541C
GPIO_PORTB_MIS			EQU		0x40005418
GPIOB_HANDLER			PROC
				PUSH		{LR}	
				BL		DELAY100
				LDR 		R1,=GPIO_PORTB_MIS	; interrupt source?
				LDR		R0,[R1]
				CMP		R0,#0x010		; slow down 0001
				LSLEQ		R6,#0x01	
				CMP		R0,#0x020		; speed up 0010
				LSREQ		R6,#0x01		
				CMP		R0,#0x040		; left	0100
				MOVEQ		R11,#0x00	
				CMP		R0,#0x080		; right	1000
				MOVEQ		R11,#0x01		
				LDR 		R1,=GPIO_PORTB_ICR	; clear flags
				MOV		R0,#0xFF		
				STR		R0,[R1]
				POP		{LR}
				BX		LR
				ENDP
				END
