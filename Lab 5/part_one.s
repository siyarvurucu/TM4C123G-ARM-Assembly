			AREA 	routines, CODE, READONLY
			THUMB
			EXPORT 	part_one
			EXTERN 	OutStr
			EXTERN	CONVRT
				
part_one	PUSH	{LR}
			BL 		CONVRT		
			BL		OutStr
			POP		{LR}
			BX		LR
			END