library verilog;
use verilog.vl_types.all;
entity Ctrl is
    port(
        INT             : in     vl_logic;
        Instr_i         : in     vl_logic_vector(31 downto 0);
        opcode_i        : in     vl_logic_vector(5 downto 0);
        mark_i          : in     vl_logic;
        funct_i         : in     vl_logic_vector(5 downto 0);
        Overflow_i      : in     vl_logic;
        Status_i        : in     vl_logic_vector(31 downto 0);
        PC_IFWrite_i    : in     vl_logic;
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
        RegWrite_o      : out    vl_logic;
        CauseEPCWrite_o : out    vl_logic;
        Cause_o         : out    vl_logic_vector(1 downto 0);
        EPCOp_o         : out    vl_logic_vector(1 downto 0);
        PCOp_o          : out    vl_logic_vector(1 downto 0);
        RETOp_o         : out    vl_logic;
        CRFWrite_o      : out    vl_logic;
        First_o         : out    vl_logic;
        Exception_o     : out    vl_logic
    );
end Ctrl;
