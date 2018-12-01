`include "Instruction_def.v"
`include "BEOp_def.v"
module MIPS(
  input clk,
  input rst_n
  );
  wire       PCWrite, IorD, MemRead, MemWrite, IRWrite, RegWrite, PCWriteCond, PC_enable, Sign, Zero, enable;
  wire [1:0] RegDst, ALUSrcA, PCSource, EXTOp;
  wire [2:0] MemtoReg, ALUOp, Branch, BEOp, ALUSrcB;
  wire [3:0] BE_signal;
  wire [4:0] ALUcontrol;
  wire [31:0] final_PC, PC_Addr, final_Addr, DataOut, Instr, MData, wa, wd, rd1, rd2, Adata, DataIn, src0, src1, Imm32;
  wire [63:0] outcome, ALU_result;
  Ctrl my_Ctrl({Instr[31:26]}, {Instr[20:16]}, {Instr[5:0]}, clk, rst_n, 
    PCWrite, PCWriteCond, IorD, MemRead, MemWrite, MemtoReg, IRWrite, 
    RegDst, RegWrite, ALUSrcA, ALUSrcB, ALUOp, PCSource, EXTOp, Branch, BEOp);
  PC my_PC(clk, final_PC, PCWrite|(PCWriteCond & enable), rst_n, PC_Addr);
  MUX #(1) MUX1_1(PC_Addr, {ALU_result[31:0]}, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, IorD, final_Addr);
  Memory my_Memory(clk, rst_n, final_Addr, DataIn, MemWrite, MemRead, BE_signal, Sign, DataOut);
  IR my_IR(clk, rst_n, IRWrite, DataOut, Instr);
  MDR my_MDR(clk, rst_n, DataOut, MData);
  Regfile my_Regfile(clk, rst_n, RegWrite, {wa[4:0]}, {Instr[25:21]}, {Instr[20:16]}, wd, rd1, rd2);
  A my_A(clk, rst_n, rd1, Adata);
  B my_B(clk, rst_n, rd2, DataIn);
  ALU my_ALU(ALUcontrol, src0, src1, outcome, Zero);
  ALUOut my_ALUOut(clk, rst_n, outcome, ALU_result);
  Branch_Ctrl my_Branch_Ctrl(Branch, Zero, outcome[31], enable);
  MUX #(2) MUX2_1({27'b0, Instr[20:16]}, {27'b0, Instr[15:11]}, 32'd31, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, RegDst, wa);
  MUX #(3) MUX3_1({ALU_result[31:0]}, MData, PC_Addr, Adata, Imm32, 32'b0, 32'b0, 32'b0, MemtoReg, wd);
  EXT my_EXT({Instr[15:0]}, EXTOp, Imm32);
  MUX #(3) MUX3_2(DataIn, 32'd4, Imm32, {Imm32[29:0], 2'b0}, 32'b0, 32'b0,32'b0, 32'b0, ALUSrcB, src1);
  MUX #(2) MUX2_2(PC_Addr, Adata, {27'b0, Instr[10:6]}, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, ALUSrcA, src0);
  MUX #(2) MUX2_3({outcome[31:0]}, {ALU_result[31:0]}, {PC_Addr[31:28], Instr[25:0], 2'b0}, Adata, 32'b0, 32'b0, 32'b0, 32'b0, PCSource, final_PC);
  ALU_Ctrl my_ALU_Ctrl({Instr[5:0]}, ALUOp, ALUcontrol);
  BE my_BE(BEOp, {ALU_result[1:0]}, BE_signal, Sign);
endmodule