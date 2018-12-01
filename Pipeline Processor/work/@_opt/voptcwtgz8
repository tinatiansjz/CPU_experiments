library verilog;
use verilog.vl_types.all;
entity FU is
    port(
        Rs_id           : in     vl_logic_vector(4 downto 0);
        Jump_id         : in     vl_logic;
        Rs_ex           : in     vl_logic_vector(4 downto 0);
        Rt_ex           : in     vl_logic_vector(4 downto 0);
        Rd_ex           : in     vl_logic_vector(4 downto 0);
        Rd_mem          : in     vl_logic_vector(4 downto 0);
        Rd_wb           : in     vl_logic_vector(4 downto 0);
        op_id           : in     vl_logic_vector(5 downto 0);
        op_ex           : in     vl_logic_vector(5 downto 0);
        MemWrite_ex     : in     vl_logic;
        RegWrite_ex     : in     vl_logic;
        RegWrite_mem    : in     vl_logic;
        RegWrite_wb     : in     vl_logic;
        ForwardA_o      : out    vl_logic_vector(1 downto 0);
        ForwardB_o      : out    vl_logic_vector(1 downto 0);
        ForwardC_o      : out    vl_logic_vector(1 downto 0);
        ForwardD_o      : out    vl_logic_vector(1 downto 0)
    );
end FU;
