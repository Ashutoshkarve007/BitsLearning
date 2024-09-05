; ALP FOR ADDITION OF 32-BIT
; NAME: Ashutosh.R.Karve
; Roll No: 01021

		AREA RESET, CODE, READONLY
		ENTRY		
		MSR CPSR_C, #0x10 ;to switch in user mode, if you want to move in user mode // use instruction as MSR 
		LDR R4, =src1   ; Load the address of src in R4 reg
		LDR R1, [R4], #4  ; Loading num1 in R1 , Post Indexing
		LDR R2, [R4], #4  ; Loading num2 in R2 , Post Indexing
		
		ADD R0, R1, R2        ; R0 = R1 + R2
		
		LDR R5, =sum		  ; Loading the address of sum into R5
		STR R0, [R5]          ; Store the result on memory
		;MSR CPSR_C, #0xD3	;to switch in user mode // test
		
stop B stop
		
		
src	DCD 0xF0000000, 0x10001000, 0x30303030	; Constants in code memory
	
		AREA MYDATA, DATA, READWRITE
src1	DCD 0xF0000000, 0x10001000, 0x30303030
sum			DCD			0x11				;Variable declaration   //DCD for 32 bits 

		END