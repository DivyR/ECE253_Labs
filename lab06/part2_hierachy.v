module feedback(
   input w,
   input [3:0] y,
   output reg [3:0] Y
);
   // states
   parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100, F = 4'b0101, G = 4'b0110, H = 4'b0111, I = 4'b1000;

   always @(w, y) begin
      case (y)
         A:
         if (w) begin
            Y = F;
			end
         else begin
            Y = B;
         end
         B:
         if (w) begin
            Y = F;
			end
         else begin
            Y = C;
         end
         C:
         if (w) begin
            Y = F;
			end
         else begin
            Y = D;
         end
         D:
         if (w) begin
            Y = F;
			end
         else begin
            Y = E;
         end
         E:
         if (w) begin
            Y = F;
			end
         else begin
            Y = E;
			end
         F:
         if (w) begin
            Y = G;
			end
         else begin
            Y = B;
         end
         G:
         if (w) begin
            Y = H;
			end
         else begin
            Y = B;
			end
         H:
         if (w) begin
            Y = I;
			end
         else begin
            Y = B;
			end
         I:
         if (w) begin
            Y = I;
			end
         else begin
            Y = B;
			end
      endcase
   end

endmodule // feedback

module n4bitflipflop(
   Y, clock, resetn, y
);
   parameter n = 4, A = 4'b0000;
   input [n-1:0] Y;
   input clock, resetn;
   output reg [n-1:0] y;
   always @(posedge clock) begin
      if (resetn == 0) begin
         y <= A;
      end
      else if (clock == 1) begin
         y <= Y;
      end
      // else maintain state
   end

endmodule // n_flip_flop

module part2(
   input [1:0] SW,  // SW[1] is w, SW[0] is resetn
   input [1:0] KEY,  // clock
   output [9:0] LEDR  // LEDR[9] is z, 3-0 are FSM flipflops
);
   parameter E = 4'b0100, I = 4'b1000;
   wire [3:0] Y;
   feedback LOOP0 (SW[1], LEDR[3:0], Y);
   n4bitflipflop SET0 (Y, KEY[0], SW[0], LEDR[3:0]);
   assign LEDR[9] = (LEDR[3:0] == E || LEDR[3:0] == I);
endmodule // part1
