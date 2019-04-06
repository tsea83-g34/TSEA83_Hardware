# TSEA83 Hardware
Repository for the hardware structure for TSEA83 project.

The file 'main.vhd' is the main file that links the components together. 


## Block diagram
![Block diagram](blockdiagram.jpg "Block Diagram") 


## Test Bench script 
To create a testbench for a component (let's call it **DataForwarding**) do this:

```
cd src/DataForwarding 
python ../../util/make_tb.py DataForwarding.vhd --entity data_forwarding
```

The file `DataForwarding_tb.vhd` should now be in your folder. 
To simulate it you need to copy in the build files + sanity checks + Makefile (and modify the file names in the Makefile to match your component).
Then just run `make lab.sim`.

The python script works for both Python 2 and Python 3. *It even works* for Python 2.6 (MUXEN).

## Pipeline CPU
The CPU follows a 5 step pipeline architecture. The CPU can in itself be regarded as one component which consists of some smaller components.

The file 'PipeCPU.vhd' defines the overall CPU structure and links the subcomponents together.

### Components 
Most components are implemented in their own VHDL files.

The main components of the CPU architecture are:
* Program memory component
* Control Unit
* ALU
* Data memory component
* Register File

However there are also combinatorial circuit components for:
* Dataforwarding
* Write back logic

## VGA Monitor Engine
Most of the code comes from lab 3 of TSEA83.

## PS2 UART Keyboard Decoder
Most of the code comes from lab 4 of TSEA83.




 
