library verilog;
use verilog.vl_types.all;
entity PU is
    port(
        Rs_ex           : in     vl_logic_vector(4 downto 0);
        Rt_ex           : in     vl_logic_vector(4 downto 0);
        Rd_mem          : in     vl_logic_vector(4 downto 0);
        Rd_wb           : in     vl_logic_vector(4 downto 0);
        RegWrite_mem    : in     vl_logic;
        RegWrite_wb     : in     vl_logic;
        ForwardA_o      : out    vl_logic_vector(1 downto 0);
        ForwardB_o      : out    vl_logic_vector(1 downto 0)
    );
end PU;
