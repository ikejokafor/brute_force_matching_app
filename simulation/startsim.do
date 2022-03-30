vlib work
vcom -lint -work work ..\\hardware\\vhdl\\psl_accel.vhdl
vlog -lint     +define+simulation +define+SIMULATION -work work +incdir+C:/SOC_IT/\\soc_it_common\\hardware\\include  C:\\Xilinx\\Vivado\\2016.1\\data\\verilog\\src\\glbl.v
vlog -lint -sv +define+simulation +define+SIMULATION -work work +incdir+C:/SOC_IT/\\soc_it_common\\hardware\\include ..\\hardware\\ip\\xcku115\\mmcm_i250_o100_o27\\mmcm_i250_o100_o27.v
vlog -lint -sv +define+simulation +define+SIMULATION -work work +incdir+C:/SOC_IT/\\soc_it_common\\hardware\\include ..\\hardware\\ip\\xcku115\\mmcm_i250_o100_o27\\mmcm_i250_o100_o27_clk_wiz.v
vlog -lint -sv +define+simulation +define+SIMULATION -work work +incdir+C:/SOC_IT/\\soc_it_common\\hardware\\include +incdir+..\\hardware\\verilog\\ ..\\hardware\\verilog\\fpga.v
vlog -lint -sv +define+simulation +define+SIMULATION -work work +incdir+C:/SOC_IT/\\soc_it_common\\hardware\\include  .\\testbench.v

vsim +notimingchecks -novopt -sv_lib C:\\SOC_IT\\pslse\\afu_driver\\build\\afu_driver -t 1ps -L blk_mem_gen_v8_3_5 -L fifo_generator_v13_1_3 -L fifo_generator_v13_0_5 -L fifo_generator_v12_0_5 -L work -L soc_it_common -L brute_force_matcher -L soc_it_capi -L secureip -L unisims_ver -L simprims_ver -L unimacro_ver -L unifast_ver -fsmdebug -c +nowarnTSCALE work.glbl work.testbench

do wave.do
