.text
.global start

start:
        LDR R3, =TEST_NUM // load the list into R3
        LDR R6, N // R2 holds amount of numbers
        MOV R4, #0  // R4 will hold the max result

MAX_ONES:
        CMP R6, #0
        BLE END
      	MOV R0, #0 // R0 will hold the result
        LDR R1, [R3]  // load R1 with word
        BL ONES
        CMP R0, R4
        BLE INCREMENT
        MOV R4, R0
INCREMENT:
        ADD R3, R3, #4  // increment to next number
        SUB R6, R6, #1
        B MAX_ONES

END: B END


ONES:
ONES_LOOP:
        CMP R1, #0 // loop until the data contains no more 1’s
        BEQ ONES_RETURN
        LSR R2, R1, #1 // perform SHIFT, followed by AND
        AND R1, R1, R2
        ADD R0, #1 // count the string lengths so far
        B ONES_LOOP
ONES_RETURN:
        MOV PC, LR  // move link-reg to program counter

TEST_NUM:
        .word 0x103fe00f, 0x2FFF00F0, 0x12345678, 0xABCDEFFF, 0x98765432, 0x123EEBCC, 0x12435346, 0x32414234, 0x0000000, 0x11112222
N:
        .word 10
.end
