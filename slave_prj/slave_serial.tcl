# Copyright (C) 1991-2013 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.

# Quartus II: Generate Tcl File for Project
# File: slave_serial.tcl
# Generated on: Thu Feb 28 12:24:49 2019

# Load Quartus II Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "slave_serial"]} {
		puts "Project slave_serial is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists slave_serial]} {
		project_open -revision slave_serial slave_serial
	} else {
		project_new -revision slave_serial slave_serial
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION "13.0 SP1"
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "15:08:09  FEBRUARY 11, 2019"
	set_global_assignment -name LAST_QUARTUS_VERSION "13.0 SP1"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name VERILOG_FILE serial_receiver.v
	set_global_assignment -name VERILOG_FILE state_machine_rx.v
	set_global_assignment -name QIP_FILE pll1.qip
	set_global_assignment -name BDF_FILE slave_serial.bdf
	set_global_assignment -name SIGNALTAP_FILE output_files/stp1.stp
	set_global_assignment -name VERILOG_FILE uart_rx_lvds_10_words.v
	set_global_assignment -name VERILOG_FILE decod.v
	set_global_assignment -name QIP_FILE probe1.qip
	set_global_assignment -name SLD_FILE "E:/git_hub/fpga_serial/slave_prj/output_files/stp1_auto_stripped.stp"
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name NOMINAL_CORE_SUPPLY_VOLTAGE 1.2V
	set_global_assignment -name FAMILY "Cyclone III"
	set_global_assignment -name DEVICE_FILTER_PACKAGE FBGA
	set_global_assignment -name DEVICE EP3C16F484C6
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 1
	set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "2.5 V"
	set_global_assignment -name ENABLE_SIGNALTAP ON
	set_global_assignment -name USE_SIGNALTAP_FILE output_files/stp1.stp
	set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
	set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"
	set_global_assignment -name SLD_NODE_CREATOR_ID 110 -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_ENTITY_NAME sld_signaltap -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_DATA_BITS=12" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_TRIGGER_BITS=12" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_NODE_INFO=805334528" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_POWER_UP_TRIGGER=0" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_INVERSION_MASK=00000000000000000000000000000000000000000000000000000000000000000000000000000000000" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_INVERSION_MASK_LENGTH=83" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_STORAGE_QUALIFIER_INVERSION_MASK_LENGTH=0" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_SEGMENT_SIZE=128" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_ATTRIBUTE_MEM_MODE=OFF" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_STATE_FLOW_USE_GENERATED=1" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_STATE_BITS=2" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_STATE_FLOW_MGR_ENTITY=sld_reserved_slave_serial_auto_signaltap_0_flow_mgr_e982" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_BUFFER_FULL_STOP=0" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_CURRENT_RESOURCE_WIDTH=0" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_NODE_CRC_LOWORD=45475" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_NODE_CRC_HIWORD=51062" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_TRIGGER_LEVEL=2" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_SAMPLE_DEPTH=128" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_TRIGGER_IN_ENABLED=0" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_ADVANCED_TRIGGER_ENTITY=basic,1,basic,1," -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_TRIGGER_LEVEL_PIPELINE=1" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_ENABLE_ADVANCED_TRIGGER=0" -section_id auto_signaltap_0
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_location_assignment PIN_G21 -to clk
	set_location_assignment PIN_F1 -to reset
	set_location_assignment PIN_B1 -to timeout
	set_location_assignment PIN_B2 -to ready
	set_location_assignment PIN_D21 -to rx_in
	set_location_assignment PIN_D22 -to "rx_in(n)"
	set_instance_assignment -name IO_STANDARD LVDS -to rx_in
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_clk -to c1 -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[0] -to Q -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[1] -to byte_out[0] -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[2] -to byte_out[1] -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[3] -to byte_out[2] -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[4] -to byte_out[3] -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[5] -to byte_out[4] -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[6] -to byte_out[5] -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[7] -to byte_out[6] -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[8] -to byte_out[7] -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[9] -to ready -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[10] -to rx_syn -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[11] -to timeout -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[0] -to Q -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[1] -to byte_out[0] -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[2] -to byte_out[1] -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[3] -to byte_out[2] -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[4] -to byte_out[3] -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[5] -to byte_out[4] -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[6] -to byte_out[5] -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[7] -to byte_out[6] -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[8] -to byte_out[7] -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[9] -to ready -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[10] -to rx_syn -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[11] -to timeout -section_id auto_signaltap_0
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
