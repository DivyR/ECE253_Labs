// PART FOUR Lab 2//
module part4(SW, HEX0);  // 7-bit decoder
   // I/Os
   input [1:0] SW;
   output [6:0] HEX0;

   // wires
   wire [1:0] C;

   // name-assignments
   assign C = SW[1:0];

   // logic for 7-bit decoder
   assign HEX0[0] = C[0] & C[1];
   assign HEX0[1] = C[0];
   assign HEX0[2] = (~C[0] & ~C[1]) | (C[0] & C[1]);
   assign HEX0[3] = C[0] & C[1];
   assign HEX0[4] = ~C[0] | ~C[1];
   assign HEX0[5] = ~C[0] | C[1];
   assign HEX0[6] = C[0] & C[1];
endmodule // part4
