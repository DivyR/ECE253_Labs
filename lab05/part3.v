// LAB 05: PART 3 //
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

module t_flip_flop(
   input clk, clearn, T,
   output reg Q
);

   always @(posedge clk, negedge clearn) begin
      if (~clearn) begin
         Q <= 1'b0;
      end else begin
         Q <= T ^ Q;
      end
   end
endmodule // t_flip_flop

module counter16bit(
   input enable, clearn, clk,
   output [15:0] Q
);
   t_flip_flop TFF0(clk, clearn, enable, Q[0]);
   t_flip_flop TFF1(clk, clearn, Q[0] & enable, Q[1]);
   t_flip_flop TFF2(clk, clearn, Q[1] & Q[0] & enable, Q[2]);
   t_flip_flop TFF3(clk, clearn, Q[2] & Q[1] & Q[0] & enable, Q[3]);
   t_flip_flop TFF4(clk, clearn, Q[3] & Q[2] & Q[1] & Q[0] & enable, Q[4]);
   t_flip_flop TFF5(clk, clearn, Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & enable, Q[5]);
   t_flip_flop TFF6(clk, clearn, Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & enable, Q[6]);
   t_flip_flop TFF7(clk, clearn, Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & enable, Q[7]);
   t_flip_flop TFF8(clk, clearn, Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & enable, Q[8]);
   t_flip_flop TFF9(clk, clearn, Q[8] & Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & enable, Q[9]);
   t_flip_flop TFF10(clk, clearn, Q[9] & Q[8] & Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & enable, Q[10]);
   t_flip_flop TFF11(clk, clearn, Q[10] & Q[9] & Q[8] & Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & enable, Q[11]);
   t_flip_flop TFF12(clk, clearn, Q[11] & Q[10] & Q[9] & Q[8] & Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & enable, Q[12]);
   t_flip_flop TFF13(clk, clearn, Q[12] & Q[11] & Q[10] & Q[9] & Q[8] & Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & enable, Q[13]);
   t_flip_flop TFF14(clk, clearn, Q[13] & Q[12] & Q[11] & Q[10] & Q[9] & Q[8] & Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & enable, Q[14]);
   t_flip_flop TFF15(clk, clearn, Q[14] & Q[13] & Q[12] & Q[11] & Q[10] & Q[9] & Q[8] & Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & enable, Q[15]);
endmodule // counter16bit

module part3(
   input [1:0] KEY,  // KEY[0] is clock input
   input [1:0] SW,  // SW[0] = clear/reset, SW[1] = enable
   output [6:0] HEX3, HEX2, HEX1, HEX0
);
   wire clearn, enable, clk;
   assign clearn = SW[0];
   assign enable = SW[1];
   assign clk = KEY[0];
   // Q is the incrementing element
   wire [15:0] Q;
   // incrementing function
   counter16bit count0(enable, clearn, clk, Q);

   // display
   bcd4bittohex showQ0(Q[3:0], HEX0);
   bcd4bittohex showQ1(Q[7:4], HEX1);
   bcd4bittohex showQ2(Q[11:8], HEX2);
   bcd4bittohex showQ3(Q[15:12], HEX3);
endmodule // part3
