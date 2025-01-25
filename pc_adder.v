`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:47:43 12/23/2024 
// Design Name: 
// Module Name:    pc_adder 
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
module pc_adder(
    input [31:0] a, b,           // Inputs: PC value (a) and offset (b)
    input StallD,        // Stall signals for Fetch and Decode stages
    output reg [31:0] c          // Output: Result of PC + offset
);

    // If either StallF or StallD is high, don't perform addition
    always @(*) begin
        if (StallD) begin
            c = c;  // Retain the previous value of c (no update when stalled)
        end else begin
            c = a + b;  // Perform the addition when no stall
        end
    end

endmodule