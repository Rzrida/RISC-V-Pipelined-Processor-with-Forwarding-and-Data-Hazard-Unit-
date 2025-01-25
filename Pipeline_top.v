`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:47:15 12/28/2024 
// Design Name: 
// Module Name:    Pipeline_top 
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
module Pipeline_top(
    input clk, 
    input rst, 
    output [31:0] ALU_ResultW
);
  
  // Declaration of Wires
  wire PCSrcE;
  wire RegWriteE, ALUSrcE, MemWriteE,  BranchE;
  wire RegWriteM, MemWriteM, RegWriteW;
  wire ResultSrcM, ResultSrcW, ResultSrcE;
  wire [2:0] ALUControlE;
  wire [4:0] RDE, RDM, RD_W, RS1_E, RS2_E;
  wire [31:0] PCTargetE, InstrD, PCD, PCPlus4D;
  wire [31:0] ResultW, RD1_E, RD2_E, Imm_Ext_E, PCE, PCPlus4E;
  wire [31:0] PCPlus4M, WriteDataM, ALU_ResultM;
  wire [31:0] PCPlus4W, ReadDataW;
  wire [1:0] ForwardAE, ForwardBE;
  
  // Hazard Detection Unit Signals
  wire StallD;
  
  // Fetch Stage
  fetchreg Fetch (
    .clk(clk),
    .rst(rst),
    .PCSrcE(PCSrcE),
    .PCTargetE(PCTargetE),
    .InstrD(InstrD),    
    .PCD(PCD),
    .PCPlus4D(PCPlus4D),
	 .StallD(StallD)
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
    .RS2_E(RS2_E),
    .StallD(StallD)  // Stall signal from hazard detection unit
  );
  
    // Forwarding Unit
    forwarding_unit Forwarding (
        .RS1E(RS1_E),             // Connected RS1_E from decode stage
        .RS2E(RS2_E),             // Connected RS2_E from decode stage
        .RDM(RDM),
        .RDW(RD_W),
        .RegWriteM(RegWriteM),
        .RegWriteW(RegWriteW),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE)
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
    .ForwardBE(ForwardBE),
	 .StallD(StallD)
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

  // Hazard Detection Unit
  hazard_detection_unit hazard_unit (
    .clk(clk),
    .rst(rst),
	 .op(InstrD[6:0]),
    .RS1_ID(RS1_E), 
    .RS2_ID(RS2_E),
    .RD_EX(RDE),  
    .RD_MEM(RDM), 
    .RD_WB(RD_W),  
    .RegWrite_EX(RegWriteE), 
    .RegWrite_MEM(RegWriteM), 
    .RegWrite_WB(RegWriteW),
    .MemRead_EX(ResultSrcE),
    .StallD(StallD)
  );

endmodule