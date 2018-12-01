library verilog;
use verilog.vl_types.all;
entity SYNinterrupt is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        INT             : in     vl_logic;
        SYN_INT         : out    vl_logic
    );
end SYNinterrupt;
