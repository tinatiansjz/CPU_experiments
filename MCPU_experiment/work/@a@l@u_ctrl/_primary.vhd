library verilog;
use verilog.vl_types.all;
entity ALU_ctrl is
    port(
        funct_i         : in     vl_logic_vector(3 downto 0);
        ALUOp_i         : in     vl_logic_vector(1 downto 0);
        ALUOP_o         : out    vl_logic_vector(4 downto 0)
    );
end ALU_ctrl;
