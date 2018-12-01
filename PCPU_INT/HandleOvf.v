module HandleOvf(
  input       Overflow_i,
  input [31:0]IR_ex_i,
  
  output      Overflow_o
  );
  reg Overflow;
  //only add and sub examine the overflow bit
  always@(*)
  begin
    if (!IR_ex_i[31:26] && !IR_ex_i[10:6] && (IR_ex_i[5:0] == 6'h20 || IR_ex_i[5:0] == 6'h22))//add or sub
    begin
      if (Overflow_i) Overflow = 1'b1;
      else  Overflow = 1'b0;
    end
    else
      Overflow = 1'b0;
  end
  assign Overflow_o = Overflow;
endmodule
