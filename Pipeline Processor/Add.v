module Add(
  input  [31:0] src0_i,
  input  [31:0] src1_i,
  output [31:0] outcome_o
  );
  reg [31:0] outcome;
  always@(*)
  begin
    outcome = src0_i + src1_i;
  end
  assign outcome_o = outcome;
endmodule
