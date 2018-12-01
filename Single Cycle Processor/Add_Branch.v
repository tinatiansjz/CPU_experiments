//Branch Address (combinational element)
module Add_Branch(
  input [31:0]  PC,//PC + 4
  input [31:0]  Imm32,
  
  output [31:0] Branch_Add_o
  );
  assign Branch_Add_o = PC + Imm32;
		
endmodule