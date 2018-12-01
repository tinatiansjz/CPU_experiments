//Forwarding Unit (combinational element)
module FU(
  input [31:0]Instr_id,//for mtc0
  input [4:0] Rs_id,//for jalr
  input       Jump_id,
  input [4:0] Rs_ex,
  input [4:0] Rt_ex,
  input [4:0] Rd_ex,
  input [4:0] Rd_mem,
  input [4:0] Rd_wb,
  input [5:0] op_id,
  input [5:0] op_ex,
  input       MemWrite_ex,
  input       RegWrite_ex,
  input       First_mem,
  input       RegWrite_mem,
  input       First_wb,
  input       RegWrite_wb,
  
  output[1:0] ForwardA_o,
  output[1:0] ForwardB_o,
  output[1:0] ForwardC_o,
  output[1:0] ForwardD_o,
  output[1:0] ForwardE_o,
  output[1:0] ForwardF_o,
  output[1:0] ForwardG_o
  );
  reg [1:0] ForwardA, ForwardB, ForwardC, ForwardD, ForwardE, ForwardF, ForwardG;
  always@(*)
  begin
    //ForwardA
    if (RegWrite_mem && (Rd_mem != 4'b0) && (Rd_mem == Rs_ex))//EX hazard
      ForwardA = 2'd1;
    else if (RegWrite_wb && (Rd_wb != 4'b0) && (Rd_wb == Rs_ex))//MEM hazard
      ForwardA = 2'd2;
    else ForwardA = 2'd0;
    //ForwardB
    if (RegWrite_mem && (Rd_mem != 4'b0) && (Rd_mem == Rt_ex) && !op_ex)//EX hazard(R-type)
      ForwardB = 2'd1;
    else if (RegWrite_wb && (Rd_wb != 4'b0) && (Rd_wb == Rt_ex) && !op_ex)//MEM hazard(R-type)
      ForwardB = 2'd2;
    else ForwardB = 2'b0;
    //ForwardC
    if (RegWrite_mem && (Rd_mem != 4'b0) && (Rd_mem == Rt_ex) && MemWrite_ex)//EX hazard(store)
      ForwardC = 2'd1;
    else if (RegWrite_wb && (Rd_wb != 4'b0) && (Rd_wb == Rt_ex) && MemWrite_ex)//MEM hazard(store)
      ForwardC = 2'd2;
    else ForwardC = 2'b0;
    //ForwardD
    if (RegWrite_ex && (Rd_ex != 4'b0) && (Rd_ex == Rs_id) && Jump_id && !op_id)//jr jalr
      ForwardD = 2'b01;
    else if (RegWrite_mem && (Rd_mem != 4'b0) && (Rd_mem == Rs_id) && Jump_id && !op_id)
      ForwardD = 2'b10;
    else if (RegWrite_wb && (Rd_wb != 4'b0) && (Rd_wb == Rs_id) && Jump_id && !op_id) 
      ForwardD = 2'b11;
    else
      ForwardD = 2'b0;
    //ForwardE
    if ((op_id == 6'h10) && (Instr_id[25:21] == 5'h4) && (Rd_ex == Instr_id[20:16]) && RegWrite_ex)//mtc0
      ForwardE = 2'b01;
    else if((op_id ==  6'h10) && (Instr_id[25:21] == 5'h4) && (Rd_mem == Instr_id[20:16]) && RegWrite_mem)
      ForwardE = 2'b10;
    else if((op_id == 6'h10) && (Instr_id[25:21] == 5'h4) && (Rd_wb == Instr_id[20:16]) && RegWrite_mem)
      ForwardE = 2'b11;
    else
      ForwardE = 2'b00;
    //ForwardF //for mfc0
    if (First_mem && (Rd_mem != 4'b0) && (Rd_mem == Rs_ex))//EX hazard
      ForwardF = 2'd1;
    else if (First_wb && (Rd_wb != 4'b0) && (Rd_wb == Rs_ex))//MEM hazard
      ForwardF = 2'd2;
    else ForwardF = 2'd0;
    //ForwardG //for mfc0
    if (First_mem && (Rd_mem != 4'b0) && (Rd_mem == Rt_ex) && !op_ex)//EX hazard (R-type)
      ForwardG = 2'd1;
    else if (First_wb && (Rd_wb != 4'b0) && (Rd_wb == Rt_ex) && !op_ex)//MEM hazard (R-type)
      ForwardG = 2'd2;
    else ForwardG = 2'd0;
  end
  assign ForwardA_o = ForwardA;
  assign ForwardB_o = ForwardB;
  assign ForwardC_o = ForwardC;
  assign ForwardD_o = ForwardD;
  assign ForwardE_o = ForwardE;
  assign ForwardF_o = ForwardF;
  assign ForwardG_o = ForwardG;
endmodule