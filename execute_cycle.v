`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:46:13 12/23/2024 
// Design Name: 
// Module Name:    execute_cycle 
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
module execute_cycle (
    input clk, rst, RegWriteE, ALUSrcE, MemWriteE, BranchE,
    input  ResultSrcE,
    input [2:0] ALUControlE,
    input [31:0] RD1E, RD2E, ImmExtE, PCE, PCPlus4E,
    input [4:0] RDE,
	 input StallD,
    input [1:0]  ForwardAE, ForwardBE, // Forwarding signals for ALU
    output PCSrcE, RegWriteM, MemWriteM,
    output ResultSrcM,
    output [4:0] RDM,
    output [31:0] PCPlus4M, WriteDataM, ALUResultM, PCTargetE
);
    // Declaration of Wires
    wire [31:0] SrcB; 
    wire [31:0] ResultE; 
    wire ZeroE, ANDout, ORResult;
    reg ORResult_reg;
	 

    // Declaration of Registers
    reg RegWriteE_r, MemWriteE_r;
    reg  ResultSrcE_r;
    reg [4:0] RDE_r;
    reg [31:0] PCPlus4E_r, ResultE_r;

    // Forwarding Unit - Instantiating the forwarding unit
    wire [31:0] ALUInA, ALUInB;

   

    // MUX for ALU Input A (Forwarding logic for ALU operand A)
    assign ALUInA = (ForwardAE == 2'b00) ? RD1E : 
                    (ForwardAE == 2'b01) ? ALUResultM : 
                    (ForwardAE == 2'b10) ? WriteDataM : 
                    RD1E;  // Default, avoid multiple assignments

    // MUX for ALU Input B (Forwarding logic for ALU operand B)
    assign SrcB = (ALUSrcE) ? ImmExtE : RD2E;
    assign ALUInB = (ForwardBE == 2'b00) ? SrcB : 
                    (ForwardBE == 2'b01) ? ALUResultM : 
                    (ForwardBE == 2'b10) ? WriteDataM : 
                    SrcB;  // Default, avoid multiple assignments

    // ALU Module
    ALU alu (
        .A(ALUInA),      // Forwarded or original value for operand A
        .B(ALUInB),      // Forwarded or original value for operand B
        .Result(ResultE), // ALU computation result
        .ALUControl(ALUControlE),
        .OverFlow(),
        .Carry(),
        .Zero(ZeroE),
        .Negative()
    );

    // Branch Adder
    pc_adder branch_adder (
        .a(PCE),
        .b(ImmExtE),
        .c(PCTargetE),
		  .StallD(StallD)
    );

    // AND Gate for PCSrcE condition
    ANDGate and_gate (
        .A(ZeroE),
        .B(BranchE),
        .Y(ANDout)
    );

    // OR Gate for final result of PCSrcE
    ORGate or_gate (
        .A(ANDout),
        .B(0), // No jump condition used
        .Y(ORResult)
    );

    // Register Logic
    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            ORResult_reg <= 1'b0;
            RegWriteE_r <= 1'b0;
            MemWriteE_r <= 1'b0;
            ResultSrcE_r <= 2'b0;
            RDE_r <= 5'b00000;
            PCPlus4E_r <= 32'h00000000;
            ResultE_r <= 32'h00000000;
				
        end else begin
            ORResult_reg <= ORResult;
            RegWriteE_r <= RegWriteE;
            MemWriteE_r <= MemWriteE;
            ResultSrcE_r <= ResultSrcE;
            RDE_r <= RDE;
            PCPlus4E_r <= PCPlus4E;
            ResultE_r <= ResultE;
				
        end
    end

    // Output Assignments
    assign PCSrcE = ORResult_reg;  
    assign RegWriteM = RegWriteE_r;
    assign MemWriteM = MemWriteE_r;
    assign ResultSrcM = ResultSrcE_r;
    assign RDM = RDE_r;
    assign PCPlus4M = PCPlus4E_r;
    assign WriteDataM = RD2E;
    assign ALUResultM = ResultE_r;

endmodule
