// PART FIVE Lab 2//
module mux2bit3to1(S, A, B, C, F);
   // I/Os
   input [1:0] S, A, B, C;
   output [1:0] F;

   assign F[0] = (~S[1] & ((~S[0] & A[0]) | (S[0] & B[0]))) | (S[1] & C[0]);
   assign F[1] = (~S[1] & ((~S[0] & A[1]) | (S[0] & B[1]))) | (S[1] & C[1]);
endmodule // 2bit3to1mux


// need to fix with truth table later!!!
module decoder7bit(C, HEX0, HEX1, HEX2);  // 3 display outputs
   // I/Os
   input [1:0] C;
   output [6:0] HEX0, HEX1, HEX2;

   // logic for 7-bit decoder

   // hex0
   assign HEX0[0] = C[0] & C[1];
   assign HEX0[1] = C[0];
   assign HEX0[2] = (~C[0] & ~C[1]) | (C[0] & C[1]);
   assign HEX0[3] = C[0] & C[1];
   assign HEX0[4] = C[0] | C[1];
   assign HEX0[5] = ~C[0] | C[1];
   assign HEX0[6] = C[0] & C[1];

   // hex1
   assign HEX1[0] = C[0] & C[1];
   assign HEX1[1] = (~C[0] & ~C[1]) | (C[0] & C[1]);
   assign HEX1[2] = C[1];
   assign HEX1[3] = C[0] & C[1];
   assign HEX1[4] = C[0] | ~C[1];
   assign HEX1[5] = C[0] | C[1];
   assign HEX1[6] = C[0] & C[1];

   // hex2
   assign HEX2[0] = C[0] & C[1];
   assign HEX2[1] = C[1];
   assign HEX2[2] = C[0];
   assign HEX2[3] = C[0] & C[1];
   assign HEX2[4] = ~C[0] | C[1];
   assign HEX2[5] = C[0] | ~C[1];
   assign HEX2[6] = C[0] & C[1];
endmodule // 7bitdecoder


module part5(SW, LEDR, HEX0, HEX1, HEX2);
   // I/Os
   input [9:0] SW;
   output [9:0] LEDR;
   output [6:0] HEX0, HEX1, HEX2;

   // wires
   wire [1:0] F;

   mux2bit3to1 U0(SW[9:8], SW[5:4], SW[3:2], SW[1:0], F);
   // updates HEX0-2 for the output displays
   decoder7bit H0(F, HEX0, HEX1, HEX2);

   assign LEDR = SW;
endmodule // part5
