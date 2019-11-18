`timescale 1ns / 1ps
module BHT(
    output reg [3:0]xxlsb,           // for simulation only
    output reg [3:0]xxmsb,           // for simulation only
    output reg [1:0] laststates,     // for simulation only
    input outcome,                   // actual outcome whether the state was taken or not taken
    input pred_mode,                 
    input branch_mode,
    input reset,                     //these represent the 4 mpdes of operation
    input display,
    output reg [7:0]disp             // this register displays the FSM status of the 4 entries in BHT 
    );
reg [3:0]xxlsb;             //for implementation on hardware; represent the LSB bits of FSM status of corresponding 4 entries(NN,NT,TN,TT) in BHT
reg [3:0]xxmsb;             //for implementation on hardware; represent the MSB bits of FSM status of corresponding 4 entries(NN,NT,TN,TT) in BHT
reg [1:0] laststates;       //for implementation on hardware; represents the last two states in BHT
initial laststates <= 2'b00;        // initializing the last two states
initial xxlsb <= 4'b1100;           
initial xxmsb <= 4'b1100;           // initializing the FSM status of the BHT entries with binary values
always @(*)
begin
if(pred_mode)               //when in prediction mode
    begin
        case(laststates)
            2'b00: disp <= xxmsb[0];
            2'b01: disp <= xxmsb[1];        //only one led glowing or not(1/0) represents prediction as taken or not
            2'b10: disp <= xxmsb[2];
            2'b11: disp <= xxmsb[3];
    endcase
    end
else if(display)            //when in display mode
    begin
        disp <= {xxlsb[0],xxmsb[0],xxlsb[1],xxmsb[1],xxlsb[2],xxmsb[2],xxlsb[3],xxmsb[3]};
    end
end
always @(posedge branch_mode or posedge reset)
begin
if(reset)           //when in reset mode
    begin
        xxlsb <= 4'b1100;
        xxmsb <= 4'b1100;
        laststates <= 2'b00;
    end
else if(branch_mode)        //when in branch mode
    begin
        case(laststates)
            2'b00: begin               
                        xxmsb[0] <= ((~xxmsb[0]) & ((xxmsb[0] & (~xxlsb[0]) & (~outcome)) | ((~xxmsb[0]) & xxlsb[0] & outcome))) |
                                    (xxmsb[0] & ~((xxmsb[0] & (~xxlsb[0]) & (~outcome)) | ((~xxmsb[0]) & xxlsb[0] & outcome)));
                        xxlsb[0] <= outcome;
                   end
            2'b01: begin               
                        xxmsb[1] <= ((~xxmsb[1]) & ((xxmsb[1] & (~xxlsb[1]) & (~outcome)) | ((~xxmsb[1]) & xxlsb[1] & outcome))) |
                                    (xxmsb[1] & ~((xxmsb[1] & (~xxlsb[1]) & (~outcome)) | ((~xxmsb[1]) & xxlsb[1] & outcome)));
                        xxlsb[1] <= outcome;
                   end
            2'b10: begin               
                        xxmsb[2] <= ((~xxmsb[2]) & ((xxmsb[2] & (~xxlsb[2]) & (~outcome)) | ((~xxmsb[2]) & xxlsb[2] & outcome))) |
                                    (xxmsb[2] & ~((xxmsb[2] & (~xxlsb[2]) & (~outcome)) | ((~xxmsb[2]) & xxlsb[2] & outcome)));
                        xxlsb[2] <= outcome;
                   end
            2'b11: begin               
                        xxmsb[3] <= ((~xxmsb[3]) & ((xxmsb[3] & (~xxlsb[3]) & (~outcome)) | ((~xxmsb[3]) & xxlsb[3] & outcome))) |
                                    (xxmsb[3] & ~((xxmsb[3] & (~xxlsb[3]) & (~outcome)) | ((~xxmsb[3]) & xxlsb[3] & outcome)));
                        xxlsb[3] <= outcome;
                   end
        endcase            
        laststates <= {laststates[0],outcome};                                 
    end
end
endmodule
