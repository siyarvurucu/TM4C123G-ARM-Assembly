			AREA 	routines, CODE, READONLY
			THUMB
			EXPORT 	part_three
			EXTERN 	OutStr
			EXTERN	CONVRT_exp5
			EXTERN	part_two
				
part_three	PUSH	{R2,R3,R4,LR}
			SUB		R3,R4,R10
			SUBS 	R2,R3,R9
			BLO		lower
			ADDS	R2,R3,R9
			BHI		lower
			BL		part_two
			ADD		R10,R4,#0X0
lower	
			POP		{R2,R3,R4,LR}
			BX		LR
			