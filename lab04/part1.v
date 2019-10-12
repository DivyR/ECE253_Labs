// LAB 04: PART 1 //
module fourbcd0to9(SW, DISP);
   // switches
   input [3:0] SW;
   // hex-displays
   output [6:0] DISP;

   // bool-functions using a minterms approach
   assign DISP[0] = (SW[2] & ~SW[1] & ~SW[0]) | (~SW[3] & ~SW[2] & ~SW[1] & SW[0]);
   assign DISP[1] = SW[2] & (SW[1] ^ SW[0]);
   assign DISP[2] = ~SW[3] & ~SW[2] & SW[1] & ~SW[0];
   assign DISP[3] = (~SW[3] & ~SW[2] & ~SW[1] & SW[0]) | (SW[2] & ((~SW[1] & ~SW[0]) | (SW[1] & SW[0])));
   assign DISP[4] = SW[0] | (SW[2] & ~SW[1]);
   assign DISP[5] = (SW[1] & SW[0]) | ((~SW[3] & ~SW[2]) & (SW[0] | SW[1]));
   assign DISP[6] = (~SW[3] & ~SW[2] & ~SW[1]) | (SW[2] & SW[1] & SW[0]);
endmodule // fourbcd0to9

module part1(SW, HEX1, HEX0);
   // input switches and displays
   input [7:0] SW;
   output [6:0] HEX1, HEX0;

   // configure display 0
   fourbcd0to9 D0(SW[3:0], HEX0);
   // configure display 1
   fourbcd0to9 D1(SW[7:4], HEX1);
endmodule // part1
