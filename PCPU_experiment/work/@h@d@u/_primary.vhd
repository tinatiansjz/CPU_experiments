library verilog;
use verilog.vl_types.all;
entity HDU is
    port(
        MemRead_ex      : in     vl_logic;
        MemRead_mem     : in     vl_logic;
        Rs_id           : in     vl_logic_vector(4 downto 0);
        Rt_id           : in     vl_logic_vector(4 downto 0);
        Rt_ex           : in     vl_logic_vector(4 downto 0);
        RD_ex           : in     vl_logic_vector(4 downto 0);
        RD_mem          : in     vl_logic_vector(4 downto 0);
        Jump_id         : in     vl_logic;
        op_id           : in     vl_logic_vector(5 downto 0);
        RegWrite_ex     : in     vl_logic;
        RegWrite_mem    : in     vl_logic;
        Branch_id       : in     vl_logic_vector(2 downto 0);
        stall_o         : out    vl_logic;
        PC_IFWrite_o    : out    vl_logic
    );
end HDU;
