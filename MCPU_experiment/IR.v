module IR(
  input clk,
  input rst_n,
  input IRWrite,
  input [31:0] Instr_i,//Regfile Read-data1
  
  output [31:0] Instr_o
  );
  reg [31:0] IR;
  always@(posedge clk or posedge rst_n)
  begin
    if (rst_n)
      IR <= 32'h0;
    else
      begin
        if (IRWrite)
          IR <= Instr_i;
      end
  end
  assign Instr_o = IR;
endmodule





