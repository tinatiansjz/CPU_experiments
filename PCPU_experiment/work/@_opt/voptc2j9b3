library verilog;
use verilog.vl_types.all;
entity ID_EX is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        stall           : in     vl_logic;
        IF_flush        : in     vl_logic;
        RegDst_id_i     : in     vl_logic_vector(1 downto 0);
        ALUSrcA_id_i    : in     vl_logic;
        ALUSrcB_id_i    : in     vl_logic;
        ALUOp_id_i      : in     vl_logic_vector(2 downto 0);
        BEOp_id_i       : in     vl_logic_vector(2 downto 0);
        MemRead_id_i    : in     vl_logic;
        MemWrite_id_i   : in     vl_logic;
        MemtoReg_id_i   : in     vl_logic_vector(1 downto 0);
        RegWrite_id_i   : in     vl_logic;
        NPC_id_i        : in     vl_logic_vector(31 downto 0);
        BA_id_i         : in     vl_logic_vector(31 downto 0);
        rs_id_i         : in     vl_logic_vector(31 downto 0);
        rt_id_i         : in     vl_logic_vector(31 downto 0);
        EXT_id_i        : in     vl_logic_vector(31 downto 0);
        Instr_id_i      : in     vl_logic_vector(31 downto 0);
        ALUOp_ex_o      : out    vl_logic_vector(2 downto 0);
        ALUSrcB_ex_o    : out    vl_logic;
        ALUSrcA_ex_o    : out    vl_logic;
        RegDst_ex_o     : out    vl_logic_vector(1 downto 0);
        Signal_ex_o     : out    vl_logic_vector(31 downto 0);
        NPC_ex_o        : out    vl_logic_vector(31 downto 0);
        rs_ex_o         : out    vl_logic_vector(31 downto 0);
        rt_ex_o         : out    vl_logic_vector(31 downto 0);
        EXT_ex_o        : out    vl_logic_vector(31 downto 0);
        Instr_ex_o      : out    vl_logic_vector(31 downto 0)
    );
end ID_EX;
