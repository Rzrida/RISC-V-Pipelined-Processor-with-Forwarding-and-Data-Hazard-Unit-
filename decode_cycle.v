`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:43:09 12/23/2024 
// Design Name: 
// Module Name:    decode_cycle 
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
module decode_cycle(
    input clk, 
    input rst, 
    input [4:0] RDW,
    input [31:0] InstrD, PCD, PCPlus4D, ResultW,
    input StallD,  // Stall signal input
    output RegWriteE, ALUSrcE, MemWriteE, BranchE,
    output  ResultSrcE,
    output [2:0] ALUControlE,
    output [31:0] RD1_E, RD2_E, Imm_Ext_E,
    output [4:0] RS1_E, RS2_E, RD_E,
    output [31:0] PCE, PCPlus4E
);

    // Declare intermediate wires
    wire RegWriteD, ALUSrcD, MemWriteD, ResultSrcD, BranchD;
    wire [1:0] ImmSrcD;
    wire [2:0] ALUControlD;
    wire [31:0] RD1_D, RD2_D, Imm_Ext_D;

    // Declare intermediate registers
    reg RegWriteD_r, ALUSrcD_r, MemWriteD_r, ResultSrcD_r, BranchD_r;
    reg [2:0] ALUControlD_r;
    reg [31:0] RD1_D_r, RD2_D_r, Imm_Ext_D_r;
    reg [4:0] RD_D_r, RS1_D_r, RS2_D_r;
    reg [31:0] PCD_r, PCPlus4D_r;

    Control_Unit_Top control (
        .Op(InstrD[6:0]),          // Operation code from the instruction
        .RegWrite(RegWriteD),      // Register Write signal
        .ImmSrc(ImmSrcD),          // Immediate Source signal
        .ALUSrc(ALUSrcD),          // ALU Source signal
        .MemWrite(MemWriteD),      // Memory Write signal
        .ResultSrc(ResultSrcD),    // Result Source signal
        .Branch(BranchD),          // Branch signal
        .funct3(InstrD[14:12]),    // Function 3 field from the instruction
        .funct7(InstrD[31:25]),    // Function 7 field from the instruction
        .ALUControl(ALUControlD)   // ALU Control signal
    );

    // Register File
    Register_File register_file (
        .clk(clk),
        .rst(rst),
        .WE3(RegWriteE),
        .WD3(ResultW),
        .A1(InstrD[19:15]),
        .A2(InstrD[24:20]),
        .A3(RDW),
        .RD1(RD1_D),
        .RD2(RD2_D)
    );

    // Sign Extend
    Sign_Extend sign_extend (
        .In(InstrD),
        .ImmSrc(ImmSrcD),
        .ImmExt(Imm_Ext_D)
    );

    // Register Logic with StallD consideration
    always @(posedge clk ) begin
        if (rst == 1'b1) begin
            RegWriteD_r <= 1'b0;
            ALUSrcD_r <= 1'b0;
            MemWriteD_r <= 1'b0;
            ResultSrcD_r <= 2'b0;
            BranchD_r <= 1'b0;
            ALUControlD_r <= 3'b000;
            RD1_D_r <= 32'h00000000;
            RD2_D_r <= 32'h00000000;
            Imm_Ext_D_r <= 32'h00000000;
            RD_D_r <= 5'b00000;
            PCD_r <= 32'h00000000;
            PCPlus4D_r <= 32'h00000000;
            RS1_D_r <= 5'b00000;
            RS2_D_r <= 5'b00000;
        end else if (StallD == 1'b1) begin
            // When StallD is asserted, hold previous values
            RegWriteD_r <= RegWriteD_r;
            ALUSrcD_r <= ALUSrcD_r;
            MemWriteD_r <= MemWriteD_r;
            ResultSrcD_r <= ResultSrcD_r;
            BranchD_r <= BranchD_r;
            ALUControlD_r <= ALUControlD_r;
            RD1_D_r <= RD1_D_r;
            RD2_D_r <= RD2_D_r;
            Imm_Ext_D_r <= Imm_Ext_D_r;
            RD_D_r <= RD_D_r;
            PCD_r <= PCD_r;
            PCPlus4D_r <= PCPlus4D_r;
            RS1_D_r <= RS1_D_r;
            RS2_D_r <= RS2_D_r;
        end else begin
            // Update registers with current values when StallD is not asserted
            RegWriteD_r <= RegWriteD;
            ALUSrcD_r <= ALUSrcD;
            MemWriteD_r <= MemWriteD;
            ResultSrcD_r <= ResultSrcD;
            BranchD_r <= BranchD;
            ALUControlD_r <= ALUControlD;
            RD1_D_r <= RD1_D;
            RD2_D_r <= RD2_D;
            Imm_Ext_D_r <= Imm_Ext_D;
            RD_D_r <= InstrD[11:7];
            PCD_r <= PCD;
            PCPlus4D_r <= PCPlus4D;
            RS1_D_r <= InstrD[19:15];
            RS2_D_r <= InstrD[24:20];
        end
    end

    // Output Assignments
    assign RegWriteE = RegWriteD_r;
    assign ALUSrcE = ALUSrcD_r;
    assign MemWriteE = MemWriteD_r;
    assign ResultSrcE = ResultSrcD_r;
    assign BranchE = BranchD_r;
    assign ALUControlE = ALUControlD_r;
    assign RD1_E = RD1_D_r;
    assign RD2_E = RD2_D_r;
    assign Imm_Ext_E = Imm_Ext_D_r;
    assign RD_E = RD_D_r;
    assign PCE = PCD_r;
    assign PCPlus4E = PCPlus4D_r;
    assign RS1_E = RS1_D_r;
    assign RS2_E = RS2_D_r;

endmodule