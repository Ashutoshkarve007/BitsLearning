; Title   : Addition of num
; Name    : Ashutosh Rajendra Karve
; Bits-ID : 2024ht01021

varB		EQU		2
varC		EQU		4
varD		EQU		6
		AREA RESET, CODE, READONLY
		EXPORT __Vectors
__Vectors
		DCD 0x20001000		; Stack pointer value when stack is empty
		DCD Reset_Handler+1	; reset vector
			
		AREA mycode, CODE, READONLY
		ENTRY
		EXPORT Reset_Handler
Reset_Handler
		MOV		R1,#varB
		MOV		R2,#varC
		MOV		R3,#varD
		
		ADD 	R0,R1,R2
		ADD		R0,R0,R3
Stop	B		Stop
		END