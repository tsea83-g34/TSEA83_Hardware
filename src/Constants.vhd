library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package PIPECPU_STD is
  
  -- Global constants
  constant NOP_REG : unsigned(31 downto 0) := X"00000000";

  -- Datamemory constants
  type byte_mode is (WORD, HALF, BYTE, NAN);
  


  constant PROGRAM_MEMORY_SIZE: INTEGER := 4096;
  constant PROGRAM_MEMORY_ADDRESS_BITS: INTEGER := 16;
  constant PROGRAM_MEMORY_BIT_SIZE: INTEGER := 32;

  constant DATA_MEM_BIT_SIZE: INTEGER := 8;
  
  constant PALETTE_SIZE  : INTEGER := 32 / 2;                  -- 32 byte in 2 byte chunks
  
  constant VIDEO_MEM_SIZE: INTEGER := 2400 / 2 + PALETTE_SIZE; -- 2400 bytes in 2 byte chunks
  
  constant PALETTE_START : INTEGER := VIDEO_MEM_SIZE - PALETTE_SIZE;
  
  constant VIDEO_TILE_HEIGHT : INTEGER := 30;
  constant VIDEO_TILE_WIDTH  : INTEGER := 40;
 
  -- Pipe control signal
  type pipe_op is (PIPE_STALL, PIPE_JMP, PIPE_NORMAL);

  -- Keyboard control signals
  type kb_read_enum is (KB_READ, KB_NO_READ);


  -- ALU Controlsignals
  type alu_op is (ALU_ADD, ALU_SUB, ALU_NEG, ALU_INC, ALU_DEC, ALU_MUL, ALU_LSL, ALU_LSR,
                  ALU_AND, ALU_OR, ALU_XOR, ALU_NOT, 
                  ALU_MOVLO, ALU_MOVHI, 
                  ALU_PASS, ALU_NOP);


  -- DataForwarding control signals
  type df_select is (DF_FROM_RF, DF_FROM_D3, DF_FROM_D4);
 
  -- Data memory control signal
  type dm_write_or_read_enum is (DM_WRITE, DM_READ);

  -- Register file control signals
  type rf_read_d_or_b_enum is (RF_READ_D, RF_READ_B);
  
  type rf_write_d_enum is (RF_WRITE_D, RF_NO_WRITE);

  -- Write Back Logic control signals
  type wb3_in_or_alu3_enum is (WB3_IN, WB3_ALU3);
  
  type wb4_dm_or_alu4_enum is (WB4_DM, WB4_ALU4);

  -- OP code enum 
  type op_enum is (LOAD, STORE, STORE_PM, MOVHI, MOVLO, STORE_VGA,
                   MOVE, 
                   ADD, ADDI, SUBB, SUBI, NEG, INC, DEC, MUL,
                   CMP, CMPI,
                   LSL, LSR, 
                   ANDD, ORR, XORR, NOTT,
                   BREQ, BRNE, BRLT, BRGT, BRLE, BRGE, RJMP, RJMPRG,
                   INN, OUTT, 
                   NOP);

  -- OP CODE constants
  subtype op_code is unsigned(5 downto 0);
  -- Load / Store
  constant OP_LOAD       : op_code := "100000";
  constant OP_STORE      : op_code := "110100";
  -- constant LOAD_PM    : op_code := "100001"; REMOVED, unnecessary and impossible to implement
  constant OP_STORE_PM   : op_code := "110101";
  -- constant LOAD_IMM   : op_code := "100100"; REMOVED, replaced with MOVHI, MOVLO
  constant OP_MOVHI      : op_code := "111100";
  constant OP_MOVLO      : op_code := "111101";
  constant OP_STORE_VGA  : op_code := "111010";

  -- constant PUSH       : op_code := "110110"; REMOVED, solved in assembler instead
  -- constant POP        : op_code := "000010"; REMOVED, solved in assembler instead

  constant OP_MOVE       : op_code := "110011";

  -- Arithmetic instructions
  constant OP_ADD        : op_code := "100100";
  constant OP_ADDI       : op_code := "100010";
  constant OP_SUBB       : op_code := "100101";
  constant OP_SUBI       : op_code := "100011";
  constant OP_NEG        : op_code := "100110";
  constant OP_INC        : op_code := "100111";
  constant OP_DEC        : op_code := "101000";
  constant OP_MUL        : op_code := "101001";
  -- constant UMUL       : op_code := "101010"; REMOVED, NOT NECESSARY AND CAN'T BE IMPLEMENTED

  -- Compare instructions
  constant OP_CMP        : op_code := "110111";
  constant OP_CMPI       : op_code := "111000";
  -- constant PASS       : op_code := "001101"; REMOVED, unnecessary
  -- Shift instructions
  constant OP_LSL        : op_code := "101011";
  constant OP_LSR        : op_code := "101100";
  -- constant ASL        : op_code := "101101"; REMOVED, NOT NECESSARY AND CAN'T BE IMPLEMENTED
  -- constant ASR        : op_code := "101110"; REMOVED, NOT NECESSARY AND CAN'T BE IMPLEMENTED
  -- Logical instructions
  constant OP_ANDD       : op_code := "101111";
  constant OP_ORR        : op_code := "110000";
  constant OP_XORR       : op_code := "110001";
  constant OP_NOTT       : op_code := "110010";

  -- Subroutine instructions
  -- constant CALL       : op_code := "000101"; REMOVED, solved in assembler instead
  -- constant RET        : op_code := "000100"; REMOVED, solved in assembler instead

  -- Branching instrucctions
  constant OP_BREQ       : op_code := "000110";
  constant OP_BRNE       : op_code := "000111";
  constant OP_BRLT       : op_code := "001000";
  constant OP_BRGT       : op_code := "001001";
  constant OP_BRLE       : op_code := "001010";
  constant OP_BRGE       : op_code := "001011";
  constant OP_RJMP       : op_code := "001100";
  constant OP_RJMPRG     : op_code := "111011";

  -- I/O instuctions
  constant OP_IN        : op_code := "000011";
  constant OP_OUT       : op_code := "111001";


  -- NOP instructions
  constant OP_NOP        : op_code := "000000"; -- Ox00


end PIPECPU_STD;
