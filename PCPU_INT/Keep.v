/*
Save the value (enable | Jump) of the previous cycle and the current cycle
*/
module Keep(
  input      clk,
  input      rst,
  input      enable_i,
  input      Jump_i,
  input      CauseEPCWrite_i,
  input[1:0] Cause_i,
  output     Key_o
  );
  reg [1:0] Key;
  always@(posedge clk or posedge rst)
  begin
    if (rst) Key = 2'b0;
    else if (CauseEPCWrite_i && !Cause_i)
    begin
      //do not respond to INT
    end
    else begin
      Key[1] = Key[0];//the value (enable | Jump) of the previous cycle
      Key[0] = enable_i | Jump_i;//the value (enable | Jump) of the current cycle
    end
  end
  assign Key_o = Key[0];//due to the property of register, the Key[0] is actually the previous cycle's value (enable | Jump) 
endmodule
