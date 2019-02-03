			EXTERN		OutStr
			EXPORT 		__main
			EXTERN 		CONVRT
			EXTERN 	 	InChar
NUM			EQU		0x20000500
			AREA 		main, READONLY, CODE
				
__main			BL		InChar
			LDR		R5,=NUM
			LDR		R4,[R5]
			LDR		R5,=0x20000600
			BL		CONVRT
			BL		OutStr
			
			END
			
