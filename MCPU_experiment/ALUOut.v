module ALUOut(
  input clk,
  input rst_n,
  input [63:0] ALU_result_i,//Regfile Read-data1
  
  output [63:0] ALU_result_o
  );
  reg [63:0] ALUOut;
  always@(posedge clk or posedge rst_n)
  begin
    if (rst_n)
      ALUOut <= 64'h0;
    else
      ALUOut <= ALU_result_i;
  end
  assign ALU_result_o = ALUOut;
endmodule

