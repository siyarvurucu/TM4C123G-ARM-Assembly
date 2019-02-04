SSIDR					EQU		0x40008008
SSICISR					EQU		0x4000800C
						
						AREA 	Routines, READONLY, CODE
						EXPORT 	WRITE

WRITE					PUSH 	{R0-R2}
Check0					LDR  	R0, =SSICISR			; Check if fifo is full or not
						LDR  	R1, [R0]
						AND 	R1, #0x2
						CMP 	R1, #0					; if full -> wait
						BEQ		Check0					; else continue
					
Check1					LDR  	R0, =SSICISR			; Check if fifo is busy 
						LDR  	R1, [R0]
						AND 	R1, #0x10
						CMP 	R1, #0					; if busy -> wait
						BNE	 	Check1					; else continue
						
						LDR  	R0, =SSIDR				; write the data, to be transmitted, to fifo
						STRB 	R2, [R0]
						
Check2					LDR  	R0, =SSICISR			; wait until transmission is done
						LDR  	R1, [R0]	
						ANDS 	R1, #0x10
						BNE	 	Check2	

						POP 	{R0-R2}
						BX 		LR