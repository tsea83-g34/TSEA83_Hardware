XILINX_INIT = source /sw/xilinx/ise_12.4i/ISE_DS/settings64.sh;
PART=xc6slx16-3-csg324

lab.%: S=DataMemory.vhd ../data.vhd ../Constants.vhd
lab.%: T=DataMemory_tb.vhd
lab.%: U=Nexys3.ucf

# Misc functions that are good to have
include ../../build/util.mk
# Setup simulation environment
include ../../build/vsim.mk
# Setup synthesis environment
include ../../build/xst.mk
# Setup backend flow environment
include ../../build/xilinx-par.mk
# Setup tools for programming the FPGA
include ../../build/digilentprog.mk
