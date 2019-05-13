# TSEA83 Hardware
Repository for the hardware structure for TSEA83 project group 34. 

Members of this project are Angus Lothian, Bence Nagy, Justus Karlsson, and Henrik Nilsson of D2.b at Linköping University.

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
* Register File
* ALU
* Data memory component
* Video memory component

However there are also combinatorial circuit components for:
* Dataforwarding
* Write back logic

### VGA Monitor Engine
The computer also has an external VGA engine component that writes to a VGA monitor.

Most of the code for the VGA engine comes from lab 3 of TSEA83.

### PS2 UART Keyboard Decoder
The computer also has an external keyboard decodier component that writes decodes PS2 keyboard input to our own costume ASCII format and inputs it to the CPU.

Most of the code for the keyboard decoder from lab 4 of TSEA83.

## CPU Instructions
The CPU has our own costume RISC set of Instruction made for the hardware in this repo.

### Instruction set
A full description of our RISC instruction set can be found in this goodle docs document here: https://docs.google.com/document/d/1ifDim_7zJk_YUjTFmD8vfV7TSoW3sWbZ33SN53SA7Xw/edit?usp=sharing 

### Instruction encodings 
A full description of the encodings for the instructions can be found in this google sheet document here: https://docs.google.com/spreadsheets/d/1Grexb6LnehwkyX-ZJwUXI3sYoJApUfNuqsC1BU8iBKs/edit?usp=sharing





 
