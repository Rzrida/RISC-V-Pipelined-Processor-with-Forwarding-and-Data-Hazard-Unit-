`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:44:37 12/23/2024 
// Design Name: 
// Module Name:    pc 
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
module pc(
    input clk,                // Clock signal
    input rst,                // Reset signal (active low)
    input [31:0] PC_Next,     // Next PC value
    output reg [31:0] PC      // Current PC value
);
    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1)      
            PC <= 32'b0;       
        else
            PC <= PC_Next;     
    end
endmodule