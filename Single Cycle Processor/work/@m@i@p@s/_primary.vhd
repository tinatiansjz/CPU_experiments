library verilog;
use verilog.vl_types.all;
entity MIPS is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        PC_Addr         : out    vl_logic_vector(31 downto 0);
        Instr           : out    vl_logic_vector(31 downto 0);
        ALU_result      : out    vl_logic_vector(63 downto 0);
        wa_i            : out    vl_logic_vector(31 downto 0)
    );
end MIPS;
