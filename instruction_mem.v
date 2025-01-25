`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:43:54 12/23/2024 
// Design Name: 
// Module Name:    instruction_mem 
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
module instruction_mem (
    input rst, 
    input clk, 	 // Reset signal
    input [31:0] A,              // Address input
    output reg [31:0] RD             // Read data (instruction)
);
    // Memory array: 128 words of 32-bit memory
    reg [31:0] mem [1023:0]; 
integer i;
    // Initialize memory with instructions
    initial begin
        
        for (i = 0; i <= 1023; i = i + 1) begin
            mem[i] = 32'b0;
        end

        // Load instructions into specific memory locations
		  mem[0] = 32'h00008133; // add x2, x1, x0 // 0000000_00000_00001_000_00010_0110011
		  mem[1] = 32'h00410283; // lw x6, 4(x2)   //000000000100_00010_000_00101_0000011
        mem[2] = 32'h0041F133; // and x2, x3, x4 // 0000000_00100_00011_111_00010_0110011
		  mem[3] = 32'h00110263; // branch x1, x2, 4 //0000000_00001_00010_000_00100_1100011
    
        // Add more instructions as needed
    end

    // Assign read data based on address and reset
	 always @(posedge clk or posedge rst) begin
    if (rst) begin
        RD <= 32'h00000000;  
    end else begin
        RD <= mem[A[31:2]];       // Update instruction register
		
    end
end


endmodule