`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:41:01 12/23/2024 
// Design Name: 
// Module Name:    pc_Mux 
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
module pc_Mux (
    input wire [31:0] a,        // Input PCPlus4F
    input wire [31:0] b,        // Input PCTargetE
    input wire s,               // Select signal (PCSrcE)
    output wire [31:0] c        // Output PCNext
);
    // Multiplexer logic
    assign c = (s) ? b : a;
	 
endmodule