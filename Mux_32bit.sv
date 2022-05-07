`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2020 10:45:45 AM
// Design Name: 
// Module Name: Mux4_1
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


module Mux4_1(
input [31:0] IN_0, IN_1, IN_2, IN_3,
output logic [31:0]  OUT,
input logic [1:0] select
    );
     always_comb
    begin
       case(select)
            2'b00: begin  OUT <= IN_0; end
            2'b01: begin  OUT <= IN_1; end
            2'b10: begin  OUT <= IN_2; end
            2'b11: begin  OUT <= IN_3; end
    
    endcase      
    
    end
    
endmodule
