module IF_ID(
  input  [31:0] NPC_if_i,
  input  [31:0] Instr_if_i,
  input         clk,
  input         rst,
  input         IF_flush,
  input         PC_IFWrite,
  
  output [31:0] NPC_id_o,//New PC for ID stage
  output [31:0] Instr_id_o//Instruction for ID stage
  );
  
  reg [31:0] IF_ID_reg[1:0];
  /*
  IF_ID_Reg[0]: NPC_id
  IF_ID_Reg[1]: IR_id
  */
  always@(posedge clk or posedge rst)
  begin
    if (rst)
      begin
        IF_ID_reg[0] = 32'h0;
        IF_ID_reg[1] = 32'h0;
      end
    else if (PC_IFWrite)
      begin
        if (!IF_flush)
          begin
            IF_ID_reg[0] = NPC_if_i;
            IF_ID_reg[1] = Instr_if_i;
          end
        else
          begin
            IF_ID_reg[0] = 32'h0;
            IF_ID_reg[1] = 32'h0;
          end
      end
    $display("-------------------------------------------------------------------------------");
    $display("IF/ID: NPC_id = %8X, IR_id = %8X", IF_ID_reg[0], IF_ID_reg[1]);
  end
  assign NPC_id_o = IF_ID_reg[0];
  assign Instr_id_o = IF_ID_reg[1];
endmodule
