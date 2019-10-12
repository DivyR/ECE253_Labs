// LAB 04: PART 2 //
// returns a boolean z indicating if input is greater than 9
module compartor9(V, ZOUT);
   input [3:0] V;
   output ZOUT;

   assign ZOUT = V[3] & (V[1] | V[2]);
endmodule // compartor9

// encodes A with the correct bits when V > 9, valid when ZOUT == 1
module circuitA(V, A);
   input [3:0] V;
   output [3:0] A;

   // encode the first digit from a double digit number
   assign A[0] = V[0];
   assign A[1] = ~V[1];
   assign A[2] = V[2] & V[1];
   assign A[3] = 1'b0;
endmodule // circuitA

module mux4bit2to1(V, A, ZIN, OUT);
   input [3:0] V, A;
   input ZIN;
   output [3:0] OUT;

   // OUTi = ~ZIN & Vi | ZIN & Ai
   assign OUT[0] = (~ZIN & V[0]) | (ZIN & A[0]);
   assign OUT[1] = (~ZIN & V[1]) | (ZIN & A[1]);
   assign OUT[2] = (~ZIN & V[2]) | (ZIN & A[2]);
   assign OUT[3] = (~ZIN & V[3]) | (ZIN & A[3]);
endmodule // mux4bit2to1

module fourbcd0to9(SW, DISP);
   // switches
   input [3:0] SW;
   // hex-displays
   output [6:0] DISP;

   // bool-functions using a minterms approach
   assign DISP[0] = (SW[2] & ~SW[1] & ~SW[0]) | (~SW[3] & ~SW[2] & ~SW[1] & SW[0]);
   assign DISP[1] = SW[2] & (SW[1] ^ SW[0]);
   assign DISP[2] = ~SW[3] & ~SW[2] & SW[1] & ~SW[0];
   assign DISP[3] = (~SW[3] & ~SW[2] & ~SW[1] & SW[0]) | (SW[2] & ((~SW[1] & ~SW[0]) | (SW[1] & SW[0])));
   assign DISP[4] = SW[0] | (SW[2] & ~SW[1]);
   assign DISP[5] = (SW[1] & SW[0]) | ((~SW[3] & ~SW[2]) & (SW[0] | SW[1]));
   assign DISP[6] = (~SW[3] & ~SW[2] & ~SW[1]) | (SW[2] & SW[1] & SW[0]);
endmodule // fourbcd0to9

module part2(SW, HEX1, HEX0);
   // switch inputs bcd from 0 to 15 inclusive
   input [3:0] SW;
   // output double digit hex-display
   output [6:0] HEX1, HEX0;
   wire ZOUT;
   wire [3:0] A, BCD0;

   compartor9 C0(SW, ZOUT);
   circuitA C1(SW, A);
   mux4bit2to1 C2(SW, A, ZOUT, BCD0);
   fourbcd0to9 C3(BCD0, HEX0);
   fourbcd0to9 C4(ZOUT, HEX1);
endmodule // part2
