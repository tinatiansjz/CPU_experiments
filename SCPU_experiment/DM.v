//Data Memory
module DM(
  input clk, 
  input rst_n,
  input [31:0] Addr_i,
  input [31:0] DataIn_i,//Data that needs to written back to DM
  input MemWrite_i,//DM control signal
  
  output [31:0] DataOut_o
  );
	wire [31:0] wdAddr;
	reg  [31:0] DMem[31:0];
	integer i;
	assign wdAddr = {2'b0, Addr_i[31:2]};//ImAddress shifts right for two bits
	
	always@(posedge clk or posedge rst_n)
	begin
	  if (rst_n)
	    begin
	      for (i = 1'b0; i < 32; i = i+1)
	        DMem[i] = 32'h0;
	    end
	  else
	    begin
	      if (MemWrite_i)
		    begin
			    DMem[wdAddr] = DataIn_i;
			    $display("M[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", DMem[0], DMem[1], DMem[2], DMem[3], DMem[4], DMem[5], DMem[6], DMem[7]);
          $display("M[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", DMem[8], DMem[9], DMem[10], DMem[11], DMem[12], DMem[13], DMem[14], DMem[15]);
          $display("M[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", DMem[16], DMem[17], DMem[18], DMem[19], DMem[20], DMem[21], DMem[22], DMem[23]);
          $display("M[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", DMem[24], DMem[25], DMem[26], DMem[27], DMem[28], DMem[29], DMem[30], DMem[31]);
			  end
	    end
	end
	assign DataOut_o = DMem[wdAddr];
endmodule

