`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:39:20 12/23/2024 
// Design Name: 
// Module Name:    Data_Memory 
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
module Data_Memory (
    input wire clk,           // Clock signal
    input wire rst,           // Reset signal
    input wire WE,            // Write Enable signal
    input wire [31:0] A,      // Address input
    input wire [31:0] WD,     // Write Data input
    output reg [31:0] RD      // Read Data output
);
    // Memory array of 1024 32-bit words
    reg [31:0] mem [1023:0];

    // Synchronous write block
    always @(posedge clk) begin
        if (WE) begin
            mem[A] <= WD;     // Write to memory if WE is high
        end
    end

    // Combinational read block
    always @(*) begin
        if (rst) begin
            RD = 32'd0;       // Reset RD to 0 when rst is high
        end else begin
            RD = mem[A];      // Read memory otherwise
        end
    end

    // Initialize memory
    initial begin
        mem[0] = 32'h00000000;
		  mem[4] = 32'h00000001;
		  mem[8] = 32'h00000020;
		  mem[12] = 32'h00000030;
		  mem[16] = 32'h00000004;
		  mem[20] = 32'h00000004;
		  mem[24] = 32'h00000004;
		  mem[28] = 32'h00000004;
        mem[40] = 32'h00000002;
    end
endmodule