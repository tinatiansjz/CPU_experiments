library verilog;
use verilog.vl_types.all;
entity IR is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        IRWrite         : in     vl_logic;
        Instr_i         : in     vl_logic_vector(31 downto 0);
        Instr_o         : out    vl_logic_vector(31 downto 0)
    );
end IR;
