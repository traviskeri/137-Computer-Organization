module control_unit
(
    input clock, reset, start, mode,
    output reg d,
    output reg [3:0] out
);


parameter   A = 2'b00,
            B = 2'b01,
            C = 2'b10,
            D = 2'b11;
reg [1:0] current_state, next_state;

always@(*)
begin
    case(current_state)
    A:      if(start == 1)begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
    B:      next_state = C;
    C:      next_state = D;
    D:      next_state = A;
            
    endcase
end

//OG
always@(*)
    case(current_state)
    A:  begin 
        out[3:0] = 0; 
        d = 0;
        end
    B:  begin
        out[0] = 0;
        out[1] = 1;
        out[2] = 0;
        out[3] = 0;
        d = 0; 
        end
    C:  begin
        out[0] = 0;
        out[1] = 1;
        out[2] = 1;
        out[3] = 0;
        d = 0; 
        end
    D:  if (mode ==0)begin
            out[0] = 0;
            out[1] = 1;
            out[2] = 0;
            out[3] = 1;
            d = 1;
        end
        else begin
            out[0] = 1;
            out[1] = 1;
            out[2] = 0;
            out[3] = 1;
            d = 1;
        end
    endcase



always@(posedge clock, posedge reset)
begin
        if(reset==1)
            current_state <=A;
        else
            current_state <= next_state;
end
endmodule