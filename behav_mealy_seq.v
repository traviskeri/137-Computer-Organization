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

assign z = q[1] & q[0] & x;

endmodule // 

module flip_flop(
  input d, clk, reset,
  output reg q
);

always @ ( posedge clk, posedge reset)
begin
    if (~reset) 
        q <= 1'b0;
    else 
        q <= d;
end

endmodule //

module behav_mealy_seq(
    input clk, reset, x,
    output  z
);

wire [1:0] d;
wire [1:0] q;

next_state_gen nsg(x, q, d);
flip_flop ff1(d[0], clk, reset, q[0]);
flip_flop ff2(d[1], clk, reset, q[1]);
output_gen og(q, x, z);

endmodule