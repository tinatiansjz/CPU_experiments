library verilog;
use verilog.vl_types.all;
entity MUX is
    generic(
        width           : integer := 1
    );
    port(
        d0              : in     vl_logic_vector(31 downto 0);
        d1              : in     vl_logic_vector(31 downto 0);
        d2              : in     vl_logic_vector(31 downto 0);
        d3              : in     vl_logic_vector(31 downto 0);
        s               : in     vl_logic_vector;
        data_o          : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end MUX;
