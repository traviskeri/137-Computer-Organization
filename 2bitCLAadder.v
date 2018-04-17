//Travis Keri
//
//2-bit CLA adder

module pg_unit_2bits
(input [1:0] a, b,
output [1:0] p, g);

assign p = a ^ b;
assign g = a & b;

endmodule

//===================================================

module cg_unit_2bits
(input [1:0] p, g, 
input cin,
output [1:0] c);

wire nor1, nor2, nor3;

assign c[0] = g[0] | p[0] & cin;

nor n1(nor1, g[1], p[1]);
nor n2(nor2, g[0], g[1], p[0]);
nor n3(nor3, g[0], g[1], c[0]);
nor n4(c[1], nor1, nor2, nor3);

endmodule

//======================================================

module sum_unit_2bits
(input [1:0] p, c,
output [1:0] s);

assign s = p ^ c;

endmodule

//======================================================

module cla_adder_2bits
(input [1:0] a, b,
input cin,
output [1:0] s,
output cout, ovr);

wire [1:0] p, g, c;
assign cout = c[1];

pg_unit_2bits pgu1(a, b, p, g);
cg_unit_2bits cgu1(p, g, cin, c);
sum_unit_2bits su1(p, {c[0], cin}, s);

endmodule

//====================================================

module testModule();

reg [1:0] a, b;
reg cin;

wire [1:0] s;
wire cout, ovr;

cla_adder_2bits cla1(a, b, cin, s, cout, ovr);

initial begin
    $display("Time  a   b   cin  cout  s");
    $monitor("%3d   %b  %b  %b     %b     %b", $time, a, b, cin, cout, s);

    a = 2'b10; b = 2'b10; cin = 0;#1;
    a = 2'b01; b = 2'b10; cin = 1;#1;
    a = 2'b11; b = 2'b01; cin = 0;#1;
    a = 2'b11; b = 2'b01; cin = 0;

    $finish;
end

endmodule
