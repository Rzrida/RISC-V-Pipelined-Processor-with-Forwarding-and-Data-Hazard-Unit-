`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:38:34 12/23/2024 
// Design Name: 
// Module Name:    ALU_Decoder 
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
module ALU_Decoder (
    input [1:0] ALUOp,          // ALU Operation control signal (2 bits)
    input [2:0] funct3,         // Instruction funct3 field (3 bits)
    input [6:0] funct7,         // Instruction funct7 field (7 bits)
    input [6:0] op,             // Opcode (7 bits)
    output reg [2:0] ALUControl // ALU Control signal (3 bits)
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUControl = 3'b000; // Default: ADD (e.g., for load/store)
        2'b01: ALUControl = 3'b010; // SUBTRACT (e.g., for branch)
        2'b10: begin
            casez ({funct7[5], funct3})
                4'b0_000: ALUControl = 3'b000; // ADD  -> ALUControl = 3'b000
                4'b1_000: ALUControl = 3'b001; // SUB -> ALUControl = 3'b001
                4'b0_111: ALUControl = 3'b010; // AND
                4'b0_110: ALUControl = 3'b011; // OR
                4'b0_100: ALUControl = 3'b100; // XOR
                4'b0_101: ALUControl = 3'b101; // NOR
                4'b0_010: ALUControl = 3'b110; // NAND
                default:  ALUControl = 3'bxxx; // Undefined
            endcase
        end
        default: ALUControl = 3'bxxx; // Undefined
    endcase
end

endmodule

