library verilog;
use verilog.vl_types.all;
entity PC_Ctrl is
    port(
        enable_i        : in     vl_logic;
        PCSource_i      : in     vl_logic_vector(1 downto 0);
        Signal_o        : out    vl_logic_vector(1 downto 0)
    );
end PC_Ctrl;
