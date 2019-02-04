;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; SysTick ISR a r e a
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;LABEL DIRECTIVE VALUE COMMENT
			AREA   init_isr, CODE,READONLY, ALIGN=2
			EXPORT My_ST_ISR
My_ST_ISR 	PROC
			; your r o u ti n e
			
			BX LR ; r e t u r n
			ENDP
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
			