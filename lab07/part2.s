.text
.global _start

_start:
        // list
        LDR R0, =TEST_NUM
        // sum
        MOV R7, #0
        // pos-nums
        MOV R8, #0

SUM_LOOP:
        LDR R1, [R0]
        CMP R1, #-1
        BEQ END
        ADD R7, R7, R1
        BLE NOT_POS
        ADD R8, R8, #1

NOT_POS:
        ADD R0, R0, #4
        B SUM_LOOP



END:
        B END

TEST_NUM: .word 1,2,3,5,0xA,-1
.end
