/***************************************************************************************
 * Pushbutton - Interrupt Service Routine
 *
 * This routine checks which KEY has been pressed.  If KEY3 it stops/starts the timer.
****************************************************************************************/
					.global	KEY_ISR
KEY_ISR: 				LDR		R0, =KEY_BASE			// base address of KEYs parallel port
					LDR		R1, [R0, #0xC]			// read edge capture register
					STR		R1, [R0, #0xC]			// clear the interrupt

CHK_KEY3:				@ ...
					CMP R1, #0b1000
					BNE END_KEY_ISR

START_STOP:				LDR		R0, =MPCORE_PRIV_TIMER		// timer base address
					LDR		R1, [R0, #0x8]			// read timer control register
					EOR R1, 0b1  // toggle enable
					STR R1, [R0, #0x8]  // store the toggled binary back into timer control register

END_KEY_ISR:				MOV	PC, LR
					.end
