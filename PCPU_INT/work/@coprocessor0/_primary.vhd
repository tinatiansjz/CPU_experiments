library verilog;
use verilog.vl_types.all;
entity Coprocessor0 is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        CauseEPCWrite_i : in     vl_logic;
        CRFWrite_i      : in     vl_logic;
        RETOp_i         : in     vl_logic;
        ExcCode_i       : in     vl_logic_vector(31 downto 0);
        EPC_i           : in     vl_logic_vector(31 downto 0);
        wa_i            : in     vl_logic_vector(4 downto 0);
        ra_i            : in     vl_logic_vector(4 downto 0);
        wd_i            : in     vl_logic_vector(31 downto 0);
        Cause_o         : out    vl_logic_vector(31 downto 0);
        Status_o        : out    vl_logic_vector(31 downto 0);
        EPC_o           : out    vl_logic_vector(31 downto 0);
        rd_o            : out    vl_logic_vector(31 downto 0)
    );
end Coprocessor0;
