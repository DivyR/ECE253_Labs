// Prelab Part I //
module part1(SW, LEDR);
   // assign switch inputs and red-led outputs
   input [9:0] SW;
   output [9:0] LEDR;

   assign LEDR = SW;
endmodule // part1
