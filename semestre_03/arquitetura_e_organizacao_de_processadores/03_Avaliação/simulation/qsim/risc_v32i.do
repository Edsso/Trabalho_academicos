onerror {quit -f}
vlib work
vlog -work work risc_v32i.vo
vlog -work work risc_v32i.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.risc_v32i_vlg_vec_tst
vcd file -direction risc_v32i.msim.vcd
vcd add -internal risc_v32i_vlg_vec_tst/*
vcd add -internal risc_v32i_vlg_vec_tst/i1/*
add wave /*
run -all
