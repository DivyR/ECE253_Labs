// Lab 05: PART 1 //
module gated_d_latch(  // level-sensitive, transparent
   input data,
   input clk,
   output reg Q,
   output reg Qn  // Qn == ~Q
);
// update Q & Qn if clk is high and data changes
   always @(data, clk) begin
      if (clk == 1'b1) begin
         Q = data;
         Qn = ~data;
      end
      // clk == 0 is designed to be stored
   end
endmodule // gated_d_latch

module pedge_d_flipflop(  // updates Q when clk changes from low to high
   input data,
   input clk,
   output reg Q,
   output reg Qn  // Qn == ~Q
);
   // update on posedge
   always @(posedge clk) begin
      Q <= data;
      Qn <= ~data;
   end
endmodule // pedge_d_flipflop

module nedge_d_flipflop(  // updates Q when clk changes from high to low
   input data,
   input clk,
   output reg Q,
   output reg Qn  // Qn == ~Q
);
   // update on negedge
   always @(negedge clk) begin
      Q <= data;
      Qn <= ~data;
   end
endmodule // nedge_d_flipflop

module part1(
   input [1:0] SW,  // clock and data input
   output [2:0] LEDR
);

   // dummy wire
   wire [2:0] Qout;

   // tests
   gated_d_latch test0(SW[1], SW[0], LEDR[0], Qout[0]);
   pedge_d_flipflop test1(SW[1], SW[0], LEDR[1], Qout[1]);
   nedge_d_flipflop test2(SW[1], SW[0], LEDR[2], Qout[2]);
endmodule // part1
