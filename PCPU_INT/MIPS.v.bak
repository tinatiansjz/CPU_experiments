module MIPS(
  input clk,
  input rst
  );
  wire        MemWrite_mem, Sign_mem;
  wire [3:0]  BE_mem;
  wire [31:0] PC_Addr, Instr_if, MD_mem, ALUOut_mem, rt_mem;  
  assign BE_mem = 4'b1111;
  assign Sign_mem = 1'b0;
  PCPU PCPU(.clk(clk), .reset(rst), .MIO_ready(), .inst_in(Instr_if), .Data_in(MD_mem), .INT(), .mem_w(MemWrite_mem), 
    .PC_out(PC_Addr), .Addr_out(ALUOut_mem), .Data_out(rt_mem), .CPU_MIO());       
  IM my_IM(PC_Addr, Instr_if);
  DM my_DM(clk, rst, ALUOut_mem, rt_mem, MemWrite_mem, BE_mem, Sign_mem, MD_mem);
  
endmodule
