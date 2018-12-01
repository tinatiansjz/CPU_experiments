module MUX(d0, d1, d2, d3, s, data_o);
  input [31:0] d0;
  input [31:0] d1;
  input [31:0] d2;
  input [31:0] d3;
  parameter width = 1;
  input [width-1:0]  s;//signal
  output [31:0] data_o;
  reg [31:0] data;
  always@(*)
  begin
    if (width == 1)
      case (s)
        1'b0: data <= d0;
        1'b1: data <= d1;
        default: data <= 1'b0;
      endcase
    if (width == 2)
      case(s)
        2'b00: data <= d0;
        2'b01: data <= d1;
        2'b10: data <= d2;
        2'b11: data <= d3;
        default: data <= 2'b0;
      endcase
  end
  assign data_o = data;
endmodule