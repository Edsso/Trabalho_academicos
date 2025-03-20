library verilog;
use verilog.vl_types.all;
entity risc_v32i is
    port(
        REG_WR          : out    vl_logic;
        i_CLK           : in     vl_logic;
        i_RST           : in     vl_logic;
        UAL_FONTE       : out    vl_logic;
        UAL_OP          : out    vl_logic;
        ALU_z           : out    vl_logic;
        ALU_DECODE      : out    vl_logic_vector(3 downto 0);
        ALU_OUT         : out    vl_logic_vector(31 downto 0);
        INSTRUCTION1    : out    vl_logic_vector(31 downto 0);
        PC              : out    vl_logic_vector(31 downto 0);
        RS1_VALUE       : out    vl_logic_vector(31 downto 0);
        RS2_VALUE       : out    vl_logic_vector(31 downto 0);
        SIG_EXT12_32    : out    vl_logic_vector(31 downto 0)
    );
end risc_v32i;
