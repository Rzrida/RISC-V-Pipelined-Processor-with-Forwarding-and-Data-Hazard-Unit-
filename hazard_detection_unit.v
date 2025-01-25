`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:09:06 12/28/2024 
// Design Name: 
// Module Name:    hazard_detection_unit 
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
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:00:00 12/23/2024 
// Design Name:    Hazard Detection Unit
// Module Name:    hazard_detection_unit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:    Detect data hazards in a 5-stage pipeline and control forwarding
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module hazard_detection_unit (
    input clk, rst,
    input [6:0] op,
    input [4:0] RS1_ID, RS2_ID, RD_EX, RD_MEM, RD_WB, // Source and destination registers
    input RegWrite_EX, RegWrite_MEM, RegWrite_WB,    // Write enable signals
    input MemRead_EX, // Flag indicating if EX stage is a memory read (prevents forwarding)
    output reg StallD // Stall signal for IF and ID stages
);

    reg stall_next; // Temporary signal to hold the stall value for the next cycle

    // Hazard detection logic
    always @(*) begin
        // Default values (no hazards detected)
        stall_next = 0;
		
        if(MemRead_EX) begin
		  stall_next = 1;
		  end

        // Branch instruction stall
        if (op == 7'b1100011) begin
            stall_next = 1;
        end
    end

    // Update StallD with clock
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            StallD <= 0; // Reset stall signal
        end else begin
            if (StallD == 1) begin
                StallD <= 0; // Clear stall after one cycle
            end else begin
                StallD <= stall_next; // Update stall based on hazard detection
            end
        end
    end

endmodule

