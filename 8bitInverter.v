module inverter_8bit
(input [7:0] i,
input m,
output reg [7:0] o,
output cin);


assign cin = m;

always @* begin
if(m==1)begin
o = ~i;  
//$monitor("%b", o);
end else begin
o = i;
end
end



endmodule