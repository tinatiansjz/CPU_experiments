library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        ALU_control_i   : in     vl_logic_vector(4 downto 0);
        src0_i          : in     vl_logic_vector(31 downto 0);
        src1_i          : in     vl_logic_vector(31 downto 0);
        ALU_result_o    : out    vl_logic_vector(63 downto 0)
    );
end ALU;
