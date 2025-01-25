`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:45:50 12/23/2024 
// Design Name: 
// Module Name:    Control_Unit_Top 
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
module Control_Unit_Top (
    input [6:0] Op,           // Opcode: 7 bits
    input [6:0] funct7,       // funct7: 7 bits
    input [2:0] funct3,       // funct3: 3 bits
    output RegWrite,          // Register Write control signal
    output ALUSrc,            // ALU Source control signal
    output MemWrite,          // Memory Write control signal
    output [1:0] ImmSrc,      // Immediate Source control signal
    output [1:0] ResultSrc,   // Result Source control signal
    output Branch,            // Branch control signal
    output [2:0] ALUControl  // ALU Control signal
);

// Internal signal for ALUOp (2 bits)
wire [1:0] ALUOp;

// Instantiating the Main Decoder
Main_Decoder MainDecoder (
    .Op(Op), 
    .RegWrite(RegWrite), 
    .ImmSrc(ImmSrc), 
    .MemWrite(MemWrite), 
    .ResultSrc(ResultSrc), 
    .Branch(Branch), 
    .ALUSrc(ALUSrc), 
    .ALUOp(ALUOp)
);

// Instantiating the ALU Decoder
ALU_Decoder ALUDecoder (
    .ALUOp(ALUOp), 
    .funct3(funct3), 
    .funct7(funct7), 
    .op(Op), 
    .ALUControl(ALUControl)
);

endmodule