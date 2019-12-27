				.include "address_map_arm.s"
				.extern	LEDR_DIRECTION
				.extern	LEDR_PATTERN

/*****************************************************************************
 * MPCORE Private Timer - Interrupt Service Routine
 *
 * Shifts the pattern being displayed on the LEDR
 *
******************************************************************************/
				.global PRIV_TIMER_ISR
PRIV_TIMER_ISR:
				LDR		R0, =MPCORE_PRIV_TIMER	// base address of timer
				MOV		R1, #1
				STR		R1, [R0, #0xC]				// write 1 to F bit to reset it
															// and clear the interrupt

/* Move the two LEDS to the centre or away from the centre to the outside. */
SWEEP:				LDR		R0, =LEDR_DIRECTION	// put shifting direction into R2
				LDR		R2, [R0]
				LDR		R1, =LEDR_PATTERN		// put LEDR pattern into R3
				LDR		R3, [R1]

				AND R4, R3, 0b111111000000  // extract left bits
				AND R5, R3, 0b000000111111  // extract right bits
				MOV R6, 0b000001100000  // middle pattern
				@ ...
				CMP R2, #0  // 0 -> to center, !0 -> away from center
				BNE TOOUTSIDE

TOCENTRE:			@ ...
				@ ...
				LSR R4, R4, #1  // shift left to center
				LSL R5, R5, #1  // shift right to center
				AND R7 R4, R5  // combine halves
				CMP R7, R6  // check if middle pattern
				BNE DONE_SWEEP

C_O:				MOV		R2, #1					// change direction to outside
				B DONE_SWEEP  // move to end
TOOUTSIDE:			@ ...
				@ ...
				LSL R4, R4, #1  // shift left away to left
				LSR R5, R5, #1 // shift right away to right
				AND R7 R4, R5  // combines halves
				CMP R7, R6  // check if middle pattern
				BNE DONE_SWEEP  // skip to end if no need to switch

O_C:				MOV		R2, #0					// change direction to centre

				B			TOCENTRE
				B DONE_SWEEP  // move to end
DONE_SWEEP:
				STR		R2, [R0]					// put shifting direction back into memory
				STR		R3, [R1]					// put LEDR pattern back onto stack
				// automatically goes to the end in this case, but redundancy doesnt hurt in this case
				B END_TIMER_ISR
END_TIMER_ISR:
				MOV		PC, LR
