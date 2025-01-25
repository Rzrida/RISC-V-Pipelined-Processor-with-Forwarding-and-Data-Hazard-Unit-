`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:41:30 12/23/2024 
// Design Name: 
// Module Name:    Register_File 
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
module Register_File (
    input clk,                // Clock signal
    input rst,                // Reset signal
    input WE3,                // Write Enable for register write
    input [4:0] A1,           // Read address 1
    input [4:0] A2,           // Read address 2
    input [4:0] A3,           // Write address
    input [31:0] WD3,         // Write data
    output [31:0] RD1,        // Read data 1
    output [31:0] RD2         // Read data 2
);

    // Register memory: 32 registers of 32 bits each
    reg [31:0] Register [0:31];

    // Write operation
    always @(posedge clk) begin
        if (WE3 && A3 != 5'b00000) begin
            Register[A3] <= WD3; // Write WD3 to Register[A3] if Write Enable is high
        end
    end

    // Read operations
    assign RD1 = (rst == 1'b1) ? 32'b0 : Register[A1]; // Output Register[A1] or 0 if reset
    assign RD2 = (rst == 1'b1) ? 32'b0 : Register[A2]; // Output Register[A2] or 0 if reset

    // Initialize register 0 to 0 at all times
        initial begin
        Register[0] = 32'h00000000;  // Register x0 is always 0
        Register[1] = 32'h00000002;  // Register x1 initialized to 0x00000002
        Register[2] = 32'h00000001;  
        Register[3] = 32'h00000002;
        Register[4] = 32'h00000003;
        Register[5] = 32'h00000004;
        Register[6] = 32'h00000011;
        Register[7] = 32'h00000002;
		  Register[8] = 32'h00000001;  
        Register[9] = 32'h00000002;
        Register[10] = 32'h00000003;
        Register[11] = 32'h00000004;
        Register[12] = 32'h00000001;
        Register[13] = 32'h00000002;
		  		  

        // Add other initializations if needed
    end
endmodule