//Program Counter (state element)
module PC(
  input         clk,
  input  [31:0] new_PC,
  input         PC_IFWrite,//1:allow to write, 0:forbit to write
  input         rst_n,
  output [31:0] PC_Addr
  );
	reg [31:0] PC;
	
	always@(posedge clk or negedge rst_n)
	begin
	  if (!rst_n)
	    begin
	      PC = 32'h0000_2ff4;
	    end
	  else
	    if (PC_IFWrite)
	    begin
	      PC = new_PC;
	      //$display("PC = %x", PC);
	    end  
	end
	assign PC_Addr = PC;
endmodule
	
	
