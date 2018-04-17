`include "2bitCLAadder.v"

module adder_8bit
(input [7:0] a, b,
input cin,
output [7:0] s,
output ovr);

wire [3:0] c, cin_last;
 
cla_adder_2bits cla1(a[1:0], b[1:0], cin, s[1:0], c[0], cin_last);
cla_adder_2bits cla2(a[3:2], b[3:2], c[0], s[3:2], c[1], cin_last);
cla_adder_2bits cla3(a[5:4], b[5:4], c[1], s[5:4], c[2], cin_last);
cla_adder_2bits cla4(a[7:6], b[7:6], c[2], s[7:6], c[3], cin_last);

assign ovr = c[3] ~^ cin_last;

endmodule

module inverter_8bit
(input [7:0] i,
output [7:0] o);

assign o = ~i;

endmodule

module add_sub_8bit(
  input [7:0] a, b,
  input m, cin,
  output [7:0] s,
  output ovr);

wire [7:0] c;

always @
if (m==1) begin
  assign cin = m;
  inverter_8bit inv1(b, c);
  adder_8bit add1(a, c, cin, s, ovr);
end

endmodule // 

module testModule();

reg [7:0] a, b;
reg cin;

wire [7:0] s;
wire cout, ovr;

add_sub_8bit addsub1(A, B, cin, s, cout, ovr);

initial begin
    $display("Time  A   B   cin  cout  s   ovr");
    $monitor("%3d   %b  %b  %b     %b     %b    %b", $time, A, B, cin, cout, s, ovr);

    A = 8’hFF; B = 8’h01; m = 1’b0;
    A = 8’h7F; B = 8’h01; m = 1’b0;
    A = 8’h01; B = 8’hFF; m = 1’b0;
    A = 8’h55; B = 8’hAA; m = 1’b0;
    A = 8’h80; B = 8’h01; m = 1’b1;
    A = 8’h6C; B = 8’hCA; m = 1’b1;


    $finish;
end

endmodule