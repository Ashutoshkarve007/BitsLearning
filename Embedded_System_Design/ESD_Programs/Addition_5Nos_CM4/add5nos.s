; Title : Addition of 5 Numbers
; Name  : Ashutosh Rajendra Karve
; ID	: 2024ht01021

			AREA	RESET, CODE, READONLY
			EXPORT __Vectors
__Vectors
			DCD		0x20001000		; Stack Pointer value when stack is empty
			DCD		Reset_Handler+1	; reset vector
				
			AREA mycode, CODE, READONLY
			ENTRY
			EXPORT Reset_Handler
Reset_Handler
			MOV	R0,#0		; Sum = 0;
			MOV R1,#4		; Number of elements - 1
			ADR	R2, ARRAY_A	; Start of Array
LOOP
			LDR	R3,[R2,R1,LSL #2]		;	Load value from memory
			ADD	R0,R3,R0				;	sum+=a[i]
			SUBS	R1,R1,#1			;	i=i-1
			BGE	LOOP					;	loop only if i > 0
STOP		B	STOP

ARRAY_A		DCD	1,2,3,4,5
			END