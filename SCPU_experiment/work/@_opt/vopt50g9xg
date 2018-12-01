library verilog;
use verilog.vl_types.all;
entity Ctrl is
    port(
        opcode_i        : in     vl_logic_vector(5 downto 0);
        RegDst_o        : out    vl_logic_vector(1 downto 0);
        ALUSrc_o        : out    vl_logic;
        MemtoReg_o      : out    vl_logic_vector(1 downto 0);
        RegWrite_o      : out    vl_logic;
        MemWrite_o      : out    vl_logic;
        Branch_o        : out    vl_logic;
        ALUOp_o         : out    vl_logic_vector(1 downto 0);
        Jump_o          : out    vl_logic;
        EXTOp_o         : out    vl_logic_vector(1 downto 0)
    );
end Ctrl;
