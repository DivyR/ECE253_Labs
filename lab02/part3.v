// Prelab Part III //
module part3(SW, LEDR);  // 2bit3to1mux
   // I/Os
   input [9:0] SW;
   output [9:0] LEDR;

   // inits
   wire [1:0] S, U, V, W, M;

   // select input switches
   assign S = SW[8:9];  //s_0 = 8, s_1 = 9
   // 2-bit inputs
   assign U = SW[1:0];
   assign V = SW[3:2];
   assign W = SW[5:4];

   // calculate M: m_i = ~s_1(~s_0 * u_i + s_0 * v_i) + (s_1 * w_i)
   // for i = 0, 1
   assign M[0] = (~S[1] & ((~S[0] & U[0]) | (S[0] & V[0]))) | (S[1] & W[0]);
   assign M[1] = (~S[1] & ((~S[0] & U[1]) | (S[0] & V[1]))) | (S[1] & W[1]);

   assign LEDR[1:0] = M;
endmodule // part3
