		  AREA 		Routines, READONLY, CODE
          THUMB
		  EXPORT COUNTERINIT
			  
COUNTERINIT	  
			LDR	R1, =0xE000E000		; Systick Timer
			MOV	R2, #0
			STR	R2, [R1,#16]		; Enable initialized to zero
			LDR	R2, =0x3D08FF		; = 399999 clock cycles
			STR	R2, [R1,#20]		; Reload Value Register is set to number of clock cycles that counter will start from.
			MOV	R2, #0x3
			STR	R2, [R1,#16]		; Enable is set 1 to start the counter
			BX  LR