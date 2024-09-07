; Title		:	SVC Test Program
; Name		:	Ashutosh Rajendra Karve
; Bits ID	:	2024ht01021

		AREA RESET, CODE, READONLY
		EXPORT __Vectors
__Vectors
	DCD	0x20001000,Reset_Handler+1,0,0,0,0,0,0,0,0,0,SVC_handler+1,0,0,0,0,0,0,0,0,0,0,0
		
		AREA mycode, CODE, READONLY
		ENTRY
		EXPORT	Reset_Handler
Reset_Handler
		LDR R1,=0x20000200
		MSR	PSP,R1
		
		MOV	R0,#3
		MSR	CONTROL,R0
		
		LDR R7,=SRC
		LDR R1,[R7],#4
		LDR R2,[R7]
		LDR	R8,=DST
		SVC 250
STOP	B	STOP

SVC_handler
		push{lr}
		; Write logic here
		
		pop{pc}
		
SRC	DCD	0x30,0x20
	
		AREA RES, DATA, READWRITE
DST	DCD 0,0
	END