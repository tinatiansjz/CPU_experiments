library verilog;
use verilog.vl_types.all;
entity PC is
    port(
        new_PC          : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        PC_Addr         : out    vl_logic_vector(31 downto 0)
    );
end PC;
