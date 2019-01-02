`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2018 02:56:29 AM
// Design Name: 
// Module Name: ALU
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


module ALU(
        input [7:0] ALUinA, ALUinB,
        input [1:0] InsSel,
        output [7:0] ALUout,
        output CO, Z
    );
    wire [7:0] and_out, xor_out, add_out, shift_out;
    wire add_cout, shift_cout, zero_out;
    
    AND and_inst (.a(ALUinA), .b(ALUinB), .r(and_out));
    XOR xor_inst (.a(ALUinA), .b(ALUinB), .r(xor_out));
    ADD add_inst (.a(ALUinA), .b(ALUinB), .r(add_out), .cout(add_cout));
    CircularLeftShift shift_inst (.a(ALUinA), .r(shift_out));
    ZeroComparator zero_inst (.a(ALUout), .Z(zero_out)); 
    
    wire [7:0] OutMux [3:0];
    assign OutMux[0] = and_out;
    assign OutMux[1] = xor_out;
    assign OutMux[2] = add_out;
    assign OutMux[3] = shift_out;
    assign ALUout    = OutMux[InsSel];
    
    wire [7:0] CoutMux [3:0];
    assign shift_cout = shift_out[0];
    assign CoutMux[0] = 0;
    assign CoutMux[1] = 0;
    assign CoutMux[2] = add_cout;
    assign CoutMux[3] = shift_cout;
    
    assign CO         = CoutMux[InsSel];
    assign Z          = zero_out;
endmodule
