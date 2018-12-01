library verilog;
use verilog.vl_types.all;
entity Multi_CPU is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        MIO_ready       : in     vl_logic;
        Data_in         : in     vl_logic_vector(31 downto 0);
        INT             : in     vl_logic;
        mem_w           : out    vl_logic;
        inst_out        : out    vl_logic_vector(31 downto 0);
        PC_out          : out    vl_logic_vector(31 downto 0);
        Addr_out        : out    vl_logic_vector(31 downto 0);
        Data_out        : out    vl_logic_vector(31 downto 0);
        state           : out    vl_logic_vector(4 downto 0);
        CPU_MIO         : out    vl_logic
    );
end Multi_CPU;
