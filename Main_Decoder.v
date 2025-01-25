`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:46:36 12/23/2024 
// Design Name: 
// Module Name:    Main_Decoder 
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
module Main_Decoder (
    input [6:0] Op,             // Opcode (7 bits)
    output RegWrite,            // Register Write control signal
    output ALUSrc,              // ALU Source control signal
    output MemWrite,            // Memory Write control signal
    output [1:0] ImmSrc,        // Immediate Source control signal
    output ResultSrc,     // Result Source control signal
    output Branch,              // Branch control signal
    output [1:0] ALUOp          // ALU Operation control signal
);

assign RegWrite = (Op == 7'b0110011) || // R-Type
                  (Op == 7'b0010011) || // I-Type
                  (Op == 7'b0000011);   // Load

assign ImmSrc = (Op == 7'b0100011) ? 2'b01 :  // S-Type
                (Op == 7'b1100011) ? 2'b10 :  // B-Type
                2'b00;                        // Default

assign ALUSrc = (Op == 7'b0000011) ||         // Load
                (Op == 7'b0100011) ||         // Store
                (Op == 7'b0010011);           // I-Type

assign MemWrite = (Op == 7'b0100011) ? 1'b1 : 1'b0; // Store

assign ResultSrc = (Op == 7'b0000011) ? 1'b1 : // Load
                   1'b0;                      // Default

assign Branch = (Op == 7'b1100011) ? 1'b1 : 1'b0; // Branch

assign ALUOp = (Op == 7'b0110011) ? 2'b10 :     // R-Type
               (Op == 7'b1100011) ? 2'b01 :     // Branch
               2'b00;                          // Default (Load/Store)

endmodule