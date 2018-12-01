module MIPS_tb(
  );
  `timescale 1ns/1ps
  reg clk, rst_n;
  MIPS mips(clk, rst_n);
  initial begin
    $monitor($time, "PC = %8x, IR = %8x, state = %d, ALUOut = 0x%x", mips.my_PC.PC, mips.my_IR.IR, mips.my_Ctrl.state, mips.my_ALUOut.ALUOut);
    clk = 0;
    rst_n = 0;
    #1 rst_n =  0;
    #2 rst_n = 1;
  end
  
  always
    #5 clk <= !clk;
endmodule