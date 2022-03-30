vlib work
vcom -lint -work work ../hardware/vhdl/psl_accel.vhdl
vlog -lint     +define+simulation +define+SIMULATION -work work +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include $env(GLBL_PATH)/glbl.v
vlog -lint -sv +define+simulation +define+SIMULATION -work work +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include ../hardware/ip/xcku115/mmcm_i250_o100_o200/mmcm_i250_o100_o200_sim_netlist.v
vlog -lint -sv +define+simulation +define+SIMULATION -work work +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+../hardware/verilog/ ../hardware/verilog/fpga.v
vlog -lint -sv +define+simulation +define+SIMULATION -work work +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include  ./testbench.v

vsim +notimingchecks -novopt -sv_lib $env(SOC_IT_ROOT)/soc_it_capi/software/pslse-master/afu_driver/src/libdpi -t 1ps -L work -L soc_it_common -L brute_force_matcher -L soc_it_capi -L secureip -L unisims_ver -L simprims_ver -L unimacro_ver -L unifast_ver -fsmdebug -c +nowarnTSCALE work.glbl work.testbench  

do wave.do.old
