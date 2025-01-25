`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:25:07 12/28/2024 
// Design Name: 
// Module Name:    Forwarding_Unit 
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
module forwarding_unit (
    input [4:0] RS1E, RS2E, // Source registers in Execute stage
    input [4:0] RDM, RDW,  // Destination registers in Memory and Write-back stages
    input RegWriteM, RegWriteW, // Register write enable signals
    output reg [1:0] ForwardAE, ForwardBE // Forwarding controls
);
    always @(*) begin
        // ForwardAE logic
        if (RegWriteM && (RDM != 0) && (RDM == RS1E))
            ForwardAE = 2'b10; // Forward from Memory stage
        else if (RegWriteW && (RDW != 0) && (RDW == RS1E))
            ForwardAE = 2'b01; // Forward from Write-back stage
        else
            ForwardAE = 2'b00; // No forwarding

        // ForwardBE logic
        if (RegWriteM && (RDM != 0) && (RDM == RS2E))
            ForwardBE = 2'b10; // Forward from Memory stage
        else if (RegWriteW && (RDW != 0) && (RDW == RS2E))
            ForwardBE = 2'b01; // Forward from Write-back stage
        else
            ForwardBE = 2'b00; // No forwarding
    end
endmodule