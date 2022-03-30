vlib $env(SOC_IT_SIMULATION_PATH)/brute_force_matcher
vmap brute_force_matcher $env(SOC_IT_SIMULATION_PATH)/brute_force_matcher
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/ip/xcku115/brute_force_matcher_squareRoot/brute_force_matcher_squareRoot_sim_netlist.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/ip/xcku115/brute_force_matcher_fixed_to_flt/brute_force_matcher_fixed_to_flt_sim_netlist.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/ip/xcku115/brute_force_matcher_dispatch_unit_dwc_fifo/brute_force_matcher_dispatch_unit_dwc_fifo_sim_netlist.v			
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/ip/xcku115/brute_force_matcher_secondary_buffer_fifo/brute_force_matcher_secondary_buffer_fifo_sim_netlist.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/ip/xcku115/brute_force_matcher_match_table_info_fifo/brute_force_matcher_match_table_info_fifo_sim_netlist.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog/brute_force_matcher_keypoint_dispatch_unit.v		
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog/brute_force_matcher_match_table.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog/brute_force_matcher_format_conv.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog/brute_force_matcher_preSubSquareAccum_DSP.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog/brute_force_matcher_circular_descriptor_buffer.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog/brute_force_matcher_secondary_descriptor_buffer.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog/SRL_bit.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog/SRL_bus.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog/address_incrementer.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog/brute_force_matcher.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog/brute_force_matcher_cluster_descriptor_engine.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog/brute_force_matcher_controller.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog/brute_force_matcher_descriptor_compute_pipeline.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog/brute_force_matcher_keyPointEngine.v
vlog -lint -sv +define+simulation +define+SIMULATION -work brute_force_matcher +incdir+$env(SOC_IT_ROOT)/soc_it_common/hardware/include +incdir+$env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog $env(SOC_IT_ROOT)/brute_force_matcher/hardware/verilog/brute_force_matcher_buffer_control.v