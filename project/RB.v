`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2018 03:02:57 AM
// Design Name: 
// Module Name: RB
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


module RB(
        input clk, reset,
        input [7:0] InA, InB,
        input [7:0] CUconst, 
        input [2:0] InMuxAdd, 
        input [3:0] OutMuxAdd, RegAdd,
        input WE,
        output [7:0] ALUinA, ALUinB,
        input [7:0] ALUout,
        output [7:0] Out
    );
        parameter N_REGISTERS = 16;
        parameter DATA_WIDTH  = 8;
        reg [DATA_WIDTH-1:0] register_file [N_REGISTERS-1:0];
        wire [DATA_WIDTH-1:0] RegIn, RegOut;
        
        wire [DATA_WIDTH-1:0] InMux [7:0];
        assign InMux[0] = InA;
        assign InMux[1] = InB;
        assign InMux[2] = CUconst;
        assign InMux[3] = ALUout;
        assign InMux[4] = RegOut;
        assign InMux[5] = RegOut;
        assign InMux[6] = RegOut;
        assign InMux[7] = RegOut;
        
        assign Out      = register_file[0];
        assign ALUinA   = register_file[1];
        assign ALUinB   = register_file[2];
        
        assign RegIn  = InMux[InMuxAdd];
        assign RegOut = register_file[OutMuxAdd];
        
        integer i;
        always @( posedge clk or posedge reset ) begin
            if ( reset ) begin
                for (i=0; i<N_REGISTERS; i=i+1) begin
                    register_file[i] = 0;
                end
            end else begin
                if ( WE ) begin
                    register_file[RegAdd] <= RegIn;
                end
            end
        end
endmodule
