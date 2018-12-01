library verilog;
use verilog.vl_types.all;
entity Add_PC is
    port(
        PC              : in     vl_logic_vector(31 downto 0);
        new_PC_o        : out    vl_logic_vector(31 downto 0)
    );
end Add_PC;
