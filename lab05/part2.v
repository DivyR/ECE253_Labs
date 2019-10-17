// Lab 05: PART 2 //
// decode to hex-display
module bcd4bittohex(
   input [3:0] SW,
   output [6:0] DISP
);
   assign DISP[0] = (~SW[3] & ~SW[2] & ~SW[1] & SW[0]) | (~SW[3] & SW[2] & ~SW[1] & ~SW[0]) | (SW[3] & ~SW[2] & SW[1] & SW[0]) |(SW[3] & SW[2] & ~SW[1] & SW[0]);
   assign DISP[1] = (SW[2] & SW[1] & ~SW[0]) | (SW[3] & SW[1] & SW[0]) | (SW[3] & SW[2] & ~SW[0]) | (~SW[3] & SW[2] & ~SW[1] & SW[0]);
   assign DISP[2] = (SW[3] & SW[2] & ~SW[0]) | (SW[3] & SW[2] & SW[1]) | (~SW[3] & ~SW[2] & SW[1] & ~SW[0]);
   assign DISP[3] = (~SW[2] & ~SW[1] & SW[0]) | (SW[2] & SW[1] & SW[0]) | (~SW[3] & SW[2] & ~SW[1] & ~SW[0]) |(SW[3] & ~SW[2] & SW[1] & ~SW[0]);
   assign DISP[4] = (~SW[3] & SW[0]) | (~SW[2] & ~SW[1] & SW[0]) | (~SW[3] & SW[2] & ~SW[1]);
   assign DISP[5] = (~SW[3] & ~SW[2] & SW[0]) | (~SW[3] & ~SW[2] & SW[1]) | (~SW[3] & SW[1] & SW[0]) | (SW[3] & SW[2] & ~SW[1] & SW[0]);
   assign DISP[6] = (~SW[3] & ~SW[2] & ~SW[1]) | (~SW[3] & SW[2] & SW[1] & SW[0]) | (SW[3] & SW[2] & ~SW[1] & ~SW[0]);
endmodule // bcd4bittohex

// 8-bit register
module reg8bit(data, clk, resetn, Q);
   input [7:0] data;
   input clk, resetn;
   output reg [7:0] Q;

   // update but check for active-low async reset
   always @(posedge clk, negedge resetn) begin
      if (resetn == 1'b0) begin
         Q <= 7'b0;
      end else begin
         Q <= data;
      end
   end
endmodule // reg8bit

// 1bit fulladder
module fulladder(a, b, ci, s, co);
   input a, b, ci;
   output s, co;

   // bit carried out, c_i+1 = co
   assign co = a & (ci | b) | (b & ci);
   // sum bit i
   assign s = b ^ a ^ ci;
endmodule // fulladder

// 8bit rippleadder
module rippleadder8bit(
   input [7:0] A, B,
   input Cin,
   output [7:0] SUM,
   output Cout
);
   // internal-dummy carry
   wire [6:0] dOut;

   fulladder addbits0(A[0], B[0], Cin, SUM[0], dOut[0]);
   fulladder addbits1(A[1], B[1], dOut[0], SUM[1], dOut[1]);
   fulladder addbits2(A[2], B[2], dOut[1], SUM[2], dOut[2]);
   fulladder addbits3(A[3], B[3], dOut[2], SUM[3], dOut[3]);
   fulladder addbits4(A[4], B[4], dOut[3], SUM[4], dOut[4]);
   fulladder addbits5(A[5], B[5], dOut[4], SUM[5], dOut[5]);
   fulladder addbits6(A[6], B[6], dOut[5], SUM[6], dOut[6]);
   fulladder addbits7(A[7], B[7], dOut[6], SUM[7], Cout);
endmodule


module part2(
   input [7:0] SW,  // manual bcd input
   input [1:0] KEY,  // KEY[0] is active-low async reset, KEY[1] is clock input
   output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0,  // displays
   output [1:0] LEDR  // carry-out adder bit
);
   wire [7:0] A, B, SUM;
   wire Cout;
   // dummy wire
   wire Cin;
   assign Cin = 1'b0;
   // assume A is stored when B is not, and vice-versa
   reg8bit storeA(SW, KEY[1], KEY[0], A);
   assign B = SW;
   //reg8bit storeB(SW, KEY[1], ~KEY[0], B);

   // show A
   bcd4bittohex showA0(A[3:0], HEX2);
   bcd4bittohex showA1(A[7:4], HEX3);
   // show B
   bcd4bittohex showB0(B[3:0], HEX0);
   bcd4bittohex showB1(B[7:4], HEX1);

   // A + B
   rippleadder8bit sumAB(A, B, Cin, SUM, Cout);
   // show SUM
   bcd4bittohex showSUM0(SUM[3:0], HEX4);
   bcd4bittohex showSUM1(SUM[7:4], HEX5);
   assign LEDR[0] = Cout;
endmodule // part2
