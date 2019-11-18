`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 05.11.2019 19:58:12
// Design Name:
// Module Name: test
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module test();
reg pred_mode;
reg branch_mode;   //these are the input registers which decide the mode of operation
reg reset;
reg display;
reg outcome;        //this stores the actual outcome whether the branch was taken or not
wire [1:0]ls;
wire [7:0]led;      // these LEDs display the FSM status of the Branch History Table(BHT) contents
wire [3:0]lsb;      // Represent the LSB of the FSM status corresponding to 4 entries(NN,NT, TN,TT) in the BHT
wire [3:0]msb;      // Represent the MSB of the FSM status corresponding to 4 entries (NN,NT,TN,TT) in the BHT
BHT x(.laststates(ls),.xxlsb(lsb),.xxmsb(msb),.outcome(outcome),.pred_mode(pred_mode),.branch_mode(branch_mode),.reset(reset),
    .display(display),.disp(led));
initial pred_mode <= 0;
initial branch_mode <= 0;
initial reset <= 0;
initial display <= 1;
initial outcome <= 0;
always #15
begin
branch_mode <= ~branch_mode;    //create pulses for inputs
end
always #10
begin
outcome <= $random;
end
always #100 begin
reset <= ~reset;
#2 reset <= ~reset;
end
//always #5 pred_mode <= ~pred_mode;
endmodule
