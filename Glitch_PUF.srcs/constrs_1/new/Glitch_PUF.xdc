############## NET - IOSTANDARD ##################
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
#############SPI Configurate Setting##################
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
#create_clock -period 20 [get_ports clk_50M]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN P15 [get_ports clk]
#############LED Setting##################
#set_property PACKAGE_PIN T20 [get_ports test[0]]
#set_property IOSTANDARD LVCMOS33 [get_ports test[0]]
#set_property PACKAGE_PIN T19 [get_ports test[1]]
#set_property IOSTANDARD LVCMOS33 [get_ports test[1]]
#set_property PACKAGE_PIN V20 [get_ports test[2]]
#set_property IOSTANDARD LVCMOS33 [get_ports test[2]]
#set_property PACKAGE_PIN U20 [get_ports test[3]]
#set_property IOSTANDARD LVCMOS33 [get_ports test[3]]

#set_property PACKAGE_PIN H16 [get_ports Response[0]]
#set_property IOSTANDARD LVCMOS33 [get_ports Response[0]]
#set_property PACKAGE_PIN G16 [get_ports Response[1]]
#set_property IOSTANDARD LVCMOS33 [get_ports Response[1]]
#set_property PACKAGE_PIN K15 [get_ports Response[2]]
#set_property IOSTANDARD LVCMOS33 [get_ports Response[2]]
#set_property PACKAGE_PIN J15 [get_ports Response[3]]
#set_property IOSTANDARD LVCMOS33 [get_ports Response[3]]

set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
set_property PACKAGE_PIN M15 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rx]
set_property PACKAGE_PIN B16 [get_ports uart_rx]
#set_property PACKAGE_PIN U20 [get_ports uart_rx]
set_property IOSTANDARD LVCMOS33 [get_ports uart_tx]
set_property PACKAGE_PIN D11 [get_ports uart_tx]
#set_property PACKAGE_PIN V20 [get_ports uart_tx]


#set_property IOSTANDARD LVCMOS33 [get_ports CLK_50M_P]
#set_property PACKAGE_PIN Y21 [get_ports CLK_50M_P]
#set_property IOSTANDARD LVCMOS33 [get_ports CLK_50M_N]
#set_property PACKAGE_PIN W21 [get_ports CLK_50M_N]
#set_property LOC SLICE_X2Y101 [get_cells CARRY4_inst1]
#set_property LOC SLICE_X2Y100 [get_cells CARRY4_inst2]







