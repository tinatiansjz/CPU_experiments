library verilog;
use verilog.vl_types.all;
entity IF_ID is
    port(
        NPC_if_i        : in     vl_logic_vector(31 downto 0);
        Instr_if_i      : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        IF_flush        : in     vl_logic;
        PC_IFWrite      : in     vl_logic;
        NPC_id_o        : out    vl_logic_vector(31 downto 0);
        Instr_id_o      : out    vl_logic_vector(31 downto 0)
    );
end IF_ID;
