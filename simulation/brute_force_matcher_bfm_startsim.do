vlib work_bfm
vlog -lint +define+simulation +define+SIMULATION -work work_bfm +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include $env(GLBL_PATH)/glbl.v
vlog -lint -sv -work work_bfm +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include soc_it_driver.sv
vlog -lint -sv -work work_bfm +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include soc_it_master_data_ports.sv
vlog -lint -sv -work work_bfm +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include soc_it_master_descriptor_ports.sv
vlog -lint -sv -work work_bfm +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include soc_it_master_request_ports.sv
vlog -lint -sv -work work_bfm +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include soc_it_slave_ports.sv
vlog -lint -sv -work work_bfm +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include soc_it_bfm_program.sv
vlog -lint -sv -work work_bfm +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include soc_it_bfm_top.sv
vlog -lint -sv -work work_bfm +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include testbench.sv


vsim +notimingchecks -novopt -t 1ps -L work_bfm -L soc_it_common -L brute_force_matcher -L soc_it_capi -L secureip -L unisims_ver -L simprims_ver -L unimacro_ver -L unifast_ver -fsmdebug -c +nowarnTSCALE work_bfm.glbl work_bfm.testbench_bfm

do wave.do
run -all
