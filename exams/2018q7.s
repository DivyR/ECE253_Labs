.text
.global _start

_start:
        LDR SP, =0x0xFFFFFF00  // stack pointer
        LDR R2, =INPUT  // loading input
        MOV R3, #0  // current sum
        MOV R4, #0  // current position

CALCULATE:  // calculates the sum
        MUL R5, R4, #4  // amount of bytes the position is located
        LDR R6, [R2, R5]  // extract value from R3 position
        LSR R6, R6, #29 // shift to get 3-bit code
        CMP R6, #0b111  // end input
        B END  // break out of loop
        CMP R6, #0b000  // left parenthesis check
        BNE SKIP_PROCESS  // process the sum of the current brackets
        ADD R4, R4, #1  // increment beside left bracket
        MOV R0, #0  // reset to zero
        MOV R1, R4  // set to current position
        PUSH {RO, R1, R3, R4, R5, R6}
        B PROCESS
        POP {R0, R1, R3, R4, R5, R6}
        ADD R3, R3, R1  // update the sum
        MOV R4, R0  // update current position to right bracket
SKIP_PROCESS:
        ADD R4, R4, #1  // increment to next position
        B CALCULATE  // keep calculating

END: B END

INPUT:
        .word 0 0x8234BCA1 0x4111111 0x87654321 0x6111352F 0x12345678 0x2F00040 0xFFFFFFFF

PROCESS:
        POP {R0, R1}  // get local sum and position
        PUSH {LR}
        MUL R3, R1, #4  // get position in bytes
        LDR R4, [R2, R3]  // obtain value at position
        LSR R5, R4, #29  // 3-bit code
        CMP R5, #0b001  // right bracket, base case
        BNE TO_ADD
        // does equal
        PUSH {R0, R1}
RETURN:
        POP {LR}
        MOV PC, LR  // exit recurssion
TO_ADD:
        CMP R5, #0b010  // add symbol
        BNE TO_SUB
        // does equal
        MOV R6, #1  // positive factor
        PUSH {R0, R1}  // not required for this
        B PROCESS
TO_SUB:
        CMP R5, #0b011  // subtraction symbol
        BNE TO_VALUE
        MOV R6, #1  // negative factor
        PUSH {R0, R1}  // not required for this
        B PROCESS
TO_VALUE
        CMP R5, #0B100  // value to be operated on
        BNE RETURN  // cause occurs in the aftermath of recursion calls
        MUL R7, R4, R6  // factor times actual unsigned number
        ADD R0, R7  // add the neg/pos number
        PUSH {R0, R1}
        B pprogram
