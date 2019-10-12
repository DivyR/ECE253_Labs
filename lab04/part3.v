// LAB 04: PART 3 //
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

module part3(SW, LEDR);
   input [8:0] SW;
   output [4:0] LEDR;

   rippleadder4bit C0(SW[3:0], SW[7:4], SW[8], LEDR);
endmodule // part3
