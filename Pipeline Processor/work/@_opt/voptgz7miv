library verilog;
use verilog.vl_types.all;
entity MEM_WB is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        Signal_mem_i    : in     vl_logic_vector(31 downto 0);
        NPC_mem_i       : in     vl_logic_vector(31 downto 0);
        MD_i            : in     vl_logic_vector(31 downto 0);
        ALUOut_mem_i    : in     vl_logic_vector(31 downto 0);
        EXT_mem_i       : in     vl_logic_vector(31 downto 0);
        RD_mem_i        : in     vl_logic_vector(31 downto 0);
        MemtoReg_wb_o   : out    vl_logic_vector(1 downto 0);
        RegWrite_wb_o   : out    vl_logic;
        NPC_wb_o        : out    vl_logic_vector(31 downto 0);
        MD_wb_o         : out    vl_logic_vector(31 downto 0);
        ALUOut_wb_o     : out    vl_logic_vector(31 downto 0);
        EXT_wb_o        : out    vl_logic_vector(31 downto 0);
        RD_wb_o         : out    vl_logic_vector(31 downto 0)
    );
end MEM_WB;
