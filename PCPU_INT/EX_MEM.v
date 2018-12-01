//EX/MEM Register (state element)
module EX_MEM(
  input        clk,
  input        rst,
  input  [31:0]Signal_ex_i,
  input  [31:0]NPC_ex_i,
  //input  [31:0]BA_ex_i,
  input  [31:0]ALUOut_ex_i,
  input  [31:0]rd2_ex_i,
  input  [31:0]EXT_ex_i,
  input  [31:0]RD_ex_i,
  input  [31:0]CD_ex_i,
  input        IF_flush_i,
  input  [1:0] Cause_i,

  output [31:0]Signal_mem_o,
  output [2:0] BEOp_mem_o,
  output       MemRead_mem_o,
  output       MemWrite_mem_o,
  output [31:0]NPC_mem_o,
  output [31:0]ALUOut_mem_o,
  output [31:0]rt_mem_o,
  output [31:0]EXT_mem_o,
  output [31:0]RD_mem_o,
  output [31:0]CD_mem_o
  );
  integer i;
  reg [31:0] EX_MEM_reg[7:0];
  /*
  EX_MEM_reg[0]: Signal_mem
  EX_MEM_reg[1]: NPC_mem
  EX_MEM_reg[2]: BA_mem
  EX_MEM_reg[3]: ALUOut_mem
  EX_MEM_reg[4]: B_mem
  EX_MEM_reg[5]: E_mem
  EX_MEM_reg[6]: RD_mem
  EX_MEM_reg[7]: CD_mem //Coprocessor0's data
  */
  always@(posedge clk or posedge rst)
  begin
    if (rst)
      begin
        for (i = 0; i < 8; i = i+1)
          EX_MEM_reg[i] = 32'h0;
      end
    else
      begin
        if (IF_flush_i && Cause_i == 2'b11)//overflow
        begin
          EX_MEM_reg[0] = 32'b0;
        end
        else
        begin
          EX_MEM_reg[0] = Signal_ex_i;
        end
        EX_MEM_reg[1] = NPC_ex_i;
        //EX_MEM_reg[2] = BA_ex_i;
        EX_MEM_reg[3] = ALUOut_ex_i;
        EX_MEM_reg[4] = rd2_ex_i;
        EX_MEM_reg[5] = EXT_ex_i;
        EX_MEM_reg[6] = RD_ex_i;
        EX_MEM_reg[7] = CD_ex_i;
        $display("EX/MEM: Signal_mem = %8X, NPC_mem = %8X, ALUOut_ex = %8X, B_mem = %8X, E_mem = %8X, RD_mem = %8X, CD_mem = %8X", 
          EX_MEM_reg[0], EX_MEM_reg[1], EX_MEM_reg[3], EX_MEM_reg[4], EX_MEM_reg[5], EX_MEM_reg[6], EX_MEM_reg[7]);
      end
  end
  assign Signal_mem_o = EX_MEM_reg[0];
  assign BEOp_mem_o = EX_MEM_reg[0][9:7];
  assign MemRead_mem_o = EX_MEM_reg[0][10];
  assign MemWrite_mem_o = EX_MEM_reg[0][11];
  assign NPC_mem_o = EX_MEM_reg[1];
  assign ALUOut_mem_o = EX_MEM_reg[3];
  assign rt_mem_o = EX_MEM_reg[4];
  assign EXT_mem_o = EX_MEM_reg[5];
  assign RD_mem_o = EX_MEM_reg[6];
  assign CD_mem_o = EX_MEM_reg[7];
endmodule