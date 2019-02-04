			AREA 	routines, CODE, READONLY
			THUMB
			EXPORT 	part_two
			EXTERN 	OutStr
			EXTERN	CONVRT_exp5
part_two
			PUSH	{LR}
			BL 		CONVRT_exp5
			BL		OutStr
			POP		{LR}
			BX		LR