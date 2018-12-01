module regfile(
  input clk,
  input rst_n,
  input regwrite_i,

  input [4:0]wa_i, //rt or rd , write address
  input [4:0]ra0_i,//rs ,read address 0
  input [4:0]ra1_i,//rt ,read address 1
  input [31:0]wd_i,//write  data
  output [31:0]rd0_o,  //rs,read data
  output [31:0]rd1_o   //rt,read data
  );

  reg [31:0]rf[31:0];
  integer i;
  always@(posedge clk,negedge rst_n)
  begin
    if (!rst_n)
      for (i=0;i<32;i=i+1)
        rf[i]=32'd0;
    else
      if (regwrite_i)
        rf[wa_i]<=(wa_i==5'd0)? 32'd0:wd_i;
  end

  assign rd0_o=rf[ra0_i];
  assign rd1_o=rf[ra1_i];

endmodule
