`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2020 01:16:57 PM
// Design Name: 
// Module Name: Lab1TopModual
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Lab1TopModual(
    input [31:0]  jalr, branch, jal,
    input [1:0] select,
    input CLK, RESET, PC_WRITE, MEM_READ1,
    output logic [31:0] Dout, PC_4
    );
    logic [31:0] T1, T2, T3;
    
    Mux4_1 Mux1( .IN( {  jal, branch,jalr, T3}) , .select(select), .OUT(T1));
    PC PC1(.DIN(T1),.CLK(CLK),.RESET(RESET), .PC_WRITE(PC_WRITE), .DOUT(T2));
    OTTER_mem_byte men1(.MEM_READ1(MEM_READ1), .MEM_ADDR1(T2), .MEM_CLK(CLK), .MEM_DOUT1(Dout));
    assign T3 = T2+4;
    assign   PC_4 = T3; 
    
endmodule
