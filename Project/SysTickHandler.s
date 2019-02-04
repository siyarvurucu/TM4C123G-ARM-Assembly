COUNTERVAL				EQU		0x20000700	
STATES					EQU		0x20000450
	
						
						AREA 	Routines, READONLY, CODE
						EXPORT	SysTickHandler
						
SysTickHandler			PUSH 	{R0,R1,R2,R3,R4,R5,R6,LR}						
						LDR		R0, =COUNTERVAL				; The number in memory is counted down
						LDR 	R6, [R0]
						SUB  	R6, #1
						STR  	R6, [R0]
						CMP  	R6, #0						; if counting is over
						BNE  	cont					
						LDR		R1, =0xE000E000				; Stop SysTick timer
						MOV		R2, #0
						STR		R2, [R1,#16]
						LDR 	R0, =STATES					; if the completed state is 7 (0.5sec) then next state is 8 (mine placing)
						LDR 	R1, [R0]		
						CMP 	R1, #7
						BNE 	cond
						MOV 	R1, #8
						STRB	R1, [R0]
						B		cont						; otherwise it is the completed part is mine placing, next state is 13 (end)					
cond					MOV 	R1, #13			
						STRB 	R1, [R0]
cont					POP 	{R0,R1,R2,R3,R4,R5,R6,LR}
						BX   	LR
						END