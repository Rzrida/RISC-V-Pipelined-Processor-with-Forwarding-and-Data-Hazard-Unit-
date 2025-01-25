`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:44:16 12/23/2024 
// Design Name: 
// Module Name:    Mux_3_by_1 
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
module Mux_3_by_1 (
    input [31:0] a,        // First input
    input [31:0] b,        // Second input
    input  s,         // 2-bit select signal
    output reg [31:0] out  // Output
);

always @(*) begin
    case (s)
        1'b0: out = a;   // Select input 'a'
        1'b1: out = b;   // Select input 'b'
    endcase
end

endmodule