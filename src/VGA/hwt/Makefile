XILINX_INIT = source /sw/xilinx/ise_12.4i/ISE_DS/settings64.sh;
PART=xc6slx16-3-csg324

VGA.%: S=VGA_Engine_hwt.vhd ../VGA_Engine.vhd ../Chars.vhd ../../Constants.vhd
VGA.%: U=Nexys_conf.ucf

# Misc functions that are good to have
include ../../../build/util.mk
# Setup simulation environment
include ../../../build/vsim.mk
# Setup synthesis environment
include ../../../build/xst.mk
# Setup backend flow environment
include ../../../build/xilinx-par.mk
# Setup tools for programming the FPGA
include ../../../build/digilentprog.mk
