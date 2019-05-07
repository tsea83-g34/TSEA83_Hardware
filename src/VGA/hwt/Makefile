XILINX_INIT = source /sw/xilinx/ise_12.4i/ISE_DS/settings64.sh;
PART=xc6slx16-3-csg324

hello.%: S=hello_hwt.vhd ../VGA_Engine.vhd ../Chars.vhd ../../Constants.vhd
hello.%: U=Nexys_conf.ucf

rainbow.%: S=rainbow_hwt.vhd ../VGA_Engine.vhd ../Chars.vhd ../../Constants.vhd
rainbow.%: U=Nexys_conf.ucf

memory.%: S=memory_hwt.vhd ../VGA_Engine.vhd ../../VideoMemory/VideoMemory.vhd ../Chars.vhd ../../Constants.vhd
memory.%: U=Nexys_conf.ucf
memory.%: T=memory_hwt.vhd

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
