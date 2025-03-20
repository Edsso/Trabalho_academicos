library verilog;
use verilog.vl_types.all;
entity risc_v32i_vlg_sample_tst is
    port(
        i_CLK           : in     vl_logic;
        i_RST           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end risc_v32i_vlg_sample_tst;
