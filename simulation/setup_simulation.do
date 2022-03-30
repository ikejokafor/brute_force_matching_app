cd $env(SOC_IT_SIMULATION_PATH)

do $env(SOC_IT_ROOT)/soc_it_common/sim_compile.do

do $env(SOC_IT_ROOT)/soc_it_nif/sim_compile.do

do $env(SOC_IT_ROOT)/soc_it_capi/sim_compile.do

do $env(SOC_IT_ROOT)/soc_it_message_router/sim_compile.do

do $env(SOC_IT_ROOT)/brute_force_matcher/sim_compile.do

exit
