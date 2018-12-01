library verilog;
use verilog.vl_types.all;
entity EXT is
    port(
        Imm16_i         : in     vl_logic_vector(15 downto 0);
        EXTOp           : in     vl_logic_vector(1 downto 0);
        Imm32_o         : out    vl_logic_vector(31 downto 0)
    );
end EXT;
