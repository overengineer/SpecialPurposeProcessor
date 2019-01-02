`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2018 04:00:49 AM
// Design Name: 
// Module Name: ZeroComparator
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


module ZeroComparator(
        input [7:0] a,
        output Z
    );
    assign Z = a == 0;
endmodule
