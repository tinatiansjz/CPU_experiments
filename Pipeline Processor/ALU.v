`include "Instruction_def.v"
//Arithmetic Logic Unit
module ALU(
  input   [4:0]  ALU_control_i,
  input   [31:0] src0_i,//rs or shamt
  input   [31:0] src1_i,//rt or transformed imm
  output  [63:0] ALU_result_o//hi: high order 32 bits, lo: low order 32 bits
  );
	reg [63:0] ALU_result;
	reg Zero;
	
  initial								//initialize
	begin
		ALU_result = 0;
	end	
	
always@(*)
begin
    case (ALU_control_i)
//logic
    `ALUOP_AND:                                        //and
        ALU_result = src0_i & src1_i;              
	  `ALUOP_OR:                                         //or
		    ALU_result = src0_i | src1_i;
	  `ALUOP_NOR:                                        //nor
		    ALU_result = ~(src0_i | src1_i);
	  `ALUOP_XOR:	                                       //lui
		    ALU_result = src0_i ^ src1_i;
		    
//arith
		 `ALUOP_ADD:
		    ALU_result = add(src0_i, src1_i);
		 `ALUOP_SUB:
		 begin
		    ALU_result = sub(src0_i, src1_i);
		 end
     `ALUOP_SLT:  //Set on Less Than
        ALU_result = slt(src0_i, src1_i);
     `ALUOP_SLTU:  //Set on Less Than Unsigned
        ALU_result = sltu(src0_i, src1_i);
//div
     `ALUOP_DIV:   //
        ALU_result = div(src0_i, src1_i);
     `ALUOP_DIVU:  //
        ALU_result = divu(src0_i, src1_i);
//mul
     `ALUOP_MULT:  //
        ALU_result = mult(src0_i, src1_i);
     `ALUOP_MULTU: //
        ALU_result = multu(src0_i, src1_i);
//shift
     `ALUOP_SLL:  //Shift Word Left Logical
        ALU_result = sll(src0_i, src1_i);
     `ALUOP_SRL:  //Shift Word Right Logical
        ALU_result = srl(src0_i, src1_i);
     `ALUOP_SRA:  //Shift Word Right Arithmetic
        ALU_result = sra(src0_i, src1_i);

	  default:
		    ALU_result = 32'b0;
  endcase
end  

assign ALU_result_o = ALU_result;

function [63:0] mult;                                             //mult
  input [31:0] multiplicand;
  input [31:0] multiplier;
  integer      i;
  reg   [63:0] multiplicand_64;
  reg   [63:0] multiplier_64;
  begin
    mult = 0;
    //Sign-extension
    multiplicand_64 = {{32{multiplicand[31]}}, multiplicand[31:0]};
    multiplier_64 = {{32{multiplier[31]}}, multiplier[31:0]};
    
    for (i = 0; i < 64; i = i+1)
    begin
      if (multiplier_64[0]) 
        mult = mult + multiplicand_64;
      multiplicand_64 = multiplicand_64 << 1;//
      multiplier_64 = {multiplier_64[63], multiplier_64[63:1]} ;//multiplier shift right by 1 bit
    end
  end
endfunction
  
