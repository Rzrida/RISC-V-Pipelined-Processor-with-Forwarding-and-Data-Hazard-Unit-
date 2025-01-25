`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:45:26 12/23/2024 
// Design Name: 
// Module Name:    ALU 
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
module ALU (
    input [31:0] A, B,           // 32-bit operands A and B
    input [2:0] ALUControl,      // ALU Control signal (3 bits)
    output reg [31:0] Result,    // ALU result
    output OverFlow, Carry, Zero, Negative
);

    wire [31:0] AddSubResult;
    wire AddSubCout;

    // Add/Subtract Logic
    assign {AddSubCout, AddSubResult} = 
        (ALUControl == 3'b000) ? A + B :          // Addition
        (ALUControl == 3'b001) ? A - B :          // Subtraction
        33'b0;                                    // Default (if not add/subtract)

    // Overflow Detection
    assign OverFlow = 
        ((ALUControl == 3'b000 && (A[31] == B[31]) && (AddSubResult[31] != A[31])) || // Add Overflow
        (ALUControl == 3'b001 && (A[31] != B[31]) && (AddSubResult[31] != A[31])));  // Sub Overflow

    // Carry Detection
    assign Carry = (ALUControl == 3'b000 || ALUControl == 3'b001) ? AddSubCout : 1'b0;

    // Zero Flag
    assign Zero = (Result == 32'b0);

    // Negative Flag
    assign Negative = Result[31];

    // ALU Operations
    always @(*) begin
        case (ALUControl)
            3'b000: Result = AddSubResult;            // Addition
            3'b001: Result = AddSubResult;            // Subtraction
            3'b010: Result = A & B;                  // AND
            3'b011: Result = A | B;                  // OR
            3'b100: Result = A ^ B;                  // XOR
            3'b101: Result = ~(A | B);               // NOR
            3'b110: Result = ~(A & B);               // NAND
            3'b111: Result = (A < B) ? 32'b1 : 32'b0; // Set on Less Than (SLT)
            default: Result = 32'b0;                 // Default case
        endcase
    end
endmodule
