`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:48:33 12/23/2024 
// Design Name: 
// Module Name:    Sign_Extend 
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
module Sign_Extend (
    input [31:0] In,          // Input immediate bits
    input [1:0] ImmSrc,       // Immediate source selection
    output reg [31:0] ImmExt  // Extended immediate value
);

    // Generate extended immediate based on ImmSrc
    always @(*) begin
        case (ImmSrc)
            // I-type Immediate (12-bit sign-extended)
            2'b00: ImmExt = {{20{In[31]}}, In[31:20]};  // Extract bits [31:20]

            // S-type Immediate (12-bit sign-extended for Store)
            2'b01: ImmExt = {{20{In[31]}}, In[31:25], In[11:7]}; // Combines upper and lower parts

            // B-type Immediate (Branch - combines fields and shifts left by 1)
            2'b10: ImmExt = {{19{In[31]}}, In[7], In[30:25], In[11:8], 1'b0};

            // U-type Immediate (20-bit upper immediate, zero-extended)
            2'b11: ImmExt = {In[31:12], 12'b0};  // Upper 20 bits, zero-extended

            // Default case for debugging
            default: ImmExt = 32'hDEADBEEF;    
        endcase
    end

endmodule

