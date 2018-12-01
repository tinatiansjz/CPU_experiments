module Branch_Ctrl(
  input [2:0] Branch_i,//signal to determine which branch instruction is executing
  input Zero_i,//outcome from ALU
  input Sign_i,//the ALU outcome's sign (to determine the output is negative or positive
  
  output enable_o
  );
  reg enable;
  always@(*)
  begin
    if (Branch_i == 3'b000)//beq
      begin
        if (Zero_i == 1'b1) enable = 1'b1;
        else enable = 1'b0;
      end
    else if (Branch_i == 3'b001)//bne
      begin
        if (Zero_i == 1'b0) enable = 1'b1;
        else enable = 1'b0;
      end
    else if (Branch_i == 3'b100)//blez
      begin
        if (Zero_i == 1'b0 && Sign_i == 0) enable = 1'b0;
        else enable = 1'b1;
      end
    else if (Branch_i == 3'b010)//bgtz
      begin
        if (Zero_i == 1'b0 && Sign_i == 0) enable = 1'b1;
        else enable = 1'b0;
      end
    else if (Branch_i == 3'b011)//bltz
      begin
        if (Zero_i == 1'b0 && Sign_i == 1) enable = 1'b1;
        else enable = 1'b0;
      end
    else if (Branch_i == 3'b101)//bgez
      begin
        if (Zero_i == 1'b0 && Sign_i == 1) enable = 1'b0;
        else enable = 1'b1;
      end
  end
  assign enable_o = enable;
endmodule
