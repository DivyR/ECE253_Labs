module part2(
   input [1:0] SW,  // SW[1] is w, SW[0] is resetn
   input [1:0] KEY,  // clock
   output reg [9:0] LEDR  // LEDR[9] is z, 3-0 are FSM flipflops
);
   // states
   parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100, F = 4'b0101, G = 4'b0110, H = 4'b0111, I = 4'b1000;
   wire w, clock, resetn;
   assign w = SW[1];
   assign resetn = SW[0];
   assign clock = KEY[0];
   reg [3:0] Y;
   always @(w, LEDR[3:0]) begin
      case (LEDR[3:0])
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
   always @(posedge clock) begin
      if (resetn == 0) begin
         LEDR[3:0] <= A;
      end
      else if (clock == 1) begin
         LEDR[3:0] <= Y;
      end
      // else maintain state
   end
	always @(*) begin
		LEDR[9] = (LEDR[3:0] == E || LEDR[3:0] == I);
	end
endmodule // part1
