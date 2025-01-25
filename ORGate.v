`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:40:40 12/23/2024 
// Design Name: 
// Module Name:    ORGate 
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
module ORGate(
    input wire A,      // First input
    input wire B,      // Second input
    output wire Y      // Output
);
    assign Y = A || B;  // AND operation
endmodule
