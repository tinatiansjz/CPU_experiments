`include "BEOp_def.v"
//A1_0 BE (conbination element)
module BE(
  input [2:0] BEOp,
  input [1:0] A1_0,
  
  output [3:0] BE_o,
  output Sign_o//0: zero-extension, 1: sign-extension
  );
  reg [3:0] BE;
  reg       Sign;
  
  always@(*)
  begin
    case(BEOp)
      `SW: BE <= 4'b1111;
      `SH: 
      begin
        if (A1_0[1] == 1'b0)
          BE <= 4'b0011;
        else
          BE <= 4'b1100;
      end
      `SB:
      begin
        if (A1_0 == 2'b00)
          BE <= 4'b0001;
        else if (A1_0 == 2'b01)
          BE <= 4'b0010;
        else if (A1_0 == 2'b10)
          BE <= 4'b0100;
        else
          BE <= 4'b1000;
      end
      `LW: BE <= 4'b1111;
      `LHU:
      begin
        Sign <= 1'b0;
        if (A1_0[1] == 0)
            BE <= 4'b0011;
        else
            BE <= 4'b1100;
      end
      `LH:
      begin
        Sign <= 1'b1;
        if (A1_0[1] == 1'b0)
            BE <= 4'b0011;
        else
            BE <= 4'b1100;
      end
      `LBU:
      begin
        Sign <= 1'b0;
        if (A1_0 == 2'b00)
          BE <= 4'b0001;
        else if (A1_0 == 2'b01)
          BE <= 4'b0010;
        else if (A1_0 == 2'b10)
          BE <= 4'b0100;
        else
          BE <= 4'b1000;
      end
      `LB:
      begin
        Sign <= 1'b1;
        if (A1_0 == 2'b00)
          BE <= 4'b0001;
        else if (A1_0 == 2'b01)
          BE <= 4'b0010;
        else if (A1_0 == 2'b10)
          BE <= 4'b0100;
        else
          BE <= 4'b1000;
      end
    endcase
  end
  assign BE_o = BE;
  assign Sign_o = Sign;
endmodule