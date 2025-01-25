`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:18:08 12/28/2024
// Design Name:   Pipeline_top
// Module Name:   D:/CSA_Verilog/projectRISC/tb_pipeline.v
// Project Name:  projectRISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Pipeline_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_pipeline;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [31:0] ALU_ResultW;

	// Instantiate the Unit Under Test (UUT)
	Pipeline_top uut (
		.clk(clk), 
		.rst(rst), 
		.ALU_ResultW(ALU_ResultW)
	);

	 // Clock generation
    initial begin
        clk = 0;
        forever #40 clk = ~clk; // Toggle clock every 50 time units
    end

    // Test sequence
    initial begin
        // Initialize Inputs
        rst = 1;
        #50 rst = 0; 
		  

    end
      
endmodule

