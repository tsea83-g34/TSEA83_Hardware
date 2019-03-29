# TSEA83 Hardware
Repository for the hardware structure for TSEA83 project.

The file 'main.vhd' is the main file that links the components together. 

## Block diagram
![Block diagram](blockdiagram.jpg "Block Diagram") 

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




 
