module ID_EX(
  input       clk,
  input       rst_n,
  input       stall,
  input [1:0] RegDst_id_i,  //ID_EX_reg[0][0:1]
  input       ALUSrcA_id_i, //ID_EX_reg[0][2]
  input       ALUSrcB_id_i, //ID_EX_reg[0][3]
  input [2:0] ALUOp_id_i,   //ID_EX_reg[0][6:4]
  input [2:0] BEOp_id_i,    //ID_EX_reg[0][9:7]
  input       MemRead_id_i, //ID_EX_reg[0][10]
  input       MemWrite_id_i,//ID_EX_reg[0][11]
  input [1:0] MemtoReg_id_i,//ID_EX_reg[0][13:12]
  input       RegWrite_id_i,//ID_EX_reg[0][14]
  input [31:0]NPC_id_i,
  input [31:0] BA_id_i,
  input [31:0] rs_id_i,
  input [31:0] rt_id_i,
  input [31:0] EXT_id_i,
  input [31:0] Instr_id_i,
  
  output [2:0]ALUOp_ex_o,
  output      ALUSrcB_ex_o,
  output      ALUSrcA_ex_o,
  output [1:0]RegDst_ex_o,
  output [31:0]Signal_ex_o,
  output [31:0]NPC_ex_o,
  output [31:0]rs_ex_o,
  output [31:0]rt_ex_o,
  output [31:0]EXT_ex_o,
  output [31:0]Instr_ex_o
  );
  integer i;
  reg [31:0] ID_EX_reg[7:0];
  /*
  ID_EX_reg[0]: Signal_ex
  ID_EX_reg[1]: JA_ex
  ID_EX_reg[2]: NPC_ex
  ID_EX_reg[3]: BA_ex
  ID_EX_reg[4]: A
  ID_EX_reg[5]: B
  ID_EX_reg[6]: E_ex
  ID_EX_reg[7]: IR_ex
  */
  always@(*)
  begin
    if (!rst_n)
      begin
        for (i = 0; i < 8; i = i+1)
          ID_EX_reg[i] = 32'h0;
      end
  end
  
  always@(posedge clk)
  begin
    if(stall)
      ID_EX_reg[0] = 32'h0;
    else
      begin
        ID_EX_reg[0][1:0] = RegDst_id_i;
        ID_EX_reg[0][2] = ALUSrcA_id_i;
        ID_EX_reg[0][3] = ALUSrcB_id_i;
        ID_EX_reg[0][6:4] = ALUOp_id_i;
        ID_EX_reg[0][9:7] = BEOp_id_i;
        ID_EX_reg[0][10] = MemRead_id_i;
        ID_EX_reg[0][11] = MemWrite_id_i;
        ID_EX_reg[0][13:12] = MemtoReg_id_i;
        ID_EX_reg[0][14] = RegWrite_id_i;
      end
    ID_EX_reg[2] = NPC_id_i;
    ID_EX_reg[3] = BA_id_i;
    ID_EX_reg[4] = rs_id_i;
    ID_EX_reg[5] = rt_id_i;
    ID_EX_reg[6] = EXT_id_i;
    ID_EX_reg[7] = Instr_id_i;
    $display("ID/EX: Signal_ex = %8X, NPC_ex = %8X, BA_ex = %8X, A_ex = %8X, B_ex = %8X, E_ex = %8X, IR_ex = %8X", 
      ID_EX_reg[0], ID_EX_reg[2], ID_EX_reg[3], ID_EX_reg[4], ID_EX_reg[5], ID_EX_reg[6], ID_EX_reg[7]);
  end
  assign Signal_ex_o = ID_EX_reg[0];
  assign RegDst_ex_o = ID_EX_reg[0][1:0];
  assign ALUSrcA_ex_o = ID_EX_reg[0][2];
  assign ALUSrcB_ex_o = ID_EX_reg[0][3];
  assign ALUOp_ex_o = ID_EX_reg[0][6:4];
  assign NPC_ex_o = ID_EX_reg[2];
  assign rs_ex_o = ID_EX_reg[4];
  assign rt_ex_o = ID_EX_reg[5];
  assign EXT_ex_o = ID_EX_reg[6];
  assign Instr_ex_o = ID_EX_reg[7];
endmodule

