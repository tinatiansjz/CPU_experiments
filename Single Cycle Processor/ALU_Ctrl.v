`include "Instruction_def.v"
//ALU control (conbinational element)
module ALU_ctrl(
  input  [3:0] funct_i,//part of function code, Instr[3-0]
  input  [1:0] ALUOp_i,//signal from Ctrl
  
  output [4:0] ALUOP_o//ALU control input(5 bits)
  );
  reg [4:0] ALUOP;
  always@(*)
  begin
    case (ALUOp_i)
      2'b10://R-type
      begin
        case(funct_i)
          4'b0001://addu
            ALUOP <= `ALUOP_ADD;
          4'b0011://subu
            ALUOP <= `ALUOP_SUB;
          4'b0000://add
            ALUOP <= `ALUOP_ADD;
          4'b0010://sub
            ALUOP <= `ALUOP_SUB;
          4'b0111://nor
            ALUOP <= `ALUOP_NOR;
        endcase
      end
      2'b00://sw/lw
        ALUOP <= `ALUOP_ADD;
      2'b01://beq
        ALUOP <= `ALUOP_SUB;
      2'b11://ori
        ALUOP <= `ALUOP_OR;
    endcase
  end
  assign ALUOP_o = ALUOP;
endmodule