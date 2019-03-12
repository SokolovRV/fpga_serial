transcript on
vmap altera_ver C:/modelsim_lib/verilog_libs/altera_ver
vmap cycloneiii_ver C:/modelsim_lib/verilog_libs/cycloneiii_ver
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {master_serial.vo}

vlog -vlog01compat -work work +incdir+E:/git_hub/fpga_serial/master_prj/simulation/modelsim {E:/git_hub/fpga_serial/master_prj/simulation/modelsim/master_serial.vt}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneiii_ver -L gate_work -L work -voptargs="+acc"  master_serial_vlg_tst

add wave *
view structure
view signals
run 1 ms
