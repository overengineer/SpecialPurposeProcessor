`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2018 03:02:18 AM
// Design Name: 
// Module Name: CircularLeftShift
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


module CircularLeftShift(
        input [7:0] a,
        output [7:0] r
    );
    assign r = {a[6:0],a[7]};
endmodule
