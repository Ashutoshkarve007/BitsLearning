; TITLE      : Assignment 1 count the number of 0’s and 1’s in the last 5 digits of your BITS ID 
; NAME       : ASHUTOSH RAJENDRA KARVE
; BITS-ID    : 2024ht01021
; DATE       : 07/09/2024
; PLACE      : PUNE

        AREA RESET, CODE, READONLY
        ENTRY

START
        LDR R4, =SRC            ; Load the address of the BITS ID (01021)
        LDR R5, [R4]           ; Load the value (01021) into R5
        LDR R6, =DST            ; Load the address of DST to store results
        BL SUB1                ; Call the SUB1 function to count 0's and 1's
STOP	B STOP

SUB1    MOV R0, #0             ; Initialize R0 to store the count of 0's
        MOV R1, #0             ; Initialize R1 to store the count of 1's
        MOV R3, #10            ; Set loop counter for 10 bits (last 5 digits of the BITS ID)

LOOP    
        TST R5, #1             ; Test if the least significant bit is 1
        BEQ COUNT_ZERO         ; If the bit is 0, branch to COUNT_ZERO
        ADD R1, R1, #1         ; Increment R1 (count of 1's)
        B NEXT_BIT             ; Jump to NEXT_BIT

COUNT_ZERO
        ADD R0, R0, #1         ; Increment R0 (count of 0's)

NEXT_BIT
        LSR R5, R5, #1         ; Logical shift right to check the next bit
        SUBS R3, R3, #1        ; Decrement the bit counter
        BNE LOOP               ; If R3 is not zero, repeat the loop

        STR R0, [R6]           ; Store the count of 0's in DST[0]
        STR R1, [R6, #4]       ; Store the count of 1's in DST[1]

        BX LR                  ; Return from the function

SRC     DCD 1021               ; Define the BITS ID value (01021) in decimal
        AREA RESULT, DATA, READWRITE
DST     DCD 0,0
        END
