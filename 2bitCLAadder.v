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
output [1:0] s, c);

wire [1:0] p, g, c;
assign cout = c[1];

pg_unit_2bits pgu1(a, b, p, g);
cg_unit_2bits cgu1(p, g, cin, c);
sum_unit_2bits su1(p, {c[0], cin}, s);

endmodule

