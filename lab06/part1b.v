module feedback(
   input w,
   input [8:0] y,
   output [8:0] Y
);
   assign Y[0] = 1'b1;
   assign Y[1] = ~w & (~y[0] | y[5] | y[6] | y[7] | y[8]);
   assign Y[2] = ~w & y[0] & (y[1]);
   assign Y[3] = ~w & y[0] & (y[2]);
   assign Y[4] = ~w & y[0] & (y[3] | y[4]);
   assign Y[5] = w & (~y[0] | y[1] | y[2] | y[3] | y[4]);
   assign Y[6] = w & y[0] & (y[5]);
   assign Y[7] = w & y[0] & (y[6]);
   assign Y[8] = w & y[0] & (y[7] | y[8]);
endmodule // feedback

module n9bitflipflop(
   Y, clock, resetn, y
);
   parameter n = 9;
   input [n-1:0] Y;
   input clock, resetn;
   output reg [n-1:0] y;
   always @(posedge clock) begin
      if (resetn == 0) begin
         y <= 9'b00000000;
      end
      else if (clock == 1) begin
         y <= Y;
      end
      // else maintain state
   end

endmodule // n_flip_flop

module part1b(
   input [1:0] SW,  // SW[1] is w, SW[0] is resetn
   input [1:0] KEY,  // clock
   output [9:0] LEDR  // LEDR[9] is z, 8-0 are FSM flipflops
);
   // input for flipflops
   wire [8:0] Y;
   assign clock = KEY[0];

   feedback LOOP0 (SW[1], LEDR[8:0], Y);
   n9bitflipflop SET0 (Y, clock, SW[0], LEDR[8:0]);
   assign LEDR[9] = LEDR[4] | LEDR[8];
endmodule // part1
