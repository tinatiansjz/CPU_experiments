module SYNinterrupt(
  input clk,
  input rst,
  input INT,
  output SYN_INT);
  
  reg SYNINT;
  always@(posedge clk or posedge rst or posedge INT)
  begin
    if (rst)
      SYNINT <= 1'b0;
    else
      begin
        if (INT) SYNINT <= 1'b1;
        else SYNINT <= INT;
      end
  end
  assign SYN_INT = SYNINT;
endmodule
