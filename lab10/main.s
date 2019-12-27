	.include "address_map_arm.s"
/*
 * This program demonstrates the use of interrupts using the KEY and timer ports. It
 * 	1. displays a sweeping red light on LEDR, which moves left and right
 * 	2. stops/starts the sweeping motion if KEY3 is pressed
 * Both the timer and KEYs are handled via interrupts
*/
			.text
			.global	_start
_start:
			@ ... initialize the IRQ stack pointer ...
			@ ... initialize the SVC stack pointer ...
			MOV R0, 0b10010  // IRQ mode from defines.s
			MSR CPSR, R0  // move to IRQ
			LDR SP, =0x20000  // IRQ stack

			MOV R0, 0b10011  // SVC mode from defines.s
			MSR CPSR, R0  // move to SVC
			LDR SP, =0x40000  // SVC stack

			BL			CONFIG_GIC				// configure the ARM generic interrupt controller
			BL			CONFIG_PRIV_TIMER		// configure the MPCore private timer
			BL			CONFIG_KEYS				// configure the pushbutton KEYs

			@ ... enable ARM processor interrupts ...
			EOR CPSR, CPSR, #0x80  // flip interrupt mask, from 1 -> 0 to enable interrupts

			LDR		R6, =0xFF200000 		// red LED base address
MAIN:
			LDR		R4, LEDR_PATTERN		// LEDR pattern; modified by timer ISR
			STR 		R4, [R6] 				// write to red LEDs
			B 			MAIN

/* Configure the MPCore private timer to create interrupts every 1/10 second */
CONFIG_PRIV_TIMER:
			LDR		R0, =0xFFFEC600 		// Timer base address
			@ ... code not shown
			MOV R2, #0b011  // E = 1, A = 1, I = 0 to emable interrupts
			MOV R3, ONE_TENTH_SECOND  // from word added at bottom of file
			STR R3, [R0]  // store the counter
			STR R2, [R0, #8]  // timer control
			MOV 		PC, LR 					// return

/* Configure the KEYS to generate an interrupt */
CONFIG_KEYS:
			LDR 		R0, =0xFF200050 		// KEYs base address
			@ ... code not shown
			MOV R2, #0b1111
			STR R2, [R0, #8]
			MOV 		PC, LR 					// return



			.global	LEDR_DIRECTION
LEDR_DIRECTION:
			.word 	0							// 0 means means moving to centre; 1 means moving to outside

			.global	LEDR_PATTERN
LEDR_PATTERN:
			.word 	0x201	// 1000000001

			.global ONE_TENTH_SECOND
ONE_TENTH_SECOND:
			.word 0x1312D00
