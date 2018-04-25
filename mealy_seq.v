module mealy_seq
(
    input clock, reset, x,
    output reg z
);

parameter   A = 2'b00,
            B = 2'b01,
            C = 2'b10,
            D = 2'b11;
reg [1:0] current_state, next_state;

//Section iv & v : OG and NSG

always@(*)
//begin
    case(current_state) //case x
    A:      if(x == 1)begin
                next_state = B;
                z = 0;
            end
            else begin
                next_state = A;
                z = 0;
            end
    B:      if(x==1)begin
                next_state = B;
                z = 0;
            end
            else begin
                next_state = C;
                z = 0;
            end
    C:      if(x==1)begin
                next_state = B;
                z = 0;
            end
            else begin
                next_state = D;
                z = 0;
            end
    D:      if(x==1)begin
                next_state = B;
                z = 1;
            end
            else begin
                next_state = A;
                z = 0;
            end
            default     begin
            next_state = 2'bxx;
            z = 1'bx;
                        end
endcase

//section vi. : Flip flops
always@(posedge clock, posedge reset)
begin
        if(reset==1)
            current_state <=A;
        else
            current_state <= next_state;
end
endmodule