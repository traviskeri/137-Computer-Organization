module next_state_gen(
    input x,
    input [1:0] q,
    output [1:0] d
);

assign d[0]= q[1] & q[2] | x;
assign d[1]= (q[1] & ~q[0] & ~x) | (~q[1] & q[0] & ~x);

endmodule 

module output_gen(
  input [1:0] q,
  input x,
  output z
);

assign z= q[1] & q[0] & x

endmodule // 

module flip_flop(
  input d, clk, reset,
  output q,
);

reg q;

always @ ( posedge clk or negedge reset)
 24 if (~reset) begin
 25   q <= 1'b0;
 26 end  else begin
 27   q <= d;
 28 end

endmodule //