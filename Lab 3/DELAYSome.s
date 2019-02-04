;LABEL		DIRECTIVE	VALUE			COMMENT
			EXPORT 		DELAYSome
			AREA 		routines, READONLY, CODE
				
DELAYSome	PUSH 		{R1}
			MOV			R1,#0x00
			CMP			R6,#0x00
			MOV32LE		R6,#0x0000F000
			CMP			R6,#0x00F00000
			MOV32HI		R6,#0x00F00000
			ADD			R1,R1,R6
loop		SUBS		R1,#0x01
			CMP 		R1,#0x00
			BNE			loop
			POP			{R1}
			BX			LR
					
			END