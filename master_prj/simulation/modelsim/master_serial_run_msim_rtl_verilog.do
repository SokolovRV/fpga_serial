transcript on
vmap altera_ver C:/modelsim_lib/verilog_libs/altera_ver
vmap lpm_ver C:/modelsim_lib/verilog_libs/lpm_ver
vmap sgate_ver C:/modelsim_lib/verilog_libs/sgate_ver
vmap altera_mf_ver C:/modelsim_lib/verilog_libs/altera_mf_ver
vmap altera_lnsim_ver C:/modelsim_lib/verilog_libs/altera_lnsim_ver
vmap cycloneiii_ver C:/modelsim_lib/verilog_libs/cycloneiii_ver
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/git_hub/fpga_serial/master_prj {E:/git_hub/fpga_serial/master_prj/serial_receiver.v}
vlog -vlog01compat -work work +incdir+E:/git_hub/fpga_serial/master_prj {E:/git_hub/fpga_serial/master_prj/serial_transmitter.v}

vlog -vlog01compat -work work +incdir+E:/git_hub/fpga_serial/master_prj/simulation/modelsim {E:/git_hub/fpga_serial/master_prj/simulation/modelsim/master_serial.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  master_serial_vlg_tst

add wave *
view structure
view signals
run 1 ms
