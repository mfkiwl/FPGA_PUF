vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../ipstatic" \
"G:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"G:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" \
"../../../../Glitch_PUF.srcs/sources_1/new/LBlockUART/PUF/PLL/PLL_clk_wiz.v" \
"../../../../Glitch_PUF.srcs/sources_1/new/LBlockUART/PUF/PLL/PLL.v" \

vlog -work xil_defaultlib \
"glbl.v"

