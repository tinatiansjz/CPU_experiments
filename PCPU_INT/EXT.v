//Extension (combinational element)
module EXT(
  input  [15:0] Imm16_i,
  input  [1:0]  EXTOp,
  
  output [31:0] Imm32_o
  );
  reg [31:0] Imm32;
  always@(*)
  begin
    case(EXTOp)
      2'b00://zero extension
        Imm32 = {16'b0, Imm16_i[15:0]};
      2'b01://sign extension
        Imm32 = {{16{Imm16_i[15]}}, Imm16_i[15:0]};
      2'b10://put imm to high order bits
        Imm32 = {Imm16_i[15:0], 16'b0};
    endcase
  end
  assign Imm32_o = Imm32;
endmodule