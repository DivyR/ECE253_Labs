// LAB05: PART 6 //
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

module rotatedE1(
   input clk, enable, resetn,
   output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6
);
   always @(posedge clk) begin
	    // initilization
      if (!resetn) begin
         HEX6 <= 7'b1111111;
         HEX5 <= 7'b1111111;
         HEX4 <= 7'b1111111;
         HEX3 <= 7'b1111111;
         HEX2 <= 7'b0100001;
         HEX1 <= 7'b0000110;
         HEX0 <= 7'b1111001;
      end else if (enable) begin
         HEX0 <= HEX6;
         HEX1 <= HEX0;
         HEX2 <= HEX1;
         HEX3 <= HEX2;
         HEX4 <= HEX3;
         HEX5 <= HEX4;
         HEX6 <= HEX5;
      end
   end
endmodule // rotatedE1

module part6(
   input CLOCK_50,
   output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6
);
   wire enable, resetn;

   // only for counting 1s
   wire [25:0] Q;
   one_second_counter tracker1s(CLOCK_50, enable, Q);

   // initial input
   assign resetn = HEX0 && HEX1 && HEX2 && HEX3 && HEX4 && HEX5 && HEX6;

   // rotate every 1s (enable == 1)
   rotatedE1 rotater0(CLOCK_50, enable, resetn, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6);

endmodule // part6
