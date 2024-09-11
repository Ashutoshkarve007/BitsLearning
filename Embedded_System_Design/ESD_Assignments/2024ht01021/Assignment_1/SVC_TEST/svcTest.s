		AREA  RESET, CODE, READONLY
        EXPORT  __Vectors
__Vectors 
        DCD  0x20001000, Reset_Handler+1, 0, 0, 0, 0, 0, 0, 0, 0, 0, SVC_Handler+1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    
 
        AREA mycode, CODE, READONLY    
        ENTRY
        EXPORT  Reset_Handler
Reset_Handler
        LDR R1, =0x20000200
        MSR PSP, R1
 
        MOV R0, #3
        MSR CONTROL, R0
        LDR R7, =SRC
        LDR R1, [R7], #4
        LDR R2, [R7]
        LDR R8, =DST
        SVC 28  ; SVC number is 26 (last 2 digits of BITS ID)
 
STOP    B STOP
 
SVC_Handler 
        TST lr, #4
        ITE EQ
        MRSEQ R0, MSP
        MRSNE R0, PSP
        LDR R1, [R0, #24]  ; Get stacked PC
        LDRB R1, [R1, #-2] ; Get SVC number
        CMP R1, #26        ; Compare with SVC number 26
        BNE Subtract
        ADD R2, R0, #8     ; Point to first parameter
        LDR R3, [R2]
        LDR R4, [R2, #4]   ; Point to second parameter
        ADD R3, R3, R4     ; Perform addition
        B Done
 
Subtract
        ADD R2, R0, #8     ; Point to first parameter
        LDR R3, [R2]
        LDR R4, [R2, #4]   ; Point to second parameter
        SUB R3, R3, R4     ; Perform subtraction
 
Done
        STR R3, [R8]       ; Store result in DST
        BX lr
 
SRC     DCD 1026, 1026  ; Last 5 digits of BITS ID
 
        AREA RES, DATA, READWRITE
DST     DCD 0, 0
        END