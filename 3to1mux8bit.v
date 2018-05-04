`include "2to1mux8bit.v"

module  mux_3to1_8bit(
 input [7:0] in_0, in_1, in_2,
 input sel_0, sel_1,
 output [7:0] mux_out
 );

 reg  mux_out;
 
 wire [7:0] temp;

 mux_2to1_8bit mux1(in_0, in_1, sel_0, temp);

 always @ (sel_1 or temp or in_2)
 begin : MUX
   if (sel_1== 1'b0) begin
       mux_out = temp;
   end else begin
       mux_out = in_2 ;
   end
 end
 
endmodule 