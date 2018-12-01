`include "Instruction_def.v"
//Control Unit (conbination element)
module Ctrl(
  input  [5:0] opcode_i,//Instr[31-26]
   
  output [1:0] RegDst_o,//00: rd field, 01: rt field, 10: $31(jal)
  output       ALUSrc_o,//0: register data, 1: sign_extend output
  output [1:0] MemtoReg_o,//00: ALU output, 01: DM data, 10:{new_PC[31-28],Instr[25-0],2'b0}(jal)
  output       RegWrite_o,
  output       MemWrite_o,
  output       Branch_o,
  output [1:0] ALUOp_o,//00: lw/sw, 01: beq, 10: R-type
  output       Jump_o,
  output [1:0] EXTOp_o//00: zero extension, 01: sign extension, 10:put imm to high order bits
  );
  reg [1:0] RegDst;
  reg       ALUSrc;
  reg [1:0] MemtoReg;
  reg       RegWrite;
  reg       MemWrite;
  reg       Branch;
  reg [1:0] ALUOp;
  reg       Jump;
  reg [1:0] EXTOp;
  
  always@(*)
  begin
    case(opcode_i)
      `R_type:              //R-type
      begin
        RegDst   <= 2'b00;
        ALUSrc   <= 1'b0;
        MemtoReg <= 2'b00;
        RegWrite <= 1'b1;
        MemWrite <= 1'b0;
        Branch   <= 1'b0;
        ALUOp    <= 2'b10;
        Jump     <= 1'b0;
        EXTOp    <= 2'b00;
      end
      `ORI:                 //ori
      begin
        RegDst   <= 2'b01;//rt
        ALUSrc   <= 1'b1;
        MemtoReg <= 2'b00;
        RegWrite <= 1'b1;
        MemWrite <= 1'b0;
        Branch   <= 1'b0;
        ALUOp    <= 2'b11;
        Jump     <= 1'b0;
        EXTOp    <= 2'b00;//zero-extended
      end
      `LW:                   //lw
      begin
        RegDst   <= 2'b01;
        ALUSrc   <= 1'b1;
        MemtoReg <= 2'b01;
        RegWrite <= 1'b1;
        MemWrite <= 1'b0;
        Branch   <= 1'b0;
        ALUOp    <= 2'b00;
        Jump     <= 1'b0;
        EXTOp    <= 2'b01; //sign extension
      end
      `SW:                   //sw
      begin
        ALUSrc   <= 1'b1;
        RegWrite <= 1'b0;
        MemWrite <= 1'b1;
        Branch   <= 1'b0;
        ALUOp    <= 2'b00;
        Jump     <= 1'b0;
        EXTOp    <= 2'b01; //sign extension
      end
      `BEQ:                   //beq
      begin
        ALUSrc   <= 1'b0;
        RegWrite <= 1'b0;
        MemWrite <= 1'b0;
        Branch   <= 1'b1;
        ALUOp    <= 2'b01;
        Jump     <= 1'b0;
        EXTOp    <= 2'b01;//sign extension
      end
      `JAL:                   //jal
      begin
        MemtoReg <= 2'b10;
        RegWrite <= 1'b1;
        MemWrite <= 1'b0;
        Jump     <= 1'b1;
        RegDst   <= 2'b10;
        EXTOp    <= 2'b00;//zero-extension
      end
      `J:                   //j
      begin
        MemtoReg <= 2'b10;    
        RegWrite <= 1'b0;
        MemWrite <= 1'b0;
        Jump     <= 1'b1;
        EXTOp    <= 2'b00;//zero-extension
      end
      default:
      begin
        RegDst <= 2'b0;
    	   ALUSrc <= 1'b0;
        MemtoReg <= 2'b0;
  	     RegWrite <= 1'b0;
        MemWrite <= 1'b0;
 	      Branch <= 1'b0;
  	     ALUOp <= 2'b0;
  	     Jump <= 1'b0;
  	     EXTOp <= 2'b0;
      end
    endcase
  end
  assign RegDst_o = RegDst;
  assign ALUSrc_o = ALUSrc;
  assign MemtoReg_o = MemtoReg;
  assign RegWrite_o = RegWrite;
  assign MemWrite_o = MemWrite;
  assign Branch_o = Branch;
  assign ALUOp_o =  ALUOp;
  assign Jump_o = Jump;
  assign EXTOp_o = EXTOp;
endmodule
  