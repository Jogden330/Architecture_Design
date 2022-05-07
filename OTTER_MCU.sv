`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2020 11:01:57 AM
// Design Name: 
// Module Name: OTTER_MCU
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


module OTTER_MCU(
    input CLK, INTR, RST, 
    input [31:0] IOBUS_IN,
    output IOBUS_WR,
    output [31:0] IOBUS_OUT, IOBUS_ADDR

    );
    logic  alu_srcA, br_eq, br_lt, br_ltu;
    logic [1:0]  alu_srcB, pcSource, rf_wr_sel;
    logic [31:0] PC_4, ALU_OUT, dout2, rs1, ir;
    logic [31:0] T1, T3, T4, T5;
    logic PC_WRITE, REG_WRITE, MEM_WRITE, MEM_READ1, MEM_READ2;
    logic [31:0] I_immediate , S_immediate, B_immediate, U_immediate, J_immediate;
    logic [31:0] branch_pc, jalr_pc, jal_pc;
    logic [31:0] T2;
    logic [3:0] alu_fun;
    
    CUDecoder CUD_inst(.ALU_FUN(alu_fun),  .BR_EQ(br_eq), .BR_LT(br_lt), .BR_LTU(br_ltu), .ALU_SRCA(alu_srcA), .ALU_SRCB(alu_srcB), .PC_SOURCE(pcSource), .RF_WR_SEL(rf_wr_sel), .CU_OPCODE(ir[6:0]), .FUNC3(ir[14:12]), .FUNC7(ir[31:25]) );
    
    
    Mux4_1 Mux1( .IN_0(PC_4), .IN_1(jalr_pc), .IN_2(branch_pc), .IN_3(jal_pc), .select(pcSource), .OUT(T1));
    PC PC1(.DIN(T1),.CLK(CLK),.RESET(RST), .PC_WRITE(PC_WRITE), .DOUT(T2));
    
    OTTER_mem_byte men1(.MEM_READ1(MEM_READ1), .MEM_READ2(MEM_READ2), .MEM_ADDR1(T2), .MEM_WRITE(MEM_WRITE),
     .MEM_ADDR2(ALU_OUT), .MEM_CLK(CLK), .MEM_DOUT1(ir), .MEM_DIN2(IOBUS_OUT), .MEM_DOUT2(dout2), .MEM_SIZE(ir[13:12]),
      .MEM_SIGN(ir[14]), .IO_WR(IOBUS_WR), .IO_IN(IOBUS_IN));
    
    assign PC_4 = T2+4;
   
    Mux4_1 MUX_rf_wr_sel(.select(rf_wr_sel),.IN_3(ALU_OUT),.IN_0(PC_4), .IN_2(dout2), .OUT(T3));
    
    RegisterFile RegisterFile_inst(.CLK(CLK), .RS1(rs1),.RS2(IOBUS_OUT), .ADR1(ir[19:15]), .ADR2(ir[24:20]), .WA(ir[11:7]), .WD(T3), .EN(REG_WRITE));
       
    
    Mux4_1 Mux_alu_srcB(.select(alu_srcB),.IN_0(IOBUS_OUT), .IN_1(I_immediate), .IN_2(S_immediate), .IN_3(T2), .OUT(T5));
    Mux2_1 Mux_alu_srcA(.select(alu_srcA), .IN_0(rs1), .IN_1(U_immediate), .OUT(T4)); 
    ALU ALU_inst(.ALU_FUN(alu_fun),.ALU_OUT(ALU_OUT), .A(T4), .B(T5));
    
    CU_FSM FSM_ist(.CLK(CLK), .INTR(INTR), .RST(RST), .CU_OPCODE(ir[6:0]), .PC_WRITE(PC_WRITE), .REG_WRITE(REG_WRITE), .MEM_WRITE(MEM_WRITE), .MEM_READ1(MEM_READ1), .MEM_READ2(MEM_READ2) );
    
   
    assign IOBUS_ADDR =  ALU_OUT;
    
    
    // might be wrong
    assign I_immediate = {{21{ir[31]}},ir[30:20]};
    assign S_immediate = {{21{ir[31]}},ir[30:25],ir[11:7]};
    assign B_immediate = {{19{ir[31]}},ir[7],ir[30:25],ir[11:8],1'b0};
    assign U_immediate = {ir[31:12], 12'b0};
    assign J_immediate = {{12{ir[31]}},ir[19:12],ir[20],ir[30:25],ir[24:21],1'b0};
    
    assign branch_pc = T2 + B_immediate;
    assign jalr_pc = rs1 + I_immediate; // might be wrong
    assign jal_pc = T2 + J_immediate;   // might be wrong
    
    
    
    always_comb
    begin
        
     
        
        if(rs1 == IOBUS_OUT) 
            br_eq = 1; 
          else
            br_eq = 0; 
        if( $signed(rs1) < $signed(IOBUS_OUT)) 
              br_lt = 1; 
            else
              br_lt = 0; 
        if(rs1 < IOBUS_OUT)
              br_ltu = 1;
            else
              br_ltu = 0;        
    end
endmodule
