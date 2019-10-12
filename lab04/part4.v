// LAB 04: PART 4 //
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

module circuitB(SW, OUT);
   input [1:0] SW;
   output [4:0] OUT;
   wire [3:0] SIX = {1'b0, 1'b1, 1'b1, 1'b0};
   wire IN = 1'b0;

   rippleadder4bit C0(SW, SIX, IN, OUT);

endmodule // circuitB

module part2(SW, HEX1, HEX0);
   // switch inputs bcd from 0 to 15 inclusive
   input [4:0] SW;
   // output double digit hex-display
   output [6:0] HEX1, HEX0;

   wire ZOUT, ONEFLAG;
   wire [3:0] A, MUX1OUT, BCD0;
   wire [4:0] BOUT;

   // determine if greater than 9
   compartor9 C0(SW[3:0], ZOUT);
   assign ONEFLAG = ZOUT | SW[4];

   // encode A with correct bits for the ONEFLAG == 1 case
   circuitA C1(SW[3:0], A);

   // push A or SW[3:0] directly depending on ZOUT
   mux4bit2to1 C2(SW, A, ZOUT, MUX1OUT);

   // in the case SUM > 15
   circuitB C5(SW, BOUT);

   // determine if > 15
   mux4bit2to1 C6(MUX1OUT, BOUT[3:0], SW[4], BCD0);

   // final display of sum
   fourbcd0to9 C3(BCD0, HEX0);
   fourbcd0to9 C4(ONEFLAG, HEX1);
endmodule // part2

module fulladder(a, b, ci, s, co);
   input a, b, ci;
   output s, co;

   // bit carried out, c_i+1 = co
   assign co = a & (ci | b) | (b & ci);
   // sum bit i
   assign s = b ^ a ^ ci;
endmodule // fulladder

module rippleadder4bit(A, B, Cin, LEDR);
   input [3:0] A, B;
   input Cin;
   output [4:0] LEDR;
   wire [2:0] Cout;

   fulladder C1(A[0], B[0], Cin, LEDR[0], Cout[0]);
   fulladder C2(A[1], B[1], Cout[0], LEDR[1], Cout[1]);
   fulladder C3(A[2], B[2], Cout[1], LEDR[2], Cout[2]);
   fulladder C4(A[3], B[3], Cout[2], LEDR[3], LEDR[4]);
endmodule // rippleadder4bit

module part4(SW, LEDR, HEX5, HEX4, HEX1, HEX0);
   // I/Os
   input [8:0] SW;
   output [9:0] LEDR;
   output [6:0] HEX5, HEX4, HEX1, HEX0;

   wire [1:0] Zout;
   wire [4:0] SUM;

   // error check for max(X,Y) > 9
   compartor9 C0(SW[3:0], Zout[0]);
   compartor9 C1(SW[7:4], Zout[1]);
   // turn on error light
   assign LEDR[9] = Zout[0] | Zout[1];

   // display (X, Y) on (HEX5, HEX4)
   fourbcd0to9 C2(SW[3:0], HEX4);
   fourbcd0to9 C3(SW[7:4], HEX5);

   // sum(X, Y, Cin)
   rippleadder4bit C4(SW[3:0], SW[7:4], SW[8], SUM);
   // display SUM on (HEX1, HEX0)
   part2 C5(SUM, HEX0, HEX1);
   // connect to LEDR
   assign LEDR[4:0] = SUM;

endmodule // part4
