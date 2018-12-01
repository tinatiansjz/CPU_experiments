library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        aluop_i         : in     vl_logic_vector(4 downto 0);
        src0_i          : in     vl_logic_vector(31 downto 0);
        src1_i          : in     vl_logic_vector(31 downto 0);
        aluout_o        : out    vl_logic_vector(63 downto 0);
        zero_o          : out    vl_logic
    );
end alu;
