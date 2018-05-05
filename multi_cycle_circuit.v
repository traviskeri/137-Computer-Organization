`include "3to1mux8bit.v"
`include "controlUnit.v"
`include "8bitaddsub.v"

module multi_cycle_circuit(
  input clock, reset, start, mode,
  input [7:0] a, b, c, d,
  output reg done,
  output reg [7:0] result
);

wire dn;
wire [3:0] sig;
wire [7:0] mux3to1, mux2to1, temp;


always@(posedge clock, posedge reset)
begin
  result = mux2to1;
  done = dn;
end

control_unit cu1(clock, reset, start, mode, dn, sig);

mux_3to1_8bit mux3(b, c, d, sig[2], sig[3], mux3to1);

add_sub_8bit as1(result, mux3to1, sig[0], temp);

mux_2to1_8bit mux2(a, temp, sig[1], mux2to1);


endmodule 