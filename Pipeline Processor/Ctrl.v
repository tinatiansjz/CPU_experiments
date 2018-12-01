`include "Instruction_def.v"
//Control Unit (conbination element)
module Ctrl(
  input  [5:0] opcode_i,//Instr[31-26]
  input        mark_i,//Instr[16], to differentiate bltz and bgtz
  input  [5:0] funct_i,//Instr[5-0], to differentiate sll,srl,sra,jalr,jr from other R-type Instructions
  output [2:0] Branch_o,
  output [1:0] PCSource_o,
  output       Jump_o,
  output [1:0] EXTOp_o,
  output [1:0] RegDst_o,
  output       ALUSrcA_o,
  output       ALUSrcB_o,
  output [2:0] ALUOp_o,
  output [2:0] BEOp_o,
  output       MemRead_o,
  output       MemWrite_o,
  output [1:0] MemtoReg_o,
  output       RegWrite_o
  );
  reg [2:0] Branch, ALUOp, BEOp;
  reg       Jump, ALUSrcA, ALUSrcB, MemRead,MemWrite,RegWrite;
  reg [1:0] PCSource, EXTOp, RegDst, MemtoReg;
  always@(*)
  begin
    case(opcode_i)
      `R_type:
      begin
        Branch <= 3'b111; RegDst <= 2'b1; ALUSrcB <= 1'b0;
        ALUOp <= 3'b010; MemRead <= 1'b0; MemWrite <= 1'b0;
        if (!funct_i[5:2])//srl, sll, sra
        begin
          PCSource <= 2'b0; Jump <= 1'b0; ALUSrcA <= 1'b1; MemtoReg <= 2'b0; RegWrite <= 1'b1;
        end
        else if (funct_i == 6'h9)//jalr
        begin
          PCSource <= 2'b11; Jump <= 1'b1; MemtoReg <= 2'b10; RegWrite <= 1'b1;
        end
        else if (funct_i == 6'h8)//jr
        begin
          PCSource <= 2'b11; Jump <= 1'b1; RegWrite <= 1'b0;
        end
        else
        begin
          PCSource <= 2'b0; Jump <= 1'b0; ALUSrcA <= 1'b0; MemtoReg <= 2'b0; RegWrite <= 1'b1;
        end
      end
      `J:
      begin
        Branch <= 3'b111; PCSource <= 2'b10; Jump <= 1'b1; MemRead <= 1'b0; MemWrite <= 1'b0; RegWrite <= 1'b0;
      end
      `JAL:
      begin
        Branch <= 3'b111; PCSource <= 2'b10; Jump <= 1'b1; RegDst <= 2'b10; MemRead <= 1'b0;
        MemWrite <= 1'b0; MemtoReg <= 2'b10; RegWrite <= 1'b1;
      end
      `LB:
      begin
        Branch <= 3'b111; PCSource <= 2'b00; Jump <= 1'b0; EXTOp <= 2'b01; RegDst <= 2'b00; ALUSrcA <= 1'b0; ALUSrcB <= 1'b1;
        ALUOp <= 3'b0; BEOp <= 3'b111; MemRead <= 1'b1; MemWrite <= 1'b0; MemtoReg <= 2'b01; RegWrite <= 1'b1;
      end
      `LBU:
      begin
        Branch <= 3'b111; PCSource <= 2'b00; Jump <= 1'b0; EXTOp <= 2'b00; RegDst <= 2'b00; ALUSrcA <= 1'b0; ALUSrcB <= 1'b1;
        ALUOp <= 3'b0; BEOp <= 3'b110; MemRead <= 1'b1; MemWrite <= 1'b0; MemtoReg <= 2'b01; RegWrite <= 1'b1;
      end
      `LH:
      begin
        Branch <= 3'b111; PCSource <= 2'b00; Jump <= 1'b0; EXTOp <= 2'b01; RegDst <= 2'b00; ALUSrcA <= 1'b0; ALUSrcB <= 1'b1;
        ALUOp <= 3'b0; BEOp <= 3'b101; MemRead <= 1'b1; MemWrite <= 1'b0; MemtoReg <= 2'b01; RegWrite <= 1'b1;
      end
      `LHU:
      begin
        Branch <= 3'b111; PCSource <= 2'b00; Jump <= 1'b0; EXTOp <= 2'b00; RegDst <= 2'b00; ALUSrcA <= 1'b0; ALUSrcB <= 1'b1;
        ALUOp <= 3'b0; BEOp <= 3'b100; MemRead <= 1'b1; MemWrite <= 1'b0; MemtoReg <= 2'b01; RegWrite <= 1'b1;
      end
      `LW:
      begin
        Branch <= 3'b111; PCSource <= 2'b00; Jump <= 1'b0; EXTOp <= 2'b01; RegDst <= 2'b00; ALUSrcA <= 1'b0; ALUSrcB <= 1'b1;
        ALUOp <= 3'b0; BEOp <= 3'b011; MemRead <= 1'b1; MemWrite <= 1'b0; MemtoReg <= 2'b01; RegWrite <= 1'b1;
      end
      `SB:
      begin
        Branch <= 3'b111; PCSource <= 2'b00; Jump <= 1'b0; EXTOp <= 2'b01; ALUSrcA <= 1'b0; ALUSrcB <= 1'b1;
        ALUOp <= 3'b0; BEOp <= 3'b010; MemRead <= 1'b0; MemWrite <= 1'b1; RegWrite <= 1'b0;
      end
      `SH:
      begin
        Branch <= 3'b111; PCSource <= 2'b00; Jump <= 1'b0; EXTOp <= 2'b01; ALUSrcA <= 1'b0; ALUSrcB <= 1'b1;
        ALUOp <= 3'b0; BEOp <= 3'b001; MemRead <= 1'b0; MemWrite <= 1'b1; RegWrite <= 1'b0;
      end
      `SW:
      begin
        Branch <= 3'b111; PCSource <= 2'b00; Jump <= 1'b0; EXTOp <= 2'b01; ALUSrcA <= 1'b0; ALUSrcB <= 1'b1;
        ALUOp <= 3'b0; BEOp <= 3'b000; MemRead <= 1'b0; MemWrite <= 1'b1; RegWrite <= 1'b0;
      end
      `ADDI:
      begin
        Branch <= 3'b111; PCSource <= 2'b00; Jump <= 1'b0; EXTOp <= 2'b01; RegDst <= 2'b00; ALUSrcA <= 1'b0; ALUSrcB <= 1'b1;
        ALUOp <= 3'b0; MemRead <= 1'b0; MemWrite <= 1'b0; MemtoReg <= 2'b0; RegWrite <= 1'b1;
      end
      `ADDIU:
      begin
        Branch <= 3'b111; PCSource <= 2'b00; Jump <= 1'b0; EXTOp <= 2'b00; RegDst <= 2'b00; ALUSrcA <= 1'b0; ALUSrcB <= 1'b1;
        ALUOp <= 3'b0; MemRead <= 1'b0; MemWrite <= 1'b0; MemtoReg <= 2'b0; RegWrite <= 1'b1;
      end
      `ANDI:
      begin
        Branch <= 3'b111; PCSource <= 2'b00; Jump <= 1'b0; EXTOp <= 2'b00; RegDst <= 2'b00; ALUSrcA <= 1'b0; ALUSrcB <= 1'b1;
        ALUOp <= 3'b1; MemRead <= 1'b0; MemWrite <= 1'b0; MemtoReg <= 2'b0; RegWrite <= 1'b1;
      end
      `ORI:
      begin
        Branch <= 3'b111; PCSource <= 2'b00; Jump <= 1'b0; EXTOp <= 2'b00; RegDst <= 2'b00; ALUSrcA <= 1'b0; ALUSrcB <= 1'b1;
        ALUOp <= 3'b011; MemRead <= 1'b0; MemWrite <= 1'b0; MemtoReg <= 2'b0; RegWrite <= 1'b1;
      end
      `XORI:
      begin
        Branch <= 3'b111; PCSource <= 2'b00; Jump <= 1'b0; EXTOp <= 2'b00; RegDst <= 2'b00; ALUSrcA <= 1'b0; ALUSrcB <= 1'b1;
        ALUOp <= 3'b100; MemRead <= 1'b0; MemWrite <= 1'b0; MemtoReg <= 2'b0; RegWrite <= 1'b1;
      end
      `LUI:
      begin
        Branch <= 3'b111; PCSource <= 2'b00; Jump <= 1'b0; EXTOp <= 2'b10; RegDst <= 2'b00; ALUSrcA <= 1'b0; ALUSrcB <= 1'b1;
        MemRead <= 1'b0; MemWrite <= 1'b0; MemtoReg <= 2'b11; RegWrite <= 1'b1;
      end
      `SLTI:
      begin
        Branch <= 3'b111; PCSource <= 2'b00; Jump <= 1'b0; EXTOp <= 2'b01; RegDst <= 2'b00; ALUSrcA <= 1'b0; ALUSrcB <= 1'b1;
        ALUOp <= 3'b110; MemRead <= 1'b0; MemWrite <= 1'b0; MemtoReg <= 2'b0; RegWrite <= 1'b1;
      end
      `SLTIU:
      begin
        Branch <= 3'b111; PCSource <= 2'b00; Jump <= 1'b0; EXTOp <= 2'b01; RegDst <= 2'b00; ALUSrcA <= 1'b0; ALUSrcB <= 1'b1;
        ALUOp <= 3'b111; MemRead <= 1'b0; MemWrite <= 1'b0; MemtoReg <= 2'b0; RegWrite <= 1'b1;
      end
      `BEQ:
      begin
        Branch <= 3'b000; PCSource <= 2'b01; Jump <= 1'b0; MemRead <= 1'b0; MemWrite <= 1'b0; RegWrite <= 1'b0;
      end
      `BNE:
      begin
        Branch <= 3'b001; PCSource <= 2'b01; Jump <= 1'b0; MemRead <= 1'b0; MemWrite <= 1'b0; RegWrite <= 1'b0;
      end
      `BLEZ:
      begin
        Branch <= 3'b100; PCSource <= 2'b01; Jump <= 1'b0; MemRead <= 1'b0; MemWrite <= 1'b0; RegWrite <= 1'b0;
      end
      `BGTZ:
      begin
        Branch <= 3'b010; PCSource <= 2'b01; Jump <= 1'b0; MemRead <= 1'b0; MemWrite <= 1'b0; RegWrite <= 1'b0;
      end
      `BLTZ_BGEZ:
      begin
        PCSource <= 2'b01; Jump <= 1'b0; MemRead <= 1'b0; MemWrite <= 1'b0; RegWrite <= 1'b0;
        if (mark_i) Branch <= 3'b101;//bgez
        else Branch <= 3'b011;//bltz
      end
    endcase
  end
  assign Branch_o = Branch;
  assign PCSource_o = PCSource;
  assign Jump_o = Jump;
  assign EXTOp_o = EXTOp;
  assign RegDst_o = RegDst;
  assign ALUSrcA_o = ALUSrcA;
  assign ALUSrcB_o = ALUSrcB;
  assign ALUOp_o = ALUOp;
  assign BEOp_o = BEOp;
  assign MemRead_o = MemRead;
  assign MemWrite_o = MemWrite;
  assign MemtoReg_o = MemtoReg;
  assign RegWrite_o = RegWrite;
endmodule