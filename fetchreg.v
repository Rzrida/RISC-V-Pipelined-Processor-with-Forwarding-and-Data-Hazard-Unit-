`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:39:47 12/23/2024 
// Design Name: 
// Module Name:    fetchreg 
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
module fetchreg (
    input clk,                // Clock signal
    input rst,                // Reset signal (active high)
    input PCSrcE,             // PC source control signal, selects between PC+4 or PCTargetE
    input [31:0] PCTargetE,   // Target PC value
    //input StallF,
	 input StallD,          // Stall signal for the fetch stage
    output reg [31:0] InstrD, // Instruction output to the next stage
    output reg [31:0] PCD,    // Program Counter output to the next stage
    output reg [31:0] PCPlus4D // PC + 4 output to the next stage
);

    // Internal wires
    wire [31:0] PCF, PCNext, PCPlus4F, InstrF;

    // Internal registers (to hold fetched values)
    reg [31:0] InstrF_reg;
    reg [31:0] PCF_reg, PCPlus4F_reg;

    // Program Counter (updating with next PC value)
    pc Program_Counter (
        .clk(clk), 
        .rst(rst), 
        .PC(PCF), 
        .PC_Next(PCNext)
    );

    // Instruction Memory (fetches instruction at current PC)
    instruction_mem IMEM (
        .rst(rst),
        .clk(clk),
        .A(PCF), 
        .RD(InstrF)
    );

// PC Adder (calculates PC + 4, considering StallF and StallD)
pc_adder PC_adder (
    .a(PCF),           // Current Program Counter value
    .b(32'h00000004),  // Constant value to add (PC + 4)
    .StallD(StallD),   // Stall signal for decode stage
    .c(PCPlus4F)       // Output: PC + 4 value (when not stalled)
);


    // PC Mux (choosing between PC+4 or PCTargetE)
    pc_Mux PC_MUX (
        .a(PCPlus4F), 
        .b(PCTargetE), 
        .s(PCSrcE), 
        .c(PCNext)
    );

    // Fetch Cycle Register Logic (handling pipeline registers and reset)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Initialize all registers to 0 when reset is high
            InstrF_reg <= 32'h00000000;  // Reset instruction
            PCF_reg <= 32'h00000000;     // Reset PC
            PCPlus4F_reg <= 32'h00000000; // Reset PC + 4
        end else if (!StallD) begin
            // Update registers with fetched values when stallF is not active
            InstrF_reg <= InstrF;       // Update instruction register
            PCF_reg <= PCF;             // Update program counter register
            PCPlus4F_reg <= PCPlus4F;   // Update PC + 4 register
        end
    end

    // Output registers logic (if not stalled)
    always @(posedge clk) begin
        if (rst) begin
            InstrD <= 32'h00000000;  // Reset instruction register
            PCD <= 32'h00000000;      // Reset PC
            PCPlus4D <= 32'h00000000; // Reset PC + 4
        end else if (!StallD) begin
            InstrD <= InstrF_reg;    // Update instruction register
            PCD <= PCF_reg;          // Update program counter register
            PCPlus4D <= PCPlus4F_reg; // Update PC + 4 register
        end
    end

endmodule