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
		LDR R1, =0x20000200
		MSR PSP, R1

		MOV R0, #3
		MSR CONTROL, R0
		LDR R7, =SRC
		LDR R1, [R7]                 ; Load first parameter (1021)
		LDR R2, [R7, #4]             ; Load second parameter (1021)
		LDR R8, =DST
    
		SVC 21                       ; SVC call with number 21
STOP    B STOP


SVC_handler
		PUSH {lr}
		TST LR, #4
		ITE EQ
		MRSEQ R0, MSP
		MRSNE R0, PSP

		LDR R1, [R0, #24]            ; Load the return address
		LDRB R1, [R1, #-2]           ; Extract SVC number

		CMP R1, #21                  ; Compare SVC number with 21
		BNE Subtract               ; If not 21, go to Subtract

		; If SVC number matches, perform addition
		ADD R0, R1, R2              ; R0 = R1 + R2
		STR R0, [R8]                ; Store result in DST
		B EndSVC                    ; End of SVC handler

Subtract
		; If SVC number does not match, perform subtraction
		SUB R0, R1, R2              ; R0 = R1 - R2
		STR R0, [R8]                ; Store result in DST

EndSVC
		POP {pc}

; Data Section
SRC	DCD 1021, 1021           ; Parameters (last 5 digits of BITS ID)
DST	DCD 0                    ; Destination to store the result

		AREA RES, DATA, READWRITE
		END
