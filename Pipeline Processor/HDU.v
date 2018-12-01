//Hazard Detection Unit (combinational element)
module HDU(
  input       MemRead_ex,
  input       MemRead_mem,
  input [4:0] Rs_id,
  input [4:0] Rt_id,
  input [4:0] Rt_ex,
  input [4:0] RD_mem,
  input       Jump_id,
  input [5:0] op_id,
  
  output stall_o,
  output PC_IFWrite_o
  );
  reg stall, PC_IFWrite;
  always@(*)
  begin
    if (MemRead_ex && ((Rt_ex == Rs_id) || (Rt_ex == Rt_id)))
      begin
        stall <= 1'b1;
        PC_IFWrite <= 1'b0;//forbit the update of PC and IF_ID
      end
    else if (MemRead_mem && (RD_mem == Rs_id) && Jump_id && !op_id)//jalr, jr
      begin
        stall  <= 1'b1;
        PC_IFWrite <= 1'b0;
      end
    else
      begin
        stall <= 1'b0;
        PC_IFWrite <= 1'b1;
      end
  end
  assign PC_IFWrite_o = PC_IFWrite;
  assign stall_o = stall;
endmodule
  
