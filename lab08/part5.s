.text
.global start

start:
        LDR R0, TEST_NUM  // binary number of interest
        MOV R5, #0  // number of ones
        MOV R6, #0  // number of leading 0s
        MOV R7, #0  // number of trailing 0s

        // prep ones count
        LDR R1, NBITS  // counter to 32 bits
        MOV R2, #1  // shifter
        BL ONES

        // prep leading count
        LDR R1, NBITS  // reload 32 bits counter
        LDR R2, LEADING_BIT  // load with a 1 in the 32nd bit
        BL LEADING

        // prep trailing count
        LDR R1, NBITS  // reload 32 bits counter
        MOV R2, #1  // load with 1 in the 1st bit
        BL TRAILING

END:
        B END

ONES:
ONES_LOOP:  // R1, R2, R3 (local), R5 (store)
        CMP R1, #0  // check if 32 bit-iterations
        BEQ ONES_RETURN  // branch to leave subroutine
        AND R3, R2, R0  // and with the 32 - R1th bit and check for 1
        CMP R3, #0
        BEQ ONES_NEXT_ITERATION
        ADD R5, R5, #1  // not zero -> thus 1, count it
ONES_NEXT_ITERATION:
        LSL R2, R2, #1  // shift left once
        SUB R1, R1, #1  // decrease counter
        B ONES_LOOP  // repeat loop
ONES_RETURN:
        MOV PC, LR  // link reg into program counter

LEADING:  // R1, R2, R3 (local), R6 (store)
LEADING_LOOP:
        CMP R1, #0  // check if 32-bit iterations
        BEQ LEADING_RETURN
        AND R3, R2, R0  // and the leading with num to check for non-zero
        CMP R3, #0  // when not zero
        BNE LEADING_RETURN
        ADD R6, R6, #1
LEADING_NEXT_ITERATION:
        LSR R2, R2, #1
        SUB R1, R1, #1
        B LEADING_LOOP
LEADING_RETURN:
        MOV PC, LR

TRAILING:  // R1, R2, R3 (local), R7 (store)
TRAILING_LOOP:
        CMP R1, #0  // check if 32-bit iterations
        BEQ TRAILING_RETURN
        AND R3, R2, R0  // check the 32-R1th bit for 0
        CMP R3, #0  // check for not zero
        BNE TRAILING_RETURN
        ADD R7, R7, #1
TRAILING_NEXT_ITERATION:
        LSL R2, R2, #1
        SUB R1, R1, #1
        B TRAILING_LOOP
TRAILING_RETURN:
        MOV PC, LR

NBITS:
        .word 32

LEADING_BIT:
        .word 0x80000000

TEST_NUM:
        .word 0x0000F0E0
