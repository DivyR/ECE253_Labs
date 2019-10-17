// LAB 05: PART 4 //
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

module counter16bitreg(
   input enable, clearn, clk,
   output reg [15:0] Q
);

always @(posedge clk, negedge clearn) begin
   if (clearn == 1'b0) begin
      Q <= 16'b0;
   end else if (enable == 1'b1) begin
      Q <= Q + 1;
   end
end
endmodule // counter16bitreg

module part4(
   input [1:0] KEY,  // KEY[0] is clock input
   input [1:0] SW,  // SW[0] = clear/reset, SW[1] = enable
   output [6:0] HEX3, HEX2, HEX1, HEX0
);
   // Q is the incrementing element
   wire [15:0] Q;
   // incrementing function
   counter16bitreg count0(SW[1], SW[0], KEY[0], Q);

   // display
   bcd4bittohex showQ0(Q[3:0], HEX0);
   bcd4bittohex showQ1(Q[7:4], HEX1);
   bcd4bittohex showQ2(Q[11:8], HEX2);
   bcd4bittohex showQ3(Q[15:12], HEX3);
endmodule // part4
