`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:47:10 12/25/2024
// Design Name:   Pipeline_top2
// Module Name:   D:/CSA_Verilog/projectRISC/tb_pipeline2.v
// Project Name:  projectRISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Pipeline_top2
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_pipeline2;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [31:0] ALU_ResultW;

	// Instantiate the Unit Under Test (UUT)
	Pipeline_top2 uut (
		.clk(clk), 
		.rst(rst), 
		.ALU_ResultW(ALU_ResultW)
	);

	 // Clock generation
    initial begin
        clk = 0;
        forever #50 clk = ~clk; // Toggle clock every 50 time units
    end

    // Test sequence
    initial begin
        // Initialize Inputs
        rst = 1;
        #100 rst = 0; 
		  
		  #4000;

    end
      
endmodule