create_pblock pblock_m_PUF
add_cells_to_pblock [get_pblocks pblock_m_PUF] [get_cells -quiet [list m_PUF]]
resize_pblock [get_pblocks pblock_m_PUF] -add {CLOCKREGION_X0Y2:CLOCKREGION_X0Y2}
create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 2 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 8 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {m_request_FIFO/debug_FIFO[24]_7[0]} {m_request_FIFO/debug_FIFO[24]_7[1]} {m_request_FIFO/debug_FIFO[24]_7[2]} {m_request_FIFO/debug_FIFO[24]_7[3]} {m_request_FIFO/debug_FIFO[24]_7[4]} {m_request_FIFO/debug_FIFO[24]_7[5]} {m_request_FIFO/debug_FIFO[24]_7[6]} {m_request_FIFO/debug_FIFO[24]_7[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 8 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {m_request_FIFO/debug_FIFO[5]_26[0]} {m_request_FIFO/debug_FIFO[5]_26[1]} {m_request_FIFO/debug_FIFO[5]_26[2]} {m_request_FIFO/debug_FIFO[5]_26[3]} {m_request_FIFO/debug_FIFO[5]_26[4]} {m_request_FIFO/debug_FIFO[5]_26[5]} {m_request_FIFO/debug_FIFO[5]_26[6]} {m_request_FIFO/debug_FIFO[5]_26[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {m_request_FIFO/debug_FIFO[31]_0[0]} {m_request_FIFO/debug_FIFO[31]_0[1]} {m_request_FIFO/debug_FIFO[31]_0[2]} {m_request_FIFO/debug_FIFO[31]_0[3]} {m_request_FIFO/debug_FIFO[31]_0[4]} {m_request_FIFO/debug_FIFO[31]_0[5]} {m_request_FIFO/debug_FIFO[31]_0[6]} {m_request_FIFO/debug_FIFO[31]_0[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 8 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {m_request_FIFO/debug_FIFO[0]_31[0]} {m_request_FIFO/debug_FIFO[0]_31[1]} {m_request_FIFO/debug_FIFO[0]_31[2]} {m_request_FIFO/debug_FIFO[0]_31[3]} {m_request_FIFO/debug_FIFO[0]_31[4]} {m_request_FIFO/debug_FIFO[0]_31[5]} {m_request_FIFO/debug_FIFO[0]_31[6]} {m_request_FIFO/debug_FIFO[0]_31[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 8 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {m_request_FIFO/debug_FIFO[23]_8[0]} {m_request_FIFO/debug_FIFO[23]_8[1]} {m_request_FIFO/debug_FIFO[23]_8[2]} {m_request_FIFO/debug_FIFO[23]_8[3]} {m_request_FIFO/debug_FIFO[23]_8[4]} {m_request_FIFO/debug_FIFO[23]_8[5]} {m_request_FIFO/debug_FIFO[23]_8[6]} {m_request_FIFO/debug_FIFO[23]_8[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 8 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {m_request_FIFO/debug_FIFO[9]_22[0]} {m_request_FIFO/debug_FIFO[9]_22[1]} {m_request_FIFO/debug_FIFO[9]_22[2]} {m_request_FIFO/debug_FIFO[9]_22[3]} {m_request_FIFO/debug_FIFO[9]_22[4]} {m_request_FIFO/debug_FIFO[9]_22[5]} {m_request_FIFO/debug_FIFO[9]_22[6]} {m_request_FIFO/debug_FIFO[9]_22[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 8 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {m_request_FIFO/debug_FIFO[27]_4[0]} {m_request_FIFO/debug_FIFO[27]_4[1]} {m_request_FIFO/debug_FIFO[27]_4[2]} {m_request_FIFO/debug_FIFO[27]_4[3]} {m_request_FIFO/debug_FIFO[27]_4[4]} {m_request_FIFO/debug_FIFO[27]_4[5]} {m_request_FIFO/debug_FIFO[27]_4[6]} {m_request_FIFO/debug_FIFO[27]_4[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 8 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {m_request_FIFO/debug_FIFO[30]_1[0]} {m_request_FIFO/debug_FIFO[30]_1[1]} {m_request_FIFO/debug_FIFO[30]_1[2]} {m_request_FIFO/debug_FIFO[30]_1[3]} {m_request_FIFO/debug_FIFO[30]_1[4]} {m_request_FIFO/debug_FIFO[30]_1[5]} {m_request_FIFO/debug_FIFO[30]_1[6]} {m_request_FIFO/debug_FIFO[30]_1[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 8 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {m_request_FIFO/debug_FIFO[26]_5[0]} {m_request_FIFO/debug_FIFO[26]_5[1]} {m_request_FIFO/debug_FIFO[26]_5[2]} {m_request_FIFO/debug_FIFO[26]_5[3]} {m_request_FIFO/debug_FIFO[26]_5[4]} {m_request_FIFO/debug_FIFO[26]_5[5]} {m_request_FIFO/debug_FIFO[26]_5[6]} {m_request_FIFO/debug_FIFO[26]_5[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 8 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {m_response_FIFO/debug_FIFO[11]_20[0]} {m_response_FIFO/debug_FIFO[11]_20[1]} {m_response_FIFO/debug_FIFO[11]_20[2]} {m_response_FIFO/debug_FIFO[11]_20[3]} {m_response_FIFO/debug_FIFO[11]_20[4]} {m_response_FIFO/debug_FIFO[11]_20[5]} {m_response_FIFO/debug_FIFO[11]_20[6]} {m_response_FIFO/debug_FIFO[11]_20[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 8 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {m_request_FIFO/debug_FIFO[15]_16[0]} {m_request_FIFO/debug_FIFO[15]_16[1]} {m_request_FIFO/debug_FIFO[15]_16[2]} {m_request_FIFO/debug_FIFO[15]_16[3]} {m_request_FIFO/debug_FIFO[15]_16[4]} {m_request_FIFO/debug_FIFO[15]_16[5]} {m_request_FIFO/debug_FIFO[15]_16[6]} {m_request_FIFO/debug_FIFO[15]_16[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 8 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {m_request_FIFO/debug_FIFO[11]_20[0]} {m_request_FIFO/debug_FIFO[11]_20[1]} {m_request_FIFO/debug_FIFO[11]_20[2]} {m_request_FIFO/debug_FIFO[11]_20[3]} {m_request_FIFO/debug_FIFO[11]_20[4]} {m_request_FIFO/debug_FIFO[11]_20[5]} {m_request_FIFO/debug_FIFO[11]_20[6]} {m_request_FIFO/debug_FIFO[11]_20[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 8 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {m_request_FIFO/debug_FIFO[4]_27[0]} {m_request_FIFO/debug_FIFO[4]_27[1]} {m_request_FIFO/debug_FIFO[4]_27[2]} {m_request_FIFO/debug_FIFO[4]_27[3]} {m_request_FIFO/debug_FIFO[4]_27[4]} {m_request_FIFO/debug_FIFO[4]_27[5]} {m_request_FIFO/debug_FIFO[4]_27[6]} {m_request_FIFO/debug_FIFO[4]_27[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 8 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {m_request_FIFO/debug_FIFO[12]_19[0]} {m_request_FIFO/debug_FIFO[12]_19[1]} {m_request_FIFO/debug_FIFO[12]_19[2]} {m_request_FIFO/debug_FIFO[12]_19[3]} {m_request_FIFO/debug_FIFO[12]_19[4]} {m_request_FIFO/debug_FIFO[12]_19[5]} {m_request_FIFO/debug_FIFO[12]_19[6]} {m_request_FIFO/debug_FIFO[12]_19[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 8 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {m_request_FIFO/debug_FIFO[16]_15[0]} {m_request_FIFO/debug_FIFO[16]_15[1]} {m_request_FIFO/debug_FIFO[16]_15[2]} {m_request_FIFO/debug_FIFO[16]_15[3]} {m_request_FIFO/debug_FIFO[16]_15[4]} {m_request_FIFO/debug_FIFO[16]_15[5]} {m_request_FIFO/debug_FIFO[16]_15[6]} {m_request_FIFO/debug_FIFO[16]_15[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 8 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list {m_request_FIFO/debug_FIFO[25]_6[0]} {m_request_FIFO/debug_FIFO[25]_6[1]} {m_request_FIFO/debug_FIFO[25]_6[2]} {m_request_FIFO/debug_FIFO[25]_6[3]} {m_request_FIFO/debug_FIFO[25]_6[4]} {m_request_FIFO/debug_FIFO[25]_6[5]} {m_request_FIFO/debug_FIFO[25]_6[6]} {m_request_FIFO/debug_FIFO[25]_6[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 8 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list {m_request_FIFO/debug_FIFO[28]_3[0]} {m_request_FIFO/debug_FIFO[28]_3[1]} {m_request_FIFO/debug_FIFO[28]_3[2]} {m_request_FIFO/debug_FIFO[28]_3[3]} {m_request_FIFO/debug_FIFO[28]_3[4]} {m_request_FIFO/debug_FIFO[28]_3[5]} {m_request_FIFO/debug_FIFO[28]_3[6]} {m_request_FIFO/debug_FIFO[28]_3[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 8 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list {m_request_FIFO/debug_FIFO[8]_23[0]} {m_request_FIFO/debug_FIFO[8]_23[1]} {m_request_FIFO/debug_FIFO[8]_23[2]} {m_request_FIFO/debug_FIFO[8]_23[3]} {m_request_FIFO/debug_FIFO[8]_23[4]} {m_request_FIFO/debug_FIFO[8]_23[5]} {m_request_FIFO/debug_FIFO[8]_23[6]} {m_request_FIFO/debug_FIFO[8]_23[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 8 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list {m_request_FIFO/debug_FIFO[7]_24[0]} {m_request_FIFO/debug_FIFO[7]_24[1]} {m_request_FIFO/debug_FIFO[7]_24[2]} {m_request_FIFO/debug_FIFO[7]_24[3]} {m_request_FIFO/debug_FIFO[7]_24[4]} {m_request_FIFO/debug_FIFO[7]_24[5]} {m_request_FIFO/debug_FIFO[7]_24[6]} {m_request_FIFO/debug_FIFO[7]_24[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 8 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list {m_request_FIFO/debug_FIFO[10]_21[0]} {m_request_FIFO/debug_FIFO[10]_21[1]} {m_request_FIFO/debug_FIFO[10]_21[2]} {m_request_FIFO/debug_FIFO[10]_21[3]} {m_request_FIFO/debug_FIFO[10]_21[4]} {m_request_FIFO/debug_FIFO[10]_21[5]} {m_request_FIFO/debug_FIFO[10]_21[6]} {m_request_FIFO/debug_FIFO[10]_21[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 8 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list {m_request_FIFO/debug_FIFO[19]_12[0]} {m_request_FIFO/debug_FIFO[19]_12[1]} {m_request_FIFO/debug_FIFO[19]_12[2]} {m_request_FIFO/debug_FIFO[19]_12[3]} {m_request_FIFO/debug_FIFO[19]_12[4]} {m_request_FIFO/debug_FIFO[19]_12[5]} {m_request_FIFO/debug_FIFO[19]_12[6]} {m_request_FIFO/debug_FIFO[19]_12[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 8 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list {m_request_FIFO/debug_FIFO[20]_11[0]} {m_request_FIFO/debug_FIFO[20]_11[1]} {m_request_FIFO/debug_FIFO[20]_11[2]} {m_request_FIFO/debug_FIFO[20]_11[3]} {m_request_FIFO/debug_FIFO[20]_11[4]} {m_request_FIFO/debug_FIFO[20]_11[5]} {m_request_FIFO/debug_FIFO[20]_11[6]} {m_request_FIFO/debug_FIFO[20]_11[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 8 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list {m_request_FIFO/debug_FIFO[21]_10[0]} {m_request_FIFO/debug_FIFO[21]_10[1]} {m_request_FIFO/debug_FIFO[21]_10[2]} {m_request_FIFO/debug_FIFO[21]_10[3]} {m_request_FIFO/debug_FIFO[21]_10[4]} {m_request_FIFO/debug_FIFO[21]_10[5]} {m_request_FIFO/debug_FIFO[21]_10[6]} {m_request_FIFO/debug_FIFO[21]_10[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 8 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list {m_request_FIFO/debug_FIFO[22]_9[0]} {m_request_FIFO/debug_FIFO[22]_9[1]} {m_request_FIFO/debug_FIFO[22]_9[2]} {m_request_FIFO/debug_FIFO[22]_9[3]} {m_request_FIFO/debug_FIFO[22]_9[4]} {m_request_FIFO/debug_FIFO[22]_9[5]} {m_request_FIFO/debug_FIFO[22]_9[6]} {m_request_FIFO/debug_FIFO[22]_9[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 8 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list {m_request_FIFO/debug_FIFO[29]_2[0]} {m_request_FIFO/debug_FIFO[29]_2[1]} {m_request_FIFO/debug_FIFO[29]_2[2]} {m_request_FIFO/debug_FIFO[29]_2[3]} {m_request_FIFO/debug_FIFO[29]_2[4]} {m_request_FIFO/debug_FIFO[29]_2[5]} {m_request_FIFO/debug_FIFO[29]_2[6]} {m_request_FIFO/debug_FIFO[29]_2[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe25]
set_property port_width 8 [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list {m_request_FIFO/debug_FIFO[1]_30[0]} {m_request_FIFO/debug_FIFO[1]_30[1]} {m_request_FIFO/debug_FIFO[1]_30[2]} {m_request_FIFO/debug_FIFO[1]_30[3]} {m_request_FIFO/debug_FIFO[1]_30[4]} {m_request_FIFO/debug_FIFO[1]_30[5]} {m_request_FIFO/debug_FIFO[1]_30[6]} {m_request_FIFO/debug_FIFO[1]_30[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe26]
set_property port_width 8 [get_debug_ports u_ila_0/probe26]
connect_debug_port u_ila_0/probe26 [get_nets [list {m_request_FIFO/debug_FIFO[2]_29[0]} {m_request_FIFO/debug_FIFO[2]_29[1]} {m_request_FIFO/debug_FIFO[2]_29[2]} {m_request_FIFO/debug_FIFO[2]_29[3]} {m_request_FIFO/debug_FIFO[2]_29[4]} {m_request_FIFO/debug_FIFO[2]_29[5]} {m_request_FIFO/debug_FIFO[2]_29[6]} {m_request_FIFO/debug_FIFO[2]_29[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe27]
set_property port_width 8 [get_debug_ports u_ila_0/probe27]
connect_debug_port u_ila_0/probe27 [get_nets [list {m_request_FIFO/debug_FIFO[17]_14[0]} {m_request_FIFO/debug_FIFO[17]_14[1]} {m_request_FIFO/debug_FIFO[17]_14[2]} {m_request_FIFO/debug_FIFO[17]_14[3]} {m_request_FIFO/debug_FIFO[17]_14[4]} {m_request_FIFO/debug_FIFO[17]_14[5]} {m_request_FIFO/debug_FIFO[17]_14[6]} {m_request_FIFO/debug_FIFO[17]_14[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe28]
set_property port_width 8 [get_debug_ports u_ila_0/probe28]
connect_debug_port u_ila_0/probe28 [get_nets [list {m_request_FIFO/debug_FIFO[18]_13[0]} {m_request_FIFO/debug_FIFO[18]_13[1]} {m_request_FIFO/debug_FIFO[18]_13[2]} {m_request_FIFO/debug_FIFO[18]_13[3]} {m_request_FIFO/debug_FIFO[18]_13[4]} {m_request_FIFO/debug_FIFO[18]_13[5]} {m_request_FIFO/debug_FIFO[18]_13[6]} {m_request_FIFO/debug_FIFO[18]_13[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe29]
set_property port_width 8 [get_debug_ports u_ila_0/probe29]
connect_debug_port u_ila_0/probe29 [get_nets [list {m_request_FIFO/debug_FIFO[3]_28[0]} {m_request_FIFO/debug_FIFO[3]_28[1]} {m_request_FIFO/debug_FIFO[3]_28[2]} {m_request_FIFO/debug_FIFO[3]_28[3]} {m_request_FIFO/debug_FIFO[3]_28[4]} {m_request_FIFO/debug_FIFO[3]_28[5]} {m_request_FIFO/debug_FIFO[3]_28[6]} {m_request_FIFO/debug_FIFO[3]_28[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe30]
set_property port_width 8 [get_debug_ports u_ila_0/probe30]
connect_debug_port u_ila_0/probe30 [get_nets [list {m_request_FIFO/debug_FIFO[14]_17[0]} {m_request_FIFO/debug_FIFO[14]_17[1]} {m_request_FIFO/debug_FIFO[14]_17[2]} {m_request_FIFO/debug_FIFO[14]_17[3]} {m_request_FIFO/debug_FIFO[14]_17[4]} {m_request_FIFO/debug_FIFO[14]_17[5]} {m_request_FIFO/debug_FIFO[14]_17[6]} {m_request_FIFO/debug_FIFO[14]_17[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe31]
set_property port_width 8 [get_debug_ports u_ila_0/probe31]
connect_debug_port u_ila_0/probe31 [get_nets [list {m_request_FIFO/debug_FIFO[13]_18[0]} {m_request_FIFO/debug_FIFO[13]_18[1]} {m_request_FIFO/debug_FIFO[13]_18[2]} {m_request_FIFO/debug_FIFO[13]_18[3]} {m_request_FIFO/debug_FIFO[13]_18[4]} {m_request_FIFO/debug_FIFO[13]_18[5]} {m_request_FIFO/debug_FIFO[13]_18[6]} {m_request_FIFO/debug_FIFO[13]_18[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe32]
set_property port_width 8 [get_debug_ports u_ila_0/probe32]
connect_debug_port u_ila_0/probe32 [get_nets [list {m_request_FIFO/debug_FIFO[6]_25[0]} {m_request_FIFO/debug_FIFO[6]_25[1]} {m_request_FIFO/debug_FIFO[6]_25[2]} {m_request_FIFO/debug_FIFO[6]_25[3]} {m_request_FIFO/debug_FIFO[6]_25[4]} {m_request_FIFO/debug_FIFO[6]_25[5]} {m_request_FIFO/debug_FIFO[6]_25[6]} {m_request_FIFO/debug_FIFO[6]_25[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe33]
set_property port_width 8 [get_debug_ports u_ila_0/probe33]
connect_debug_port u_ila_0/probe33 [get_nets [list {m_response_FIFO/debug_FIFO[12]_19[0]} {m_response_FIFO/debug_FIFO[12]_19[1]} {m_response_FIFO/debug_FIFO[12]_19[2]} {m_response_FIFO/debug_FIFO[12]_19[3]} {m_response_FIFO/debug_FIFO[12]_19[4]} {m_response_FIFO/debug_FIFO[12]_19[5]} {m_response_FIFO/debug_FIFO[12]_19[6]} {m_response_FIFO/debug_FIFO[12]_19[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe34]
set_property port_width 8 [get_debug_ports u_ila_0/probe34]
connect_debug_port u_ila_0/probe34 [get_nets [list {m_response_FIFO/debug_FIFO[21]_10[0]} {m_response_FIFO/debug_FIFO[21]_10[1]} {m_response_FIFO/debug_FIFO[21]_10[2]} {m_response_FIFO/debug_FIFO[21]_10[3]} {m_response_FIFO/debug_FIFO[21]_10[4]} {m_response_FIFO/debug_FIFO[21]_10[5]} {m_response_FIFO/debug_FIFO[21]_10[6]} {m_response_FIFO/debug_FIFO[21]_10[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe35]
set_property port_width 8 [get_debug_ports u_ila_0/probe35]
connect_debug_port u_ila_0/probe35 [get_nets [list {m_response_FIFO/debug_FIFO[16]_15[0]} {m_response_FIFO/debug_FIFO[16]_15[1]} {m_response_FIFO/debug_FIFO[16]_15[2]} {m_response_FIFO/debug_FIFO[16]_15[3]} {m_response_FIFO/debug_FIFO[16]_15[4]} {m_response_FIFO/debug_FIFO[16]_15[5]} {m_response_FIFO/debug_FIFO[16]_15[6]} {m_response_FIFO/debug_FIFO[16]_15[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe36]
set_property port_width 8 [get_debug_ports u_ila_0/probe36]
connect_debug_port u_ila_0/probe36 [get_nets [list {m_response_FIFO/debug_FIFO[29]_2[0]} {m_response_FIFO/debug_FIFO[29]_2[1]} {m_response_FIFO/debug_FIFO[29]_2[2]} {m_response_FIFO/debug_FIFO[29]_2[3]} {m_response_FIFO/debug_FIFO[29]_2[4]} {m_response_FIFO/debug_FIFO[29]_2[5]} {m_response_FIFO/debug_FIFO[29]_2[6]} {m_response_FIFO/debug_FIFO[29]_2[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe37]
set_property port_width 8 [get_debug_ports u_ila_0/probe37]
connect_debug_port u_ila_0/probe37 [get_nets [list {m_response_FIFO/debug_FIFO[6]_25[0]} {m_response_FIFO/debug_FIFO[6]_25[1]} {m_response_FIFO/debug_FIFO[6]_25[2]} {m_response_FIFO/debug_FIFO[6]_25[3]} {m_response_FIFO/debug_FIFO[6]_25[4]} {m_response_FIFO/debug_FIFO[6]_25[5]} {m_response_FIFO/debug_FIFO[6]_25[6]} {m_response_FIFO/debug_FIFO[6]_25[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe38]
set_property port_width 8 [get_debug_ports u_ila_0/probe38]
connect_debug_port u_ila_0/probe38 [get_nets [list {m_response_FIFO/debug_FIFO[10]_21[0]} {m_response_FIFO/debug_FIFO[10]_21[1]} {m_response_FIFO/debug_FIFO[10]_21[2]} {m_response_FIFO/debug_FIFO[10]_21[3]} {m_response_FIFO/debug_FIFO[10]_21[4]} {m_response_FIFO/debug_FIFO[10]_21[5]} {m_response_FIFO/debug_FIFO[10]_21[6]} {m_response_FIFO/debug_FIFO[10]_21[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe39]
set_property port_width 8 [get_debug_ports u_ila_0/probe39]
connect_debug_port u_ila_0/probe39 [get_nets [list {m_response_FIFO/debug_FIFO[4]_27[0]} {m_response_FIFO/debug_FIFO[4]_27[1]} {m_response_FIFO/debug_FIFO[4]_27[2]} {m_response_FIFO/debug_FIFO[4]_27[3]} {m_response_FIFO/debug_FIFO[4]_27[4]} {m_response_FIFO/debug_FIFO[4]_27[5]} {m_response_FIFO/debug_FIFO[4]_27[6]} {m_response_FIFO/debug_FIFO[4]_27[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe40]
set_property port_width 8 [get_debug_ports u_ila_0/probe40]
connect_debug_port u_ila_0/probe40 [get_nets [list {m_response_FIFO/debug_FIFO[24]_7[0]} {m_response_FIFO/debug_FIFO[24]_7[1]} {m_response_FIFO/debug_FIFO[24]_7[2]} {m_response_FIFO/debug_FIFO[24]_7[3]} {m_response_FIFO/debug_FIFO[24]_7[4]} {m_response_FIFO/debug_FIFO[24]_7[5]} {m_response_FIFO/debug_FIFO[24]_7[6]} {m_response_FIFO/debug_FIFO[24]_7[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe41]
set_property port_width 8 [get_debug_ports u_ila_0/probe41]
connect_debug_port u_ila_0/probe41 [get_nets [list {m_response_FIFO/debug_FIFO[31]_0[0]} {m_response_FIFO/debug_FIFO[31]_0[1]} {m_response_FIFO/debug_FIFO[31]_0[2]} {m_response_FIFO/debug_FIFO[31]_0[3]} {m_response_FIFO/debug_FIFO[31]_0[4]} {m_response_FIFO/debug_FIFO[31]_0[5]} {m_response_FIFO/debug_FIFO[31]_0[6]} {m_response_FIFO/debug_FIFO[31]_0[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe42]
set_property port_width 8 [get_debug_ports u_ila_0/probe42]
connect_debug_port u_ila_0/probe42 [get_nets [list {m_response_FIFO/debug_FIFO[18]_13[0]} {m_response_FIFO/debug_FIFO[18]_13[1]} {m_response_FIFO/debug_FIFO[18]_13[2]} {m_response_FIFO/debug_FIFO[18]_13[3]} {m_response_FIFO/debug_FIFO[18]_13[4]} {m_response_FIFO/debug_FIFO[18]_13[5]} {m_response_FIFO/debug_FIFO[18]_13[6]} {m_response_FIFO/debug_FIFO[18]_13[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe43]
set_property port_width 8 [get_debug_ports u_ila_0/probe43]
connect_debug_port u_ila_0/probe43 [get_nets [list {m_response_FIFO/debug_FIFO[28]_3[0]} {m_response_FIFO/debug_FIFO[28]_3[1]} {m_response_FIFO/debug_FIFO[28]_3[2]} {m_response_FIFO/debug_FIFO[28]_3[3]} {m_response_FIFO/debug_FIFO[28]_3[4]} {m_response_FIFO/debug_FIFO[28]_3[5]} {m_response_FIFO/debug_FIFO[28]_3[6]} {m_response_FIFO/debug_FIFO[28]_3[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe44]
set_property port_width 8 [get_debug_ports u_ila_0/probe44]
connect_debug_port u_ila_0/probe44 [get_nets [list {m_response_FIFO/debug_FIFO[15]_16[0]} {m_response_FIFO/debug_FIFO[15]_16[1]} {m_response_FIFO/debug_FIFO[15]_16[2]} {m_response_FIFO/debug_FIFO[15]_16[3]} {m_response_FIFO/debug_FIFO[15]_16[4]} {m_response_FIFO/debug_FIFO[15]_16[5]} {m_response_FIFO/debug_FIFO[15]_16[6]} {m_response_FIFO/debug_FIFO[15]_16[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe45]
set_property port_width 8 [get_debug_ports u_ila_0/probe45]
connect_debug_port u_ila_0/probe45 [get_nets [list {m_response_FIFO/debug_FIFO[8]_23[0]} {m_response_FIFO/debug_FIFO[8]_23[1]} {m_response_FIFO/debug_FIFO[8]_23[2]} {m_response_FIFO/debug_FIFO[8]_23[3]} {m_response_FIFO/debug_FIFO[8]_23[4]} {m_response_FIFO/debug_FIFO[8]_23[5]} {m_response_FIFO/debug_FIFO[8]_23[6]} {m_response_FIFO/debug_FIFO[8]_23[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe46]
set_property port_width 8 [get_debug_ports u_ila_0/probe46]
connect_debug_port u_ila_0/probe46 [get_nets [list {m_response_FIFO/debug_FIFO[19]_12[0]} {m_response_FIFO/debug_FIFO[19]_12[1]} {m_response_FIFO/debug_FIFO[19]_12[2]} {m_response_FIFO/debug_FIFO[19]_12[3]} {m_response_FIFO/debug_FIFO[19]_12[4]} {m_response_FIFO/debug_FIFO[19]_12[5]} {m_response_FIFO/debug_FIFO[19]_12[6]} {m_response_FIFO/debug_FIFO[19]_12[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe47]
set_property port_width 8 [get_debug_ports u_ila_0/probe47]
connect_debug_port u_ila_0/probe47 [get_nets [list {m_response_FIFO/debug_FIFO[7]_24[0]} {m_response_FIFO/debug_FIFO[7]_24[1]} {m_response_FIFO/debug_FIFO[7]_24[2]} {m_response_FIFO/debug_FIFO[7]_24[3]} {m_response_FIFO/debug_FIFO[7]_24[4]} {m_response_FIFO/debug_FIFO[7]_24[5]} {m_response_FIFO/debug_FIFO[7]_24[6]} {m_response_FIFO/debug_FIFO[7]_24[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe48]
set_property port_width 8 [get_debug_ports u_ila_0/probe48]
connect_debug_port u_ila_0/probe48 [get_nets [list {m_response_FIFO/debug_FIFO[30]_1[0]} {m_response_FIFO/debug_FIFO[30]_1[1]} {m_response_FIFO/debug_FIFO[30]_1[2]} {m_response_FIFO/debug_FIFO[30]_1[3]} {m_response_FIFO/debug_FIFO[30]_1[4]} {m_response_FIFO/debug_FIFO[30]_1[5]} {m_response_FIFO/debug_FIFO[30]_1[6]} {m_response_FIFO/debug_FIFO[30]_1[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe49]
set_property port_width 8 [get_debug_ports u_ila_0/probe49]
connect_debug_port u_ila_0/probe49 [get_nets [list {m_response_FIFO/debug_FIFO[17]_14[0]} {m_response_FIFO/debug_FIFO[17]_14[1]} {m_response_FIFO/debug_FIFO[17]_14[2]} {m_response_FIFO/debug_FIFO[17]_14[3]} {m_response_FIFO/debug_FIFO[17]_14[4]} {m_response_FIFO/debug_FIFO[17]_14[5]} {m_response_FIFO/debug_FIFO[17]_14[6]} {m_response_FIFO/debug_FIFO[17]_14[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe50]
set_property port_width 8 [get_debug_ports u_ila_0/probe50]
connect_debug_port u_ila_0/probe50 [get_nets [list {m_response_FIFO/debug_FIFO[14]_17[0]} {m_response_FIFO/debug_FIFO[14]_17[1]} {m_response_FIFO/debug_FIFO[14]_17[2]} {m_response_FIFO/debug_FIFO[14]_17[3]} {m_response_FIFO/debug_FIFO[14]_17[4]} {m_response_FIFO/debug_FIFO[14]_17[5]} {m_response_FIFO/debug_FIFO[14]_17[6]} {m_response_FIFO/debug_FIFO[14]_17[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe51]
set_property port_width 8 [get_debug_ports u_ila_0/probe51]
connect_debug_port u_ila_0/probe51 [get_nets [list {m_response_FIFO/debug_FIFO[27]_4[0]} {m_response_FIFO/debug_FIFO[27]_4[1]} {m_response_FIFO/debug_FIFO[27]_4[2]} {m_response_FIFO/debug_FIFO[27]_4[3]} {m_response_FIFO/debug_FIFO[27]_4[4]} {m_response_FIFO/debug_FIFO[27]_4[5]} {m_response_FIFO/debug_FIFO[27]_4[6]} {m_response_FIFO/debug_FIFO[27]_4[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe52]
set_property port_width 8 [get_debug_ports u_ila_0/probe52]
connect_debug_port u_ila_0/probe52 [get_nets [list {m_response_FIFO/debug_FIFO[23]_8[0]} {m_response_FIFO/debug_FIFO[23]_8[1]} {m_response_FIFO/debug_FIFO[23]_8[2]} {m_response_FIFO/debug_FIFO[23]_8[3]} {m_response_FIFO/debug_FIFO[23]_8[4]} {m_response_FIFO/debug_FIFO[23]_8[5]} {m_response_FIFO/debug_FIFO[23]_8[6]} {m_response_FIFO/debug_FIFO[23]_8[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe53]
set_property port_width 8 [get_debug_ports u_ila_0/probe53]
connect_debug_port u_ila_0/probe53 [get_nets [list {m_response_FIFO/debug_FIFO[5]_26[0]} {m_response_FIFO/debug_FIFO[5]_26[1]} {m_response_FIFO/debug_FIFO[5]_26[2]} {m_response_FIFO/debug_FIFO[5]_26[3]} {m_response_FIFO/debug_FIFO[5]_26[4]} {m_response_FIFO/debug_FIFO[5]_26[5]} {m_response_FIFO/debug_FIFO[5]_26[6]} {m_response_FIFO/debug_FIFO[5]_26[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe54]
set_property port_width 8 [get_debug_ports u_ila_0/probe54]
connect_debug_port u_ila_0/probe54 [get_nets [list {m_response_FIFO/debug_FIFO[3]_28[0]} {m_response_FIFO/debug_FIFO[3]_28[1]} {m_response_FIFO/debug_FIFO[3]_28[2]} {m_response_FIFO/debug_FIFO[3]_28[3]} {m_response_FIFO/debug_FIFO[3]_28[4]} {m_response_FIFO/debug_FIFO[3]_28[5]} {m_response_FIFO/debug_FIFO[3]_28[6]} {m_response_FIFO/debug_FIFO[3]_28[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe55]
set_property port_width 8 [get_debug_ports u_ila_0/probe55]
connect_debug_port u_ila_0/probe55 [get_nets [list {m_response_FIFO/debug_FIFO[2]_29[0]} {m_response_FIFO/debug_FIFO[2]_29[1]} {m_response_FIFO/debug_FIFO[2]_29[2]} {m_response_FIFO/debug_FIFO[2]_29[3]} {m_response_FIFO/debug_FIFO[2]_29[4]} {m_response_FIFO/debug_FIFO[2]_29[5]} {m_response_FIFO/debug_FIFO[2]_29[6]} {m_response_FIFO/debug_FIFO[2]_29[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe56]
set_property port_width 8 [get_debug_ports u_ila_0/probe56]
connect_debug_port u_ila_0/probe56 [get_nets [list {m_response_FIFO/debug_FIFO[1]_30[0]} {m_response_FIFO/debug_FIFO[1]_30[1]} {m_response_FIFO/debug_FIFO[1]_30[2]} {m_response_FIFO/debug_FIFO[1]_30[3]} {m_response_FIFO/debug_FIFO[1]_30[4]} {m_response_FIFO/debug_FIFO[1]_30[5]} {m_response_FIFO/debug_FIFO[1]_30[6]} {m_response_FIFO/debug_FIFO[1]_30[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe57]
set_property port_width 8 [get_debug_ports u_ila_0/probe57]
connect_debug_port u_ila_0/probe57 [get_nets [list {m_response_FIFO/debug_FIFO[25]_6[0]} {m_response_FIFO/debug_FIFO[25]_6[1]} {m_response_FIFO/debug_FIFO[25]_6[2]} {m_response_FIFO/debug_FIFO[25]_6[3]} {m_response_FIFO/debug_FIFO[25]_6[4]} {m_response_FIFO/debug_FIFO[25]_6[5]} {m_response_FIFO/debug_FIFO[25]_6[6]} {m_response_FIFO/debug_FIFO[25]_6[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe58]
set_property port_width 8 [get_debug_ports u_ila_0/probe58]
connect_debug_port u_ila_0/probe58 [get_nets [list {m_response_FIFO/debug_FIFO[26]_5[0]} {m_response_FIFO/debug_FIFO[26]_5[1]} {m_response_FIFO/debug_FIFO[26]_5[2]} {m_response_FIFO/debug_FIFO[26]_5[3]} {m_response_FIFO/debug_FIFO[26]_5[4]} {m_response_FIFO/debug_FIFO[26]_5[5]} {m_response_FIFO/debug_FIFO[26]_5[6]} {m_response_FIFO/debug_FIFO[26]_5[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe59]
set_property port_width 8 [get_debug_ports u_ila_0/probe59]
connect_debug_port u_ila_0/probe59 [get_nets [list {m_response_FIFO/debug_FIFO[20]_11[0]} {m_response_FIFO/debug_FIFO[20]_11[1]} {m_response_FIFO/debug_FIFO[20]_11[2]} {m_response_FIFO/debug_FIFO[20]_11[3]} {m_response_FIFO/debug_FIFO[20]_11[4]} {m_response_FIFO/debug_FIFO[20]_11[5]} {m_response_FIFO/debug_FIFO[20]_11[6]} {m_response_FIFO/debug_FIFO[20]_11[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe60]
set_property port_width 8 [get_debug_ports u_ila_0/probe60]
connect_debug_port u_ila_0/probe60 [get_nets [list {m_response_FIFO/debug_FIFO[0]_31[0]} {m_response_FIFO/debug_FIFO[0]_31[1]} {m_response_FIFO/debug_FIFO[0]_31[2]} {m_response_FIFO/debug_FIFO[0]_31[3]} {m_response_FIFO/debug_FIFO[0]_31[4]} {m_response_FIFO/debug_FIFO[0]_31[5]} {m_response_FIFO/debug_FIFO[0]_31[6]} {m_response_FIFO/debug_FIFO[0]_31[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe61]
set_property port_width 8 [get_debug_ports u_ila_0/probe61]
connect_debug_port u_ila_0/probe61 [get_nets [list {m_response_FIFO/debug_FIFO[22]_9[0]} {m_response_FIFO/debug_FIFO[22]_9[1]} {m_response_FIFO/debug_FIFO[22]_9[2]} {m_response_FIFO/debug_FIFO[22]_9[3]} {m_response_FIFO/debug_FIFO[22]_9[4]} {m_response_FIFO/debug_FIFO[22]_9[5]} {m_response_FIFO/debug_FIFO[22]_9[6]} {m_response_FIFO/debug_FIFO[22]_9[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe62]
set_property port_width 8 [get_debug_ports u_ila_0/probe62]
connect_debug_port u_ila_0/probe62 [get_nets [list {m_response_FIFO/debug_FIFO[9]_22[0]} {m_response_FIFO/debug_FIFO[9]_22[1]} {m_response_FIFO/debug_FIFO[9]_22[2]} {m_response_FIFO/debug_FIFO[9]_22[3]} {m_response_FIFO/debug_FIFO[9]_22[4]} {m_response_FIFO/debug_FIFO[9]_22[5]} {m_response_FIFO/debug_FIFO[9]_22[6]} {m_response_FIFO/debug_FIFO[9]_22[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe63]
set_property port_width 8 [get_debug_ports u_ila_0/probe63]
connect_debug_port u_ila_0/probe63 [get_nets [list {m_response_FIFO/debug_FIFO[13]_18[0]} {m_response_FIFO/debug_FIFO[13]_18[1]} {m_response_FIFO/debug_FIFO[13]_18[2]} {m_response_FIFO/debug_FIFO[13]_18[3]} {m_response_FIFO/debug_FIFO[13]_18[4]} {m_response_FIFO/debug_FIFO[13]_18[5]} {m_response_FIFO/debug_FIFO[13]_18[6]} {m_response_FIFO/debug_FIFO[13]_18[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe64]
set_property port_width 3 [get_debug_ports u_ila_0/probe64]
connect_debug_port u_ila_0/probe64 [get_nets [list {debug_cmdestate[0]} {debug_cmdestate[1]} {debug_cmdestate[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe65]
set_property port_width 5 [get_debug_ports u_ila_0/probe65]
connect_debug_port u_ila_0/probe65 [get_nets [list {debug_request_FIFO_cmdnum[0]} {debug_request_FIFO_cmdnum[1]} {debug_request_FIFO_cmdnum[2]} {debug_request_FIFO_cmdnum[3]} {debug_request_FIFO_cmdnum[4]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe66]
set_property port_width 8 [get_debug_ports u_ila_0/probe66]
connect_debug_port u_ila_0/probe66 [get_nets [list {debug_tx_data[0]} {debug_tx_data[1]} {debug_tx_data[2]} {debug_tx_data[3]} {debug_tx_data[4]} {debug_tx_data[5]} {debug_tx_data[6]} {debug_tx_data[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe67]
set_property port_width 2 [get_debug_ports u_ila_0/probe67]
connect_debug_port u_ila_0/probe67 [get_nets [list {debug_cmdtstate[0]} {debug_cmdtstate[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe68]
set_property port_width 5 [get_debug_ports u_ila_0/probe68]
connect_debug_port u_ila_0/probe68 [get_nets [list {debug_response_FIFO_cmdnum[0]} {debug_response_FIFO_cmdnum[1]} {debug_response_FIFO_cmdnum[2]} {debug_response_FIFO_cmdnum[3]} {debug_response_FIFO_cmdnum[4]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe69]
set_property port_width 1 [get_debug_ports u_ila_0/probe69]
connect_debug_port u_ila_0/probe69 [get_nets [list debug_request_FIFO_r_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe70]
set_property port_width 1 [get_debug_ports u_ila_0/probe70]
connect_debug_port u_ila_0/probe70 [get_nets [list debug_response_FIFO_r_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe71]
set_property port_width 1 [get_debug_ports u_ila_0/probe71]
connect_debug_port u_ila_0/probe71 [get_nets [list debug_tx_vld]]
#create_debug_core u_ila_1 ila
#set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
#set_property ALL_PROBE_SAME_MU_CNT 2 [get_debug_cores u_ila_1]
#set_property C_ADV_TRIGGER false [get_debug_cores u_ila_1]
#set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_1]
#set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_1]
#set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_1]
#set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
#set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
#set_property port_width 1 [get_debug_ports u_ila_1/clk]
#connect_debug_port u_ila_1/clk [get_nets [list u_ila_1_CLK_50M]]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
#set_property port_width 128 [get_debug_ports u_ila_1/probe0]
#connect_debug_port u_ila_1/probe0 [get_nets [list {m_PUF/debug_puf_response[0]} {m_PUF/debug_puf_response[1]} {m_PUF/debug_puf_response[2]} {m_PUF/debug_puf_response[3]} {m_PUF/debug_puf_response[4]} {m_PUF/debug_puf_response[5]} {m_PUF/debug_puf_response[6]} {m_PUF/debug_puf_response[7]} {m_PUF/debug_puf_response[8]} {m_PUF/debug_puf_response[9]} {m_PUF/debug_puf_response[10]} {m_PUF/debug_puf_response[11]} {m_PUF/debug_puf_response[12]} {m_PUF/debug_puf_response[13]} {m_PUF/debug_puf_response[14]} {m_PUF/debug_puf_response[15]} {m_PUF/debug_puf_response[16]} {m_PUF/debug_puf_response[17]} {m_PUF/debug_puf_response[18]} {m_PUF/debug_puf_response[19]} {m_PUF/debug_puf_response[20]} {m_PUF/debug_puf_response[21]} {m_PUF/debug_puf_response[22]} {m_PUF/debug_puf_response[23]} {m_PUF/debug_puf_response[24]} {m_PUF/debug_puf_response[25]} {m_PUF/debug_puf_response[26]} {m_PUF/debug_puf_response[27]} {m_PUF/debug_puf_response[28]} {m_PUF/debug_puf_response[29]} {m_PUF/debug_puf_response[30]} {m_PUF/debug_puf_response[31]} {m_PUF/debug_puf_response[32]} {m_PUF/debug_puf_response[33]} {m_PUF/debug_puf_response[34]} {m_PUF/debug_puf_response[35]} {m_PUF/debug_puf_response[36]} {m_PUF/debug_puf_response[37]} {m_PUF/debug_puf_response[38]} {m_PUF/debug_puf_response[39]} {m_PUF/debug_puf_response[40]} {m_PUF/debug_puf_response[41]} {m_PUF/debug_puf_response[42]} {m_PUF/debug_puf_response[43]} {m_PUF/debug_puf_response[44]} {m_PUF/debug_puf_response[45]} {m_PUF/debug_puf_response[46]} {m_PUF/debug_puf_response[47]} {m_PUF/debug_puf_response[48]} {m_PUF/debug_puf_response[49]} {m_PUF/debug_puf_response[50]} {m_PUF/debug_puf_response[51]} {m_PUF/debug_puf_response[52]} {m_PUF/debug_puf_response[53]} {m_PUF/debug_puf_response[54]} {m_PUF/debug_puf_response[55]} {m_PUF/debug_puf_response[56]} {m_PUF/debug_puf_response[57]} {m_PUF/debug_puf_response[58]} {m_PUF/debug_puf_response[59]} {m_PUF/debug_puf_response[60]} {m_PUF/debug_puf_response[61]} {m_PUF/debug_puf_response[62]} {m_PUF/debug_puf_response[63]} {m_PUF/debug_puf_response[64]} {m_PUF/debug_puf_response[65]} {m_PUF/debug_puf_response[66]} {m_PUF/debug_puf_response[67]} {m_PUF/debug_puf_response[68]} {m_PUF/debug_puf_response[69]} {m_PUF/debug_puf_response[70]} {m_PUF/debug_puf_response[71]} {m_PUF/debug_puf_response[72]} {m_PUF/debug_puf_response[73]} {m_PUF/debug_puf_response[74]} {m_PUF/debug_puf_response[75]} {m_PUF/debug_puf_response[76]} {m_PUF/debug_puf_response[77]} {m_PUF/debug_puf_response[78]} {m_PUF/debug_puf_response[79]} {m_PUF/debug_puf_response[80]} {m_PUF/debug_puf_response[81]} {m_PUF/debug_puf_response[82]} {m_PUF/debug_puf_response[83]} {m_PUF/debug_puf_response[84]} {m_PUF/debug_puf_response[85]} {m_PUF/debug_puf_response[86]} {m_PUF/debug_puf_response[87]} {m_PUF/debug_puf_response[88]} {m_PUF/debug_puf_response[89]} {m_PUF/debug_puf_response[90]} {m_PUF/debug_puf_response[91]} {m_PUF/debug_puf_response[92]} {m_PUF/debug_puf_response[93]} {m_PUF/debug_puf_response[94]} {m_PUF/debug_puf_response[95]} {m_PUF/debug_puf_response[96]} {m_PUF/debug_puf_response[97]} {m_PUF/debug_puf_response[98]} {m_PUF/debug_puf_response[99]} {m_PUF/debug_puf_response[100]} {m_PUF/debug_puf_response[101]} {m_PUF/debug_puf_response[102]} {m_PUF/debug_puf_response[103]} {m_PUF/debug_puf_response[104]} {m_PUF/debug_puf_response[105]} {m_PUF/debug_puf_response[106]} {m_PUF/debug_puf_response[107]} {m_PUF/debug_puf_response[108]} {m_PUF/debug_puf_response[109]} {m_PUF/debug_puf_response[110]} {m_PUF/debug_puf_response[111]} {m_PUF/debug_puf_response[112]} {m_PUF/debug_puf_response[113]} {m_PUF/debug_puf_response[114]} {m_PUF/debug_puf_response[115]} {m_PUF/debug_puf_response[116]} {m_PUF/debug_puf_response[117]} {m_PUF/debug_puf_response[118]} {m_PUF/debug_puf_response[119]} {m_PUF/debug_puf_response[120]} {m_PUF/debug_puf_response[121]} {m_PUF/debug_puf_response[122]} {m_PUF/debug_puf_response[123]} {m_PUF/debug_puf_response[124]} {m_PUF/debug_puf_response[125]} {m_PUF/debug_puf_response[126]} {m_PUF/debug_puf_response[127]}]]
#set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
#set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
#set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
#connect_debug_port dbg_hub/clk [get_nets u_ila_1_CLK_50M]
