library verilog;
use verilog.vl_types.all;
entity MDR is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        Mdata_i         : in     vl_logic_vector(31 downto 0);
        data_o          : out    vl_logic_vector(31 downto 0)
    );
end MDR;
