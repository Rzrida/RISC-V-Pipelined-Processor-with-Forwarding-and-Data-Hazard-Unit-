`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:40:11 12/23/2024 
// Design Name: 
// Module Name:    memory_cycle 
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
module memory_cycle (
    input wire clk, rst,
    input wire RegWriteM, MemWriteM,
	 input   ResultSrcM,
    input wire [4:0] RDM,
    input wire [31:0] PCPlus4M, WriteDataM, ALU_ResultM,
    output reg RegWriteW,
	 output reg  ResultSrcW,
    output reg [4:0] RDW,
    output reg [31:0] PCPlus4W, ALU_ResultW, ReadDataW
);
    // Declaration of intermediate wire
    wire [31:0] ReadDataM;

    // Instantiation of Data Memory module
    Data_Memory dmem (
        .clk(clk), 
        .rst(rst), 
        .WE(MemWriteM), 
        .WD(WriteDataM), 
        .A(ALU_ResultM), 
        .RD(ReadDataM)
    );

    // Memory stage register logic
    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            // Reset logic
            RegWriteW <= 2'b0;
            ResultSrcW <= 1'b0;
            RDW <= 5'h00;
            PCPlus4W <= 32'h00000000;
            ALU_ResultW <= 32'h00000000;
            ReadDataW <= 32'h00000000;
        end else begin
            // Registering inputs to outputs
            RegWriteW <= RegWriteM;
            ResultSrcW <= ResultSrcM;
            RDW <= RDM;
            PCPlus4W <= PCPlus4M;
            ALU_ResultW <= ALU_ResultM;
            ReadDataW <= ReadDataM;
        end
    end
endmodule