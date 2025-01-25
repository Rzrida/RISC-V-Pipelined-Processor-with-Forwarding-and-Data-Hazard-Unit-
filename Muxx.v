`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:47:02 12/23/2024 
// Design Name: 
// Module Name:    Muxx 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Muxx(a, b, s, c);
    // Inputs and Output Declaration
    input [31:0] a, b;   // 32-bit data inputs
    input s;             // 1-bit select input
    output [31:0] c;     // 32-bit output

    // Multiplexer Logic
    assign c = (~s) ? a : b;
endmodule