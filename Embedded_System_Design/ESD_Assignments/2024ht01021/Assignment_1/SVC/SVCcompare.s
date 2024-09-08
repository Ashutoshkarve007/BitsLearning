; TITLE 		: Assignment Solution : Q.3
; NAME			: ASHUTOSH RAJENDRA KARVE
; BITS_ID		: 2024ht01021
; DATE			: 08/09/2024
; PLACE			: PUNE

		AREA RESET, CODE, READONLY
		EXPORT __Vectors
__Vectors
	DCD 0x20001000, Reset_Handler+1,0,0,0,0,0,0,0,0,0,SVC_handler+1,0,0,0,0,0,0,0,0,0,0,0
		
		AREA mycode,CODE, READONLY
		ENTRY
		EXPORT Reset_Handler
			
Reset_Handler
		LDR	R1,=0x20000200
		MSR	PSP,R1
		
		MOV	R0, #3
		MSR CONTROL, R0
		
		LDR	R7,=SRC
		LDR	R1,[R7],#4
		LDR R2,[R7]
		LDR	R8,=DST					; Address to store the result
		SVC	21                      ; svc number is 21 as last 2 digit of BITS ID (01021)
STOP	B STOP

SVC_handler
		PUSH {lr}               ; Save the link register
		MRS R3, CONTROL         ; Get current control value
		CMP R3, #3              ; Check if it's in unprivileged mode
		BEQ handle_svc

handle_svc
		LDR R0, [R7]            ; Load first parameter into R0
		LDR R1, [R7, #4]        ; Load second parameter into R1

		LDRB R2, [lr, #-2]      ; Load the SVC number from the instruction
		CMP R2, #21             ; Check if SVC number matches 21
		BEQ add_params          ; If match, perform addition

subtract_params
		SUB R0, R0, R1          ; If not, subtract parameters
		STR R0, [R8]            ; Store the result in DST
		B return_from_svc

add_params
		ADD R0, R0, R1          ; Add the parameters
		STR R0, [R8]            ; Store the result in DST

return_from_svc
		POP {pc}                ; Return from the handler
		
SRC	DCD	1021, 1021
	
	AREA RESS, DATA, READWRITE
DST DCD 0, 0
	END