module MDR(
  input clk,
  input rst_n,
  input [31:0] Mdata_i,//Regfile Read-data1
  
  output [31:0] data_o
  );
  reg [31:0] MDR;
  always@(posedge clk or negedge rst_n)
  begin
    if (!rst_n)
      MDR <= 32'h0;
    else
      MDR <= Mdata_i;
  end
  assign data_o = MDR;
endmodule



