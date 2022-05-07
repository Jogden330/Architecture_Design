`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2020 01:40:37 PM
// Design Name: 
// Module Name: CU_FSM
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


module CU_FSM(
 input CLK, INTR, RST, 
 input [6:0] CU_OPCODE,
 output logic PC_WRITE, REG_WRITE, MEM_WRITE, MEM_READ1, MEM_READ2
 );
 parameter [1:0] Fetch = 2'b00, EXE = 2'b01, WB = 2'b11;
 logic [2:0] NS;
 logic [2:0] PS = Fetch;
    typedef enum logic [6:0] {
            LUI      = 7'b0110111,
            AUIPC    = 7'b0010111,
            JAL      = 7'b1101111,
            JALR     = 7'b1100111,
            BRANCH   = 7'b1100011,
            LOAD     = 7'b0000011,
            STORE    = 7'b0100011,
            OP_IMM   = 7'b0010011,
            OP       = 7'b0110011
    } opcode_t;
    
    opcode_t OPCODE;
    assign OPCODE = opcode_t'(CU_OPCODE);
    
    always_ff@( posedge CLK)
    begin
    if(RST) PS = Fetch;
    else    PS = NS;
    end
    
    always_comb
    begin 
    PC_WRITE =0;
    REG_WRITE = 0;
    MEM_WRITE = 0;
    MEM_READ1 = 0;
    MEM_READ2 = 0;
      
      case(PS)
        Fetch: begin MEM_READ1 = 1; NS = EXE; end
        
        EXE:
            begin
                case(CU_OPCODE)
                   LUI      :   begin
                                    PC_WRITE =1;
                                    REG_WRITE = 1;
                                    NS = Fetch;
                                end
                   AUIPC    :   begin
                                     PC_WRITE =1;
                                     REG_WRITE = 1;
                                     NS = Fetch;
                                end
                   JAL      :   begin
                                     PC_WRITE =1;
                                     REG_WRITE = 1;
                                     NS = Fetch;
                                end
                   JALR     :   begin
                                     PC_WRITE =1;
                                     REG_WRITE = 1;
                                     NS = Fetch;
                         
                                end
                   BRANCH   :   begin
                                     PC_WRITE =1;
                                     NS = Fetch;
                                end
                   LOAD     :   begin
                                    MEM_READ2 = 1;
                                    NS = WB;
                                end
                   STORE    :   begin
                                     PC_WRITE =1;
                                     MEM_WRITE = 1;
                                     NS = Fetch;
                                end
                   OP_IMM   :   begin
                                     PC_WRITE =1;
                                     REG_WRITE = 1;
                                     NS = Fetch;
                                end
                   OP       :   begin
                                     PC_WRITE =1;
                                     REG_WRITE = 1;
                                     NS = Fetch;
                                end
                
                endcase
            
            end        
            WB: begin
                     PC_WRITE =1;
                     REG_WRITE = 1;
                     NS = Fetch;                    
                end     
      endcase
        
    end
        
endmodule
