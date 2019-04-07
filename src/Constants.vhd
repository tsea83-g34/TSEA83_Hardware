library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package PIPECPU_STD is
  -- Global constants
  constant NOP_REG : unsigned(31 downto 0) := X"00000000";

  -- Datamemory constants  
  type byte_mode is (WORD, HALF, BYTE);

  constant DATA_MEM_BIT_SIZE : integer := 8;



  -- ALU Controlsignals
  type alu_operation_control_signal_type is (
    NOP, ADD, SUB, NEG, INC, DEC, UMUL, MUL, -- Arithmetic values
    LSL, LSR, ASL, ASR, -- Shift operations
    AND_, OR_, XOR_, NOT_ -- Logical operations
  );

  type data_size_control_signal_type is (
    32_bit, 16_bit, 8_bit, -- Implicit data size
    NAN -- Unimportant which size
  );

  -- ALU constants

  -- OP CODE constants
  type op_code : unsigned(5 downto 0);
  -- Load / Store 
  constant LOAD       : op_code := "010100";
  constant LOAD_HALF  : op_code := "";
  constant LOAD_WORD  : op_code := "";
  constant STORE      : op_code := "";
  constant STORE_HALF : op_code :=
  constant STORE_WORD : op_code :=;
  constant LOAD_PM    : op_code :=;
  constant STORE_PM   : op_code :=;
  constant LOAD_IMM   : op_code :=;

  constant PUSH       : op_code :=;
  constant PUSH_HALF  : op_code :=;
  constant PUSH_WORD  : op_code :=;
  constant POP        : op_code :=;
  constant POP_HALF   : op_code :=;
  constant POP_WORD   : op_code :=;
  
  constant MOVE       : op_code :=;

  -- Arithmetic instructions
  constant ADD        : op_code :=;
  constant ADDI       : op_code :=;
  constant SUB        : op_code :=;
  constant SUBI       : op_code :=;
  constant NEG        : op_code :=;
  constant INC        : op_code :=;
  constant DEC        : op_code :=;
  constant MUL        : op_code :=;
  constant UMUL       : op_code :=;
  
  -- Compare instructions
  constant CMP        : op_code :=;
  constant CMPI       : op_code :=;
  constant PASS       : op_code :=;
  -- Shift instructions
  constant LSL        : op_code :=;
  constant LSR        : op_code :=;
  constant ASL        : op_code :=;
  constant ASR        : op_code :=;
  -- Logical instructions
  constant AND_       : op_code :=;
  constant OR_        : op_code :=;
  constant XOR_       : op_code :=;
  constant NOT_       : op_code :=;
  
  -- Subroutine instructions
  constant CALL       : op_code :=;
  constant RET        : op_code :=;

  -- Branching instrucctions
  constant BREQ       : op_code :=;
  constant BRNE       : op_code :=;
  constant BRLT       : op_code :=;
  constant BRGT       : op_code :=;
  constant BLRE       : op_code :=;
  constant BRGE       : op_code :=;
  constant RJMP       : op_code :=;

  -- I/O instuctions
  constant IN_        : op_code :=;
  constant OUT_       : op_code :=;

  -- NOP instructions
  constant NOP        : op_code := "000000"; -- Ox00


end PIPECPU_STD;