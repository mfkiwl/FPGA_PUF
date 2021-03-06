# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7s50fgga484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.cache/wt [current_project]
set_property parent.project_path C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/uart/FIFO.v
  C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/PUF/Glitch_PUF.v
  C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/PUF/Glitch_PUF_Pack.v
  C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/LBlock/LBlock.v
  C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/LBlock/LBlock_Pack.v
  C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/PUF/Mux2t1.v
  C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/PUF/PUF.v
  C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/PUF/Xor.v
  C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/PUF/flipflop_rst.v
  C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/uart/uart_controller.v
  C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/uart/uart_controller8bit.v
  C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/uart/uart_rx.v
  C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/uart/uart_tx.v
  C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/cmd_handler.v
}
read_ip -quiet C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/PUF/PLL/PLL.xci
set_property used_in_implementation false [get_files -all c:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/PUF/PLL/PLL_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/PUF/PLL/PLL.xdc]
set_property used_in_implementation false [get_files -all c:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/PUF/PLL/PLL_late.xdc]
set_property used_in_implementation false [get_files -all c:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/sources_1/new/LBlockUART/PUF/PLL/PLL_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/constrs_1/new/Glitch_PUF.xdc
set_property used_in_implementation false [get_files C:/Users/admin/Desktop/FPGA_PUF/Glitch_PUF.srcs/constrs_1/new/Glitch_PUF.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top cmd_handler -part xc7s50fgga484-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef cmd_handler.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file cmd_handler_utilization_synth.rpt -pb cmd_handler_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
