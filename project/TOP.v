`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2018 05:41:09 AM
// Design Name: 
// Module Name: TOP
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


module TOP(
        input clk, reset,
        input Start,
        output Busy,
        input [7:0] InA, InB,
        output [7:0] Out
    );
    wire [1:0] InsSel;
    wire CO, Z;
    wire [7:0] CUconst;
    wire [2:0] InMuxAdd;
    wire [3:0] OutMuxAdd, RegAdd;
    wire WE;
    wire [7:0] ALUinA, ALUinB;
    wire [7:0] ALUout;
    CU cu_inst (
            .clk(clk), 
            .reset(reset),
            .Start(Start),
            .Busy(Busy),
            .InsSel(InsSel),
            .CO(CO), 
            .Z(Z), 
            .CUconst(CUconst),
            .InMuxAdd(InMuxAdd),
            .OutMuxAdd(OutMuxAdd), 
            .RegAdd(RegAdd),
            .WE(WE)
    );
    RB rb_inst (
            .clk(clk), 
            .reset(reset),
            .InA(InA), 
            .InB(InB),
            .CUconst(CUconst), 
            .InMuxAdd(InMuxAdd), 
            .OutMuxAdd(OutMuxAdd), 
            .RegAdd(RegAdd),
            .WE(WE),
            .ALUinA(ALUinA), 
            .ALUinB(ALUinB),
            .ALUout(ALUout),
            .Out(Out)
    );
    ALU alu_inst (
            .ALUinA(ALUinA), 
            .ALUinB(ALUinB),
            .InsSel(InsSel),
            .ALUout(ALUout),
            .CO(CO), 
            .Z(Z)
    );
endmodule
