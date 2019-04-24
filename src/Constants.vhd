library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package PIPECPU_STD is
  -- Global constants
  constant NOP_REG : unsigned(31 downto 0) := X"00000000";

  -- Datamemory constants
  type byte_mode is (WORD, HALF, BYTE, NAN);

  constant DATA_MEM_BIT_SIZE : integer := 8;

  -- ALU Controlsignals
  type alu_operation_control_signal_type is (
    NOP, PASS,
    ADD, SUB, NEG, INC, DEC, UMUL, MUL, -- Arithmetic values
    LSL, LSR, ASL, ASR, -- Shift operations
    AND_, OR_, XOR_, NOT_,
  );
  -- ALU constants

  -- OP CODE constants
  type op_code : unsigned(5 downto 0);
  -- Load / Store
  constant LOAD       : op_code := "100000";
  constant STORE      : op_code := "110100";
  constant LOAD_PM    : op_code := "100001";
  constant STORE_PM   : op_code := "110101";
  constant LOAD_IMM   : op_code := "100100";
  constant WRT        : op_code := "111010";

  constant PUSH       : op_code := "110110"
  constant POP        : op_code := "000010";

  constant MOVE       : op_code := "110011";

  -- Arithmetic instructions
  constant ADD        : op_code := "100100";
  constant ADDI       : op_code := "100010";
  constant SUB        : op_code := "100101";
  constant SUBI       : op_code := "100011";
  constant NEG        : op_code := "100110";
  constant INC        : op_code := "100111";
  constant DEC        : op_code := "101000";
  constant MUL        : op_code := "101001";
  constant UMUL       : op_code := "101010";

  -- Compare instructions
  constant CMP        : op_code := "110111";
  constant CMPI       : op_code := "111000";
  constant PASS       : op_code := "001101";
  -- Shift instructions
  constant LSL        : op_code := "101011";
  constant LSR        : op_code := "101100";
  constant ASL        : op_code := "101101";
  constant ASR        : op_code := "101110";
  -- Logical instructions
  constant AND_       : op_code := "101111";
  constant OR_        : op_code := "110000";
  constant XOR_       : op_code := "110001";
  constant NOT_       : op_code := "110010";

  -- Subroutine instructions
  constant CALL       : op_code := "000101";
  constant RET        : op_code := "000100";

  -- Branching instrucctions
  constant BREQ       : op_code := "000110";
  constant BRNE       : op_code := "000111";
  constant BRLT       : op_code := "001000";
  constant BRGT       : op_code := "001001";
  constant BLRE       : op_code := "001010";
  constant BRGE       : op_code := "001011";
  constant RJMP       : op_code := "001100"

  -- I/O instuctions
  constant IN_        : op_code := "000011";
  constant OUT_       : op_code := "111001";

  -- NOP instructions
  constant NOP        : op_code := "000000"; -- Ox00


end PIPECPU_STD;
