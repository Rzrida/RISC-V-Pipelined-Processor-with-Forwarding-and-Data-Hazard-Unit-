`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:41:57 12/23/2024 
// Design Name: 
// Module Name:    writeback_cycle 
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
module writeback_cycle (
    input clk, 
    input rst, 
    input  ResultSrcW, 
    input [31:0] PCPlus4W, 
    input [31:0] ALU_ResultW, 
    input [31:0] ReadDataW, 
    output [31:0] ResultW
);

// Instantiate 3-to-1 Multiplexer
Mux_3_by_1 result_mux (
    .a(ALU_ResultW),
    .b(ReadDataW),
    .s(ResultSrcW),
    .out(ResultW)   // Assuming 'out' is the output port of the multiplexer
);

endmodule