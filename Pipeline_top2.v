`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:45:31 12/25/2024 
// Design Name: 
// Module Name:    Pipeline_top2 
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
module Pipeline_top2(
    input clk, 
    input rst, 
    output [31:0] ALU_ResultW
);
  
  // Declaration of Wires
  wire PCSrcE;
 

  wire RegWriteE, ALUSrcE, MemWriteE,  BranchE;
  wire RegWriteM, MemWriteM, RegWriteW;
  wire[1:0]  ResultSrcM, ResultSrcW, ResultSrcE;
  wire [2:0] ALUControlE;
  wire [4:0] RDE, RDM, RD_W, RS1_E, RS2_E;
  wire [31:0] PCTargetE, InstrD, PCD, PCPlus4D;
  wire [31:0] ResultW, RD1_E, RD2_E, Imm_Ext_E, PCE, PCPlus4E;
  wire [31:0] PCPlus4M, WriteDataM, ALU_ResultM;
  wire [31:0] PCPlus4W, ReadDataW;
  wire [1:0] ForwardAE, ForwardBE;

  // Fetch Stage
  fetchreg Fetch (
    .clk(clk),
    .rst(rst),
    .PCSrcE(PCSrcE),
	 //.PCSrcE(0),
    .PCTargetE(PCTargetE),
    .InstrD(InstrD),    
    .PCD(PCD),
    .PCPlus4D(PCPlus4D)
  );

  // Decode Stage
  decode_cycle Decode (
    .clk(clk),
    .rst(rst),
    .InstrD(InstrD),
    .PCD(PCD),
    .PCPlus4D(PCPlus4D),
    .RDW(RD_W), 
    .ResultW(ResultW),
    .RegWriteE(RegWriteE),
    .ALUSrcE(ALUSrcE),
    .MemWriteE(MemWriteE),
    .ResultSrcE(ResultSrcE),
    .BranchE(BranchE),
    .ALUControlE(ALUControlE),
    .RD1_E(RD1_E),
    .RD2_E(RD2_E),
    .Imm_Ext_E(Imm_Ext_E),
    .RD_E(RDE),
    .PCE(PCE),
    .PCPlus4E(PCPlus4E),
    .RS1_E(RS1_E),
    .RS2_E(RS2_E)
  );
  
   Forwarding_Unit forwarding_unit (
        .RS1_ID(RDE), 
        .RS2_ID(RDE), 
        .RD_EX(RDE),  
        .RD_MEM(RDE), 
        .RD_WB(RDE),  
        .RegWrite_EX(RegWriteE), 
        .RegWrite_MEM(MemWriteE), 
        .RegWrite_WB(RegWriteE),
        .ForwardA(ForwardAE_reg), 
        .ForwardB(ForwardBE_reg) 
    );

  // Execute Stage
  execute_cycle Execute (
    .clk(clk),
    .rst(rst),
    .ALUSrcE(ALUSrcE),
    .RegWriteE(RegWriteE),
    .MemWriteE(MemWriteE),
    .ResultSrcE(ResultSrcE),
    .BranchE(BranchE),
    .ALUControlE(ALUControlE),
    .RD1E(RD1_E),
    .RD2E(RD2_E),
    .ImmExtE(Imm_Ext_E),
    .RDE(RDE),
    .PCE(PCE),
    .PCPlus4E(PCPlus4E),
    .PCSrcE(PCSrcE),
    .PCTargetE(PCTargetE),
    .RegWriteM(RegWriteM),
    .MemWriteM(MemWriteM),
    .PCPlus4M(PCPlus4M),
    .WriteDataM(WriteDataM),
    .ALUResultM(ALU_ResultM),
    .ResultSrcM(ResultSrcM),
    .RDM(RDM),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE)
  );

  // Memory Stage
  memory_cycle Memory (
    .clk(clk),
    .rst(rst),
    .RegWriteM(RegWriteM),
    .MemWriteM(MemWriteM),
    .ResultSrcM(ResultSrcM),
    .RDM(RDM),
    .PCPlus4M(PCPlus4M),
    .WriteDataM(WriteDataM),
    .ALU_ResultM(ALU_ResultM),
    .RegWriteW(RegWriteW),
    .ResultSrcW(ResultSrcW),
    .RDW(RD_W),
    .PCPlus4W(PCPlus4W),
    .ALU_ResultW(ALU_ResultW),
    .ReadDataW(ReadDataW)
  );

  // Write Back Stage
  writeback_cycle WriteBack (
    .clk(clk),
    .rst(rst),
    .ResultSrcW(ResultSrcW),
    .PCPlus4W(PCPlus4W),
    .ALU_ResultW(ALU_ResultW),
    .ReadDataW(ReadDataW),
    .ResultW(ResultW)
  );


endmodule
