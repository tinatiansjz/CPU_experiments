`include "define.v"
module alu_tb(
  );
  `timescale  1ns/1ps
  reg clk;
  reg [31:0]line_cnt;
  reg [31:0]tmp_hi,tmp_lo;
  reg   tmp_zero;
  wire  [63:0]aluout;
  wire  zero;
  
  reg   [4:0]aluop;
  reg   [31:0]src0,src1;

  integer cnt,fd;
  initial
  begin
    clk=1;
    fd=$fopen("data.txt","r");
    line_cnt=0;
    tmp_lo=0;
    tmp_hi=0;
    tmp_zero=0;
    aluop=`ALUOP_NOP;
    src0=0;
    src1=0;
  end
  always
    #10 clk<=~clk;
/*
module ALU(
  input   [4:0]  ALU_control_i,
  input   [31:0] src0_i,//rs or shamt
  input   [31:0] src1_i,//rt or transformed imm
  output reg [63:0] ALU_result_o,//32??????32?,hi??32?? lo??32?
  output reg Zero_o
  );
  
*/
    
  ALU alu0(
  .ALU_control_i(aluop),
  .src0_i(src0),
  .src1_i(src1),
  .ALU_result_o(aluout),
  .Zero_o(zero)
  );
  
  always@(posedge clk)
  begin
    line_cnt<=line_cnt+1;
    
    case(aluop)
      `ALUOP_NOP:
          //do nothing
          ;
      `ALUOP_SUB:
          if(aluout[31:0]!=tmp_lo || zero!=tmp_zero)
            begin
              $display("testcase %d failed! aluout[31:0] = %h, zero = %d",line_cnt, aluout[31:0], zero);
              $stop;
            end
      `ALUOP_ADD,
      `ALUOP_SLT,
      `ALUOP_SLTU,
      `ALUOP_AND,
      `ALUOP_NOR,
      `ALUOP_OR,
      `ALUOP_LUI,
      `ALUOP_SLL,
      `ALUOP_SRL,
      `ALUOP_SRA:
          if(aluout[31:0]!=tmp_lo)
            begin
              $display("testcase %d failed! aluout[31:0] = %h",line_cnt, aluout[31:0]);
              $stop;
            end
      `ALUOP_DIV,
      `ALUOP_DIVU,
      `ALUOP_MULT,
      `ALUOP_MULTU:
          if(aluout!={tmp_hi,tmp_lo})
            begin
              $display("testcase %d failed! aluout = %x",line_cnt, aluout);
              $stop;
            end
      default:
          $display("unknown aluop!");
    endcase
    
    cnt=$fscanf(fd,"0x%x\t0x%x\t0x%x\t0x%x\t0x%x\t0x%x\t",aluop,src0,src1,tmp_hi,tmp_lo,tmp_zero);
    $display("%x %x %x %x %x %x /cnt:%d",aluop,src0,src1,tmp_hi,tmp_lo,tmp_zero,cnt);
    if (cnt!=6)
      begin
        $fclose(fd);
        $display("pass!");
        $stop;
      end
  end
  
endmodule