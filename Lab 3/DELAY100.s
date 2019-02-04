;LABEL		DIRECTIVE	VALUE			COMMENT
			EXPORT 		DELAY100
			AREA 		routines, READONLY, CODE
				
DELAY100	PUSH 		{R1}
			LDR			R1,=410858
loop		SUBS		R1,#0x01
			CMP 		R1,#0x00
			BNE			loop
			POP			{R1}
			BX			LR
					
			END