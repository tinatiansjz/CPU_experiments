`include "Instruction_def.v"
`include "BEOp_def.v"
module MIPS(
  input clk,
  input rst
  );
  wire       MemWrite, Sign;
  wire [3:0] BE_signal;
  wire [31:0] final_Addr, DataIn, DataOut;
  assign BE_signal = 4'b1111;
  assign Sign = 1'b0;
  Memory my_Memory(clk, rst, final_Addr, DataIn, MemWrite, BE_signal, Sign, DataOut);
  Multi_CPU Multi_CPU(.clk(clk), .reset(rst), .MIO_ready(), .Data_in(DataOut), .INT(), .mem_w(MemWrite),
    .inst_out(), .PC_out(), .Addr_out(final_Addr), .Data_out(DataIn), .state(), .CPU_MIO());
endmodule