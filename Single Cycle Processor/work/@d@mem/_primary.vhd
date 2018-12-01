library verilog;
use verilog.vl_types.all;
entity DMem is
    port(
        clk             : in     vl_logic;
        DataAddr_i      : in     vl_logic_vector(31 downto 0);
        DataIn_i        : in     vl_logic_vector(31 downto 0);
        MemWrite_i      : in     vl_logic;
        MemRead_i       : in     vl_logic;
        DataOut_o       : out    vl_logic_vector(31 downto 0)
    );
end DMem;
