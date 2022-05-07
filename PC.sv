`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2020 11:09:29 AM
// Design Name: 
// Module Name: PC
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


module PC(
input [31:0] DIN,
output logic [31:0]  DOUT = 0,
input CLK, RESET, PC_WRITE

    );
    always_ff@(posedge CLK)
     begin
         if(RESET == 1)
             DOUT = 0;
         else if(PC_WRITE)
             DOUT = DIN; 
   end
    
    
endmodule
