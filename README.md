# RISC-V-Pipelined-Processor-with-Forwarding-and-Data-Hazard-Unit-

Project Objectives:
1. Design a Pipelined Processor: Create a pipelined processor in Verilog that demonstrates 
forwarding and stalling techniques to handle data hazards efficiently.
2. Implement Forwarding and Stalling: Implement forwarding to bypass data between 
pipeline stages and stalling when forwarding is not possible (e.g., load-use hazards).
3. Handle Pipeline Hazards: Ensure the processor can detect and resolve data and control 
hazards to maintain smooth instruction execution.
4. Verilog Code and Testbench: Develop the Verilog code for the processor and a testbench 
to validate its functionality.
5. Report Documentation: Provide a concise report detailing the design, Verilog 
implementation, and test results.
Project Description:
This project involves designing a pipelined processor in Verilog to demonstrate both data 
forwarding and stalling. The processor will use an ISA (RISC-V) and manage hazards like data 
dependencies and control hazards.
• Forwarding: Forward intermediate results between pipeline stages to reduce delays.
• Stalling: Introduce pipeline stalls when forwarding isn't sufficient, such as for load-use 
hazards.
The processor will be designed at the Register Transfer Level (RTL), and a testbench will be 
used to verify the correct operation of both forwarding and stalling mechanisms.
Software Used: The Xilinx ISE (Integrated Synthesis Environment) is a comprehensive 
software suite that supports digital logic design, especially for FPGA-based lab tasks using 
Verilog. It enables students to write, simulate, synthesize, and implement Verilog code, 
streamlining the design workflow from initial code entry to real-time testing on FPGA hardware. 
ISE’s tools for simulation and synthesis help verify and optimize designs before physical 
deployment, making it an essential tool for efficiently turning Verilog code into functioning digital 
circuits in the lab.
