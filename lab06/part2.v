module part2(SW, KEY, LEDR);
   input [1:0] KEY, SW;
   output reg [9:0] LEDR;
   reg [3:0] y_Q, y_D; // Q is current, D is next
   wire w; // Value for switch state
   parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100, F = 4'b0101, G = 4'b0110, H = 4'b0111, I = 4'b1000;
   // Begin assignments
   assign w = SW[1];
   // Assign with state logic
   always @(w, y_Q)
   begin
       // Determine next state & light LEDs
       LEDR[9:0] = 10'b0;
       case (y_Q)
           A: begin if (w) y_D = F; else y_D = B; LEDR[0] = 1'b1; end
           B: begin if (w) y_D = F; else y_D = C; LEDR[1] = 1'b1; end
           C: begin if (w) y_D = F; else y_D = D; LEDR[2] = 1'b1; end
           D: begin if (w) y_D = F; else y_D = E; LEDR[3] = 1'b1; end
           E: begin if (w) y_D = F; else y_D = E; LEDR[4] = 1'b1; LEDR[9] = 1'b1; end
           F: begin if (w) y_D = G; else y_D = B; LEDR[5] = 1'b1; end
           G: begin if (w) y_D = H; else y_D = B; LEDR[6] = 1'b1; end
           H: begin if (w) y_D = I; else y_D = B; LEDR[7] = 1'b1; end
           I: begin if (w) y_D = I; else y_D = B; LEDR[8] = 1'b1; LEDR[9] = 1'b1; end
           default: y_D = 4'bxxxx;
       endcase
   end
   // Clocking
   always @(negedge SW[0], posedge KEY[0]) // clock and reset logic
   begin
       if (~SW[0]) y_Q <= A;
       else y_Q <= y_D;
   end
endmodule
