module OR(
  input src0_i,
  input src1_i,
  
  output DataOut_o
  );
  reg DataOut;
  always@(*)
  begin
    DataOut = src0_i | src1_i;
  end
  assign DataOut_o = DataOut;
endmodule
