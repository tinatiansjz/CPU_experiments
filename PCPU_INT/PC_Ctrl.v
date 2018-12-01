//combinational element
module PC_Ctrl(
  input        enable_i,
  input  [1:0] PCSource_i,
  output [1:0] Signal_o
  );
  reg [1:0] Signal;
  always@(*)
  begin
    if (PCSource_i == 2'b01 && !enable_i)//conditional transfer does not hold (Branch Instructions)
      Signal = 2'b0;
    else Signal = PCSource_i;
  end
  assign Signal_o = Signal;
endmodule