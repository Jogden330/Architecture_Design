`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2020 01:02:08 PM
// Design Name: 
// Module Name: RegisterFile
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

 module RegisterFile #(parameter M = 31, N = 31 )(
    input [4:0] ADR1, ADR2, WA,
    input CLK, EN,
    input [M:0] WD,
    output logic [M:0] RS1, RS2
);

logic [M:0] mem [0:N];

//initialize all memory to zero 
initial begin
    for (int i = 0; i < N+1; i++) begin
        mem[i] = 0;
    end
end

//create synchronous write 
always_ff @ (posedge CLK)
begin
    if (EN == 1 && WA!=0)
        mem[WA] <= WD;
end

//asynchronous read 
assign RS1 = mem[ADR1];
assign RS2 = mem[ADR2];
   
endmodule

