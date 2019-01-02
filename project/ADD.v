`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2018 03:01:09 AM
// Design Name: 
// Module Name: ADD
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


module ADD(
        input [7:0] a,b,
        output [7:0] r,
        output cout
    );
    assign {cout, r} = a + b;
endmodule
