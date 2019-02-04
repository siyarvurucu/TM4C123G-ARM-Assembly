
			AREA main , CODE, READONLY
			THUMB
			EXPORT 	__main
			EXTERN  gpioset
			EXTERN	rotateleft

__main 					
			BL 		gpioset				; I/O and interrupt registers set
			MOV32	R6,#0x000F0000		; DELAYSome amount
			CPSIE 	I 					; enable interrupts
			
			B 		rotateleft			; start with left
			END

