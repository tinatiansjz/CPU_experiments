library verilog;
use verilog.vl_types.all;
entity Ctrl is
    port(
        opcode_i        : in     vl_logic_vector(5 downto 0);
        mark_i          : in     vl_logic;
        funct_i         : in     vl_logic_vector(5 downto 0);
        Branch_o        : out    vl_logic_vector(2 downto 0);
        PCSource_o      : out    vl_logic_vector(1 downto 0);
        Jump_o          : out    vl_logic;
        EXTOp_o         : out    vl_logic_vector(1 downto 0);
        RegDst_o        : out    vl_logic_vector(1 downto 0);
        ALUSrcA_o       : out    vl_logic;
        ALUSrcB_o       : out    vl_logic;
        ALUOp_o         : out    vl_logic_vector(2 downto 0);
        BEOp_o          : out    vl_logic_vector(2 downto 0);
        MemRead_o       : out    vl_logic;
        MemWrite_o      : out    vl_logic;
        MemtoReg_o      : out    vl_logic_vector(1 downto 0);
        RegWrite_o      : out    vl_logic
    );
end Ctrl;
