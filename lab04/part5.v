// LAB 04: PART 5 //
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

module part5(SW, HEX5, HEX4, HEX1, HEX0);
   input [8:0] SW;
   output [6:0] HEX5, HEX4, HEX1, HEX0;

   wire [5:0] T0;
   reg [3:0] ZOUT;
	wire [3:0] bcd0, bcd1;
   reg c1;

   // check if > 9
   assign T0 = SW[7:4] + SW[3:0] + SW[8];

   // display A and B
   fourbcd0to9 C0(SW[7:4], HEX5);
   fourbcd0to9 C1(SW[3:0], HEX4);

   always @(T0) begin
      if (T0 > 9) begin
         ZOUT = 4'b1010;
         c1 = 1'b1;
      end
      else begin
         ZOUT = 4'b0000;
         c1 = 1'b0;
      end
   end
   assign bcd0 = T0 - ZOUT;
   assign bcd1 = c1;

   fourbcd0to9 C2(bcd0, HEX0);
   fourbcd0to9 C3(bcd1, HEX1);
endmodule // part5