function [63:0] multu;                                             //multu
  input [31:0] multiplicand;
  input [31:0] multiplier;
  integer      i;
  reg   [63:0] multiplicand_64;
  reg   [63:0] multiplier_64;
  begin
    multu = 64'b0;
    multiplicand_64 = {32'h0, multiplicand[31:0]};
    multiplier_64 = {32'h0, multiplier[31:0]};
    for (i = 0; i < 32; i = i+1)
    begin
      if (multiplier_64[0]) 
        multu = multu + multiplicand_64;
      multiplicand_64 = multiplicand_64 << 1;//
      multiplier_64 = multiplier_64 >> 1 ;//
    end
  end
endfunction
  
function [63:0] add;                                               //add
  input [31:0] adder;
  input [31:0] addent;
  reg [31:0] add_32;
  begin
    add_32 = adder + addent;
    add = {32'h0, add_32[31:0]};
  end
endfunction

function [63:0] sub;                                               //sub
  input [31:0] subtrahend;//
  input [31:0] subtractor;//
  reg [31:0] opposite; //
  reg [31:0] sub_32;
  begin
    if (!subtractor[31]) //subtractor is positive
      opposite = ~subtractor + 1;//subtractor
    else//subtractor is negative
      opposite = ~(subtractor + 32'hffffffff);//subtractor = ~(subtractor - 1)
    sub_32 = subtrahend + opposite;
    sub = {32'h0, sub_32[31:0]};
  end
endfunction

function [63:0] div;//remainder:[63:32], quotient:[31:0]               //div
  input [31:0] divident_32;//
  input [31:0] divisor_32;//
  reg [63:0] divisor_64;
  reg [63:0] divident_64;
  reg [31:0] quotient_32;
  reg [63:0] remainder_64;
  //reg [63:0] sub_64;
  integer    i;
  integer    divident_sign;
  integer    divisor_sign;
  begin
    divident_sign = divident_32[31];
    divisor_sign = divisor_32[31];
    if (divident_sign) divident_32 = ~(divident_32 + 32'hffff_ffff);//divident
    if (divisor_sign)  divisor_32  = ~(divisor_32 + 32'hffff_ffff);//divisor
    divisor_64 = {divisor_32[31:0], 32'h0};
    remainder_64 = {32'h0, divident_32[31:0]};
    for (i = 0; i < 33; i = i+1)
    begin
      remainder_64 = remainder_64 - divisor_64;
      if (remainder_64[63] == 1'b1)//Remainder_64 < Divisor_64
        begin
          remainder_64 = remainder_64 + divisor_64;
          quotient_32 = quotient_32 << 1;//
          divisor_64 = divisor_64 >> 1;//
        end
      else
        begin
          quotient_32 = quotient_32 << 1'b1;//
          quotient_32[0] = 1'b1;//
          divisor_64 = divisor_64 >> 1'b1;//
        end
    end
    if (divident_sign) remainder_64 = ~remainder_64 + 1;//divident is negative
    if (divident_sign ^ divisor_sign) quotient_32 = ~quotient_32 + 1;//divident_sign and divisor_sign are  different
    div = {remainder_64[31:0], quotient_32[31:0]};
  end
endfunction

function [63:0] divu;//remainder:[63:32], quotient:[31:0]                          //divu
  input [31:0] divident_32;//
  input [31:0] divisor_32;//
  reg [63:0] divisor_64;
  reg [63:0] divident_64;
  reg [31:0] quotient_32;
  reg [63:0] remainder_64;
  integer    i;
  begin
    divisor_64 = {divisor_32[31:0], 32'h0};
    remainder_64 = {32'h0, divident_32[31:0]};
    for (i = 0; i < 33; i = i+1)
    begin
     // remainder_64 = remainder_64 - divisor_64;
      if (remainder_64 < divisor_64)//Remainder_64 < Divisor_64
        begin
      //    remainder_64 = remainder_64 + divisor_64;
          quotient_32 = quotient_32 << 1'b1;//
          divisor_64 = divisor_64 >> 1'b1;//
        end
      else
        begin
          remainder_64 = remainder_64 - divisor_64;
          quotient_32 = quotient_32 << 1'b1;//
          quotient_32[0] = 1;//
          divisor_64 = divisor_64 >> 1'b1;//
        end
    end
    divu = {remainder_64[31:0], quotient_32[31:0]};
  end
endfunction

function [63:0] slt;                                                       //slt
  input   [31:0] src0_i;//rs
  input   [31:0] src1_i;//rt
  reg     [31:0] sub_32;
  integer        src0_sign;
  integer        src1_sign;
  begin
    src0_sign = src0_i[31];
    src1_sign = src1_i[31];
    if (src0_sign == 1'b1 && src1_sign == 1'b0) slt = 64'b1;
    else if (src0_sign == 1'b0 && src1_sign == 1'b1) slt = 64'b0;
    else//src0_i?src1_i????
    begin
      sub_32 = src0_i - src1_i;
      if (sub_32[31]) slt = 64'h1;
      else slt = 64'b0;
    end
  end
endfunction
  
function [63:0] sltu;                            //sltu
  input   [31:0] src0_i;//rs
  input   [31:0] src1_i;//rt
  reg     [31:0] sub_32;
  integer        src0_sign;
  integer        src1_sign;
  begin
    src0_sign = src0_i[31];
    src1_sign = src1_i[31];
    if (src0_sign == 1 && src1_sign == 0) sltu = 64'h0;
    else if (src0_sign == 1'b0 && src1_sign == 1'b1) sltu = 64'h1;
    else//src0_i?src1_i????
    begin
      sub_32 = src0_i - src1_i;
      if (sub_32[31]) sltu = 64'h1;
      else sltu = 64'h0;
    end
  end
endfunction

function [63:0] sll;                              //sll
  input   [31:0] src0_i;//rs or shamt
  input   [31:0] src1_i;//rt
  integer        i;
  reg     [4:0]  shift;
  begin 
    shift = {src0_i[4:0]};
    for (i = 0; i < shift; i = i+1)
      src1_i = {src1_i[30:0], 1'b0};
    sll = {32'h0, src1_i[31:0]};
  end
endfunction

function [63:0] srl;                              //srl
  input   [31:0] src0_i;//rs or shamt
  input   [31:0] src1_i;//rt
  integer        i;
  reg     [4:0]  shift;
  begin 
    shift = {src0_i[4:0]};
    srl = {32'h0, src1_i[31:0]};
    for (i = 0; i < shift; i = i+1)
      src1_i = {1'b0, src1_i[31:1]};
    srl = {32'h0, src1_i[31:0]};
  end
endfunction

function [63:0] sra;                              //sra
  input   [31:0] src0_i;//rs or shamt
  input   [31:0] src1_i;//rt
  integer        i;
  reg     [4:0]  shift;
  begin 
    shift = {src0_i[4:0]};
    for (i = 0; i < shift; i = i+1)
      src1_i = {src1_i[31],src1_i[31:1]};
    sra = {32'h0, src1_i[31:0]};
  end
endfunction
endmodule
