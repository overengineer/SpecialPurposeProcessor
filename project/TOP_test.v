`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2018 05:54:06 AM
// Design Name: 
// Module Name: TOP_test
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


module TOP_test;
    reg clk, reset;
    reg Start;
    wire Busy;
    reg [7:0] InA, InB;
    wire [7:0] Out;
    TOP dut(
            .clk(clk), 
            .reset(reset),
            .Start(Start),
            .Busy(Busy),
            .InA(InA), 
            .InB(InB),
            .Out(Out)
    );
    always begin
        clk = ~clk;
        #10;
    end
    initial begin
        {clk,reset} = 0;
        InA = 8'hF0; InB = 8'h0F;
        reset = 1;
        #20;
        reset = 0;
    end
    always @(posedge clk) begin
        Start = ~Busy;
    end
    always @(negedge Busy) begin
        InA <= InA + 1;
        InB <= InB - 1;
    end
endmodule
