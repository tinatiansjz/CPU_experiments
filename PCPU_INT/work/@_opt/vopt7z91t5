library verilog;
use verilog.vl_types.all;
entity EX_MEM is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        Signal_ex_i     : in     vl_logic_vector(31 downto 0);
        NPC_ex_i        : in     vl_logic_vector(31 downto 0);
        ALUOut_ex_i     : in     vl_logic_vector(31 downto 0);
        rd2_ex_i        : in     vl_logic_vector(31 downto 0);
        EXT_ex_i        : in     vl_logic_vector(31 downto 0);
        RD_ex_i         : in     vl_logic_vector(31 downto 0);
        CD_ex_i         : in     vl_logic_vector(31 downto 0);
        IF_flush_i      : in     vl_logic;
        Cause_i         : in     vl_logic_vector(1 downto 0);
        Signal_mem_o    : out    vl_logic_vector(31 downto 0);
        BEOp_mem_o      : out    vl_logic_vector(2 downto 0);
        MemRead_mem_o   : out    vl_logic;
        MemWrite_mem_o  : out    vl_logic;
        NPC_mem_o       : out    vl_logic_vector(31 downto 0);
        ALUOut_mem_o    : out    vl_logic_vector(31 downto 0);
        rt_mem_o        : out    vl_logic_vector(31 downto 0);
        EXT_mem_o       : out    vl_logic_vector(31 downto 0);
        RD_mem_o        : out    vl_logic_vector(31 downto 0);
        CD_mem_o        : out    vl_logic_vector(31 downto 0)
    );
end EX_MEM;
