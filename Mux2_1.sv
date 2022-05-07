`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2020 01:03:01 PM
// Design Name: 
// Module Name: Mux2_1
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


module Mux2_1(
input [31:0] IN_0, IN_1,
output logic [31:0]  OUT,
input logic select
    );
     always_comb
    begin
       case(select)
            2'b00: begin  OUT <= IN_0; end
            2'b01: begin  OUT <= IN_1; end
    
    endcase      
    
    end
endmodule
