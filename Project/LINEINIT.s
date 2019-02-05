MEMORY_ADDRESS		EQU 		   0x20000100
			AREA 	routines, CODE, READONLY
			THUMB
			EXTERN	WRITE
			EXTERN	WRITESCREEN	
			EXPORT 	LINEINIT
				
LINEINIT		PUSH 	 {R0,R1,R2,LR}
			
			MOV	 R0, #5			; Upper area of the border
			
UP0			MOV  	 R2, #0x00
           		BL  	 WRITE
			SUBS 	 R0, #1
			BNE 	 UP0
			MOV	 R0, #66
			
UP1			MOV 	 R2, #0x80
            		BL  	 WRITE
			SUBS 	 R0, #1
			BNE  	 UP1			
			MOV	 R0, #13
			
UP2			MOV 	 R2, #0x00
           	 	BL   	 WRITE
			SUBS  	 R0, #1
			BNE  	 UP2
			MOV  	 R1, #4			; Middle area of the border
			
MIDDLE	    		MOV	 R0, #5
MID0			MOV  	 R2, #0x00
            		BL   	 WRITE
			SUBS 	 R0, #1
			BNE  	 MID0						
			MOV  	 R2, #0xFF
			BL	 WRITE
			MOV	 R0, #64
			
MID1			MOV  	 R2, #0x00
            		BL  	 WRITE
			SUBS 	 R0, #1
			BNE 	 MID1	
			MOV 	 R2, #0xFF
			BL	 WRITE
			MOV	 R0, #13
			
MID2			MOV  	 R2, #0x00
            		BL   	 WRITE
			SUBS 	 R0, #1
			BNE  	 MID2
			SUBS	 R1, #1
			BNE  	 MIDDLE
			

			MOV	 R0, #5			; Lower area of the border
LOW0			MOV  	 R2, #0x00
            		BL  	 WRITE
			SUBS 	 R0, #1
			BNE  	 LOW0 			
			MOV	 R0, #66
LOW1			MOV  	 R2, #0x01
           		BL   	 WRITE
			SUBS 	 R0, #1
			BNE  	 LOW1				
			MOV	 R0, #13
LOW2			MOV  	 R2, #0x00
            		BL   	 WRITE
			SUBS 	 R0, #1
			BNE  	 LOW2
			
			POP  	{R0,R1,R2,LR}
			BX	 LR
			END
