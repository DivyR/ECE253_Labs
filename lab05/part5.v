// LAB05: PART 5 //
// track 1 second increments
module one_second_counter(
   input clk,
   output reg enable,
   output reg [25:0] Q
);
   always @(posedge clk) begin
      Q <= Q + 1;
      if (~Q == 26'b0) begin
         enable <= 1'b1;
      end else begin
         enable <= 1'b0;
      end
   end
endmodule // one_second_counter

module counter4bitreg(
   input enable, clk,
   output reg [3:0] Q
);

always @(posedge clk) begin
   // active-high reset
   if (enable == 1'b1) begin
      // reset if at 9
      if (Q == 4'b1001) begin
         Q <= 4'b0;
      end else begin
         Q <= Q + 1;
      end
   end
end
endmodule // counter4bitreg

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

module part5(
   input CLOCK_50,
   output [6:0] HEX0
);
   wire enable;

   // only for counting 1s
   wire [25:0] Q;
   one_second_counter tracker1s(CLOCK_50, enable, Q);

   // 0-9 counter
   wire [3:0] bcData;
   counter4bitreg counter0(enable, CLOCK_50, bcData);
   bcd4bittohex show0(bcData, HEX0);
endmodule // part5
