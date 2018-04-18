`include "2bitCLAadder.v"
`include "8bitInverter.v"

module adder_8bit
(input [7:0] a, b,
input cin,
output [7:0] s,
output ovr);

wire [7:0] c;
 
cla_adder_2bits cla1(a[1:0], b[1:0], cin, s[1:0], c[1:0]);
cla_adder_2bits cla2(a[3:2], b[3:2], c[0], s[3:2], c[3:2]);
cla_adder_2bits cla3(a[5:4], b[5:4], c[1], s[5:4], c[5:4]);
cla_adder_2bits cla4(a[7:6], b[7:6], c[2], s[7:6], c[7:6]);

assign ovr = c[6] ^ c[7];

endmodule


module add_sub_8bit(
  input [7:0] a, b,
  input m,
  output [7:0] s,
  output ovr, cin);

wire [7:0] c;

inverter_8bit inv1(b, m, c, cin);
adder_8bit add1(a, c, cin, s, ovr);

endmodule 

module testModule();

reg [7:0] a, b;
reg m;

wire [7:0] s;
wire cin, ovr;

add_sub_8bit addsub1(a, b, m, s, ovr, cin);

initial begin
    $display("Time     a        b       m   cin      s        ovr");
    $monitor("%3d   %b  %b  %b     %b     %b    %b", $time, a, b, m, cin, s, ovr);

    a = 8'hFF; b = 8'h01; m = 1'b0;#1;
    a = 8'h7F; b = 8'h01; m = 1'b0;#1;
    a = 8'h01; b = 8'hFF; m = 1'b0;#1;
    a = 8'h55; b = 8'hAA; m = 1'b0;#1;
    a = 8'h80; b = 8'h01; m = 1'b1;#1;
    a = 8'h6C; b = 8'hCA; m = 1'b1;


    $finish;
end

endmodule