`include "mealy_seq.v"
`include "behave_mealy_seq.v"
module tester();

reg clock, reset, x;
wire z;

mealy_seq  m1(clock, reset, x, z);

initial begin
    $monitor("%4d:  z = %b", $time, z);
    clock = 0;
    reset = 1;
    x = 0;
    #10 reset = 0;
end

always
    begin
#5clock = ~clock; //generates a clock signal with period 10
end

initial begin
#10 x = 1; $display("%4d x = %b", $time, x);
#10 x = 1; $display("%4d x = %b", $time, x);
#10 x = 1; $display("%4d x = %b", $time, x);
#10 x = 0; $display("%4d x = %b", $time, x);
#10 x = 0; $display("%4d x = %b", $time, x);
#10 x = 1; $display("%4d x = %b", $time, x);
#10 x = 1; $display("%4d x = %b", $time, x);
#10 x = 1; $display("%4d x = %b", $time, x);
#10 x = 0; $display("%4d x = %b", $time, x);
#10 x = 0; $display("%4d x = %b", $time, x);
#10 x = 1; $display("%4d x = %b", $time, x);
#10 x = 1; $display("%4d x = %b", $time, x);
#10 x = 0; $display("%4d x = %b", $time, x);
#10 x = 0; $display("%4d x = %b", $time, x);
#10 x = 1; $display("%4d x = %b", $time, x);
#10 $finish;
end
endmodule