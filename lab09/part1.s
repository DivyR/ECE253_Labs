.text
.global _start

_start:
        LDR R0, =LIST  // address of LIST
        LDR R1, [R0]  // cardinality of list
        // LIFO <=> FILO data structure
        LDR SP, =0xffffff00  // near the very end of the memory
        BL BUBBLE_SORT  // sort R0

END:
        B END


BUBBLE_SORT:
        PUSH {LR}  // to know where to go back to at the end of the routine

BUBBLE_SORT_LOOPI:
        SUB R1, R1, #1  // decrement the size
        CMP R1, #0  // check if size is zero (base case)
        BLE BUBBLE_SORT_RETURN  // end condition of function
        MOV R3, #0  // bool to check if swaps have occured
        MOV R2, #0  // counter for loopj

BUBBLE_SORT_LOOPJ:
        CMP R2, R1  // check if counter is at R1
        BEQ BUBBLE_SORT_LOOPJ_EXIT  // leave loopj
        ADD R2, R2, #1  // counter until reaching R1
        ADD R0, R0, #4  // increment R0 to the next number in the list
        PUSH {R0-R2}  // push regs that will be modified by SWAP
        PUSH {R3}  // bool check
        BL SWAP  // returns R0 bool indicating if swap occured
        POP {R3}  // fetch R3
        ADD R3, R3, R0  // add 1/0 depending on if swap occured
        POP {R0-R2}  // fetch R0 address after R0 has been altered by SWAP
        B BUBBLE_SORT_LOOPJ  // repeat loopj until R2 is R1
BUBBLE_SORT_LOOPJ_EXIT:
        CMP R3, #0  // no swaps occurred in loopj, the list is fully sorted
        BEQ BUBBLE_SORT_RETURN  // return if list is fully sorted
        LDR R0, =LIST  // reset R0 reg storage
        B BUBBLE_SORT_LOOPI  // repeat loopi until its been done R1 number of times

BUBBLE_SORT_RETURN:
        LDR R0, =LIST // fetch once more to obtain the lowest-rearranged value
        LDR R0, [R0, #4]  // set R0 as the return value of lowest number
        POP {LR}  // lowest stack member
        MOV PC, LR


SWAP:
        MOV R1, R0  // store R0 address for swapping
        LDR R2, [R1]  // lower number
        LDR R3, [R1, #4]  // upper number
        CMP R2, R3  // compare numbers
        MOV R0, #0  // assume no swap
        BLE SWAP_RETURN  // return if no swap
        MOV R0, #1  // swap will occur
        STR R3, [R1]  // move upper to lower position
        ADD R1, R1, #4  // increment to upper position
        STR R2, [R1]  // move lower to upper position
SWAP_RETURN:
        MOV PC, LR


LIST:
        .word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33
