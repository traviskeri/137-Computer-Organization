`include "multi_cycle_circuit.v"

module tester();

reg clock, reset, mode, start; 
reg [7:0] a, b, c, d;
wire done;
wire [7:0] result;


multi_cycle_circuit mcc(clock, reset, start, mode, a, b, c, d, done, result);

initial begin
    $monitor("%4d:  done = %b, result: %h", $time, done, result);
    clock = 0;
    reset = 1;
    #120 reset = 0;
end

always
    begin
#5clock = ~clock;
end
initial begin
    //test case 1
    a = 8'h01; b = 8'h02; c = 8'hFF; d = 8'hFE; mode = 1'b0; 
    $display("a: %2h, b: %2h, c: %2h, d: %2h, mode: %b ", a, b, c, d, mode);
    //enter the format to display
    start = 1;  //start the computation
    #20 start = 0; //deactivate start soon after the controller starts but before finishing the task 
    #100  //allocated additional simulation time –more is better than less; if code is wrong more will not help
    
    //test case 2
    a = 8'hFE; b = 8'h01; c = 8'h01; d = 8'h04; mode = 1'b1;
    $display("a: %2h, b: %2h, c: %2h, d: %2h, mode: %b ", a, b, c, d, mode);
    start = 1;
    #20 start = 0;
    #100
    
    //test case 3
    a = 8'h01; b = 8'hFF; c = 8'hFF; d = 8'hFF; mode = 1'b0; 
    $display("a: %2h, b: %2h, c: %2h, d: %2h, mode: %b ", a, b, c, d, mode);
    start = 1;
    #20 start = 0;
    #100
    
    //test case 4
    a = 8'hFF; b = 8'h01; c = 8'h01; d = 8'hFF; mode = 1'b1;
    $display("a: %2h, b: %2h, c: %2h, d: %2h, mode: %b ", a, b, c, d, mode);
    start = 1;
    #20 start = 0;
    #100
    $finish;
end


endmodule