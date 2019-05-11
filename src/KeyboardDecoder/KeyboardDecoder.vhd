--------------------------------------------------------------------------------
-- KBD ENC
-- Anders Nilsson
-- 16-feb-2016
-- Version 1.1


-- library declaration
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;            -- basic IEEE library
use IEEE.NUMERIC_STD.ALL;               -- IEEE library for the unsigned type
                                        -- and various arithmetic operations

-- entity
entity keyboard_decoder is
  port ( 
         clk	                : in std_logic;			-- system clock (100 MHz)
	       rst		        : in std_logic;			-- reset signal
         PS2KeyboardCLK	        : in std_logic; 		-- USB keyboard PS2 clock
         PS2KeyboardData	: in std_logic;			-- USB keyboard PS2 data
         read_control_signal : in std_logic;
         out_register : out unsigned(31 downto 0)
         );
end keyboard_decoder;

-- architecture
architecture Behavioral of keyboard_decoder is
  signal PS2Clk			: std_logic;			-- Synchronized PS2 clock
  signal PS2Data		: std_logic;			-- Synchronized PS2 data
  signal PS2Clk_Q1, PS2Clk_Q2 	: std_logic;			-- PS2 clock one pulse flip flop
  signal PS2Clk_op 		: std_logic;			-- PS2 clock one pulse 
	
  signal PS2Data_sr 		: std_logic_vector(10 downto 0);-- PS2 data shift register
	
  signal PS2BitCounter	        : unsigned(3 downto 0);		-- PS2 bit counter
  signal make_Q			: std_logic;			-- make one pulselse flip flop
  signal make_op		: std_logic;			-- make one pulse

  signal ScanCode		: std_logic_vector(7 downto 0);	-- scan code
  
	

  -- MY STUFF: MosqueOS
  signal key_value : unsigned(7 downto 0);
  signal is_shift_down: unsigned(0 downto 0) := "0";
  signal is_ctrl_down: unsigned(0 downto 0) := "0";
  signal is_alt_down: unsigned(0 downto 0) := "0";
  signal is_new: unsigned(0 downto 0) := "0"; -- TODO: Reset it if get a fetch signal
  signal is_make : unsigned(0 downto 0) := "0";
  signal read_signal_q1 : std_logic := '0'; 
  type state_type is (IDLE, MAKE, BREAK);			-- declare state types for PS2
  signal PS2state : state_type := IDLE;					-- PS2 state
  signal debug_counter : unsigned(7 downto 0) := X"00";

  constant LEFT_SHIFT_KEY : std_logic_vector(7 downto 0) := X"12";
  constant RIGHT_SHIFT_KEY : std_logic_vector(7 downto 0) := X"59";
  constant CTRL_KEY : std_logic_vector(7 downto 0) := X"14";
  constant ALT_KEY : std_logic_vector(7 downto 0) := X"11";
  constant OUT_PADDING : unsigned(10 downto 0) := "00000000000"; --
begin

  -- Synchronize PS2-KBD signals
  process(clk)
  begin
    if rising_edge(clk) then
      PS2Clk <= PS2KeyboardCLK;
      PS2Data <= PS2KeyboardData;
    end if;
  end process;

	
  -- Generate one cycle pulse from PS2 clock, negative edge

  process(clk)
  begin
    if rising_edge(clk) then
      if rst='1' then
        PS2Clk_Q1 <= '1';
        PS2Clk_Q2 <= '0';
      else
        PS2Clk_Q1 <= PS2Clk;
        PS2Clk_Q2 <= not PS2Clk_Q1;
      end if;
    end if;
  end process;
	
  PS2Clk_op <= (not PS2Clk_Q1) and (not PS2Clk_Q2);
	

  
  -- PS2 data shift register

  -- ***********************************
  -- *                                 *
  -- *  VHDL for :                     *
  -- *  PS2_data_shift_reg             *
  -- *                                 *
  -- ***********************************

  process(clk)
  begin
    if rising_edge(clk) then
      if rst='1' then
        PS2Data_sr <= (others => '0');
      elsif PS2Clk_op = '1' then
        PS2Data_sr <= PS2Data & PS2Data_sr(10 downto 1);
        debug_counter <= debug_counter + 1; 
      end if;
    end if;
  end process;



  ScanCode <= PS2Data_sr(8 downto 1) when make_op = '1' else ScanCode;
	
  -- PS2 bit counter
  -- The purpose of the PS2 bit counter is to tell the PS2 state machine when to change state

  -- ***********************************
  -- *                                 *
  -- *  VHDL for :                     *
  -- *  PS2_bit_Counter                *
  -- *                                 *
  -- ***********************************
  process(clk)
  begin
    if rising_edge(clk) then
      
      make_op <= '0';
      if rst='1' then
        PS2BitCounter <= (others => '0'); 
      elsif PS2Clk_op = '1' then
        if PS2BitCounter = 10 then 
          make_op <= '1';
          PS2BitCounter <= (others => '0');
        else          
          PS2BitCounter <= PS2BitCounter + 1;
        end if;
      end if;
    end if;
  end process;
	
	

  -- 4 cases
  -- 1. Shift down, 'a' down, 'a' up, Shift up => 'A' down
  -- 2. 'a' down, Shift down -> Nothin special => 'a' down
  -- 3. Shift down, 'a' down, Shift up, 'a' up => 'A' down


	 process(clk)
   begin
    if rising_edge(clk) then
      if rst='1' then
        PS2state <= IDLE; 
      elsif PS2state = IDLE then 
        if make_op = '1' and ScanCode = X"F0" then 
          PS2state <= BREAK;
        elsif make_op = '1' then
          PS2state <= MAKE;
          is_make <= "1";
          if ScanCode = LEFT_SHIFT_KEY or ScanCode = RIGHT_SHIFT_KEY then 
            is_shift_down <= "1";
          elsif ScanCode = CTRL_KEY then 
            is_ctrl_down <= "1";
          elsif ScanCode = ALT_KEY then 
            is_alt_down <= "1";
          end if;
        end if;
      elsif PS2state = MAKE then 
        PS2state <= IDLE;
      elsif PS2state = BREAK then
        if make_op = '1' then
          -- Get the ScanCode: This is the key that was lifted.
          PS2state <= IDLE;
          is_make <= "0";
          if ScanCode = LEFT_SHIFT_KEY or ScanCode = RIGHT_SHIFT_KEY then 
            is_shift_down <= "0";
          elsif ScanCode = CTRL_KEY then 
            is_ctrl_down <= "0";
          elsif ScanCode = ALT_KEY then 
            is_alt_down <= "0";
          end if;
        end if;
      end if;
    end if;
  end process;
  
  
  
  process(clk)
  begin
   if rising_edge(clk) then
      read_signal_q1 <= read_control_signal;
      if PS2state = MAKE or PS2state = BREAK then 
        is_new <= "1"; -- Get's reseted when assembly requests 'in'
      elsif read_signal_q1 = '1' then 
        is_new <= "0";
      end if;
    end if;
  end process;


  -- Scan Code -> ASCII
    key_value <=
     x"08" when ScanCode = x"66" else  -- backspace
     x"1b" when ScanCode = x"76" else  -- Escape
     x"09" when ScanCode = x"0D" else  -- \t
     x"0A" when ScanCode = x"5A" else  -- \n
     x"20" when ScanCode = x"29" else	-- space
-- Shift numbers
     x"21" when (ScanCode = x"16" and is_shift_down = "1") else	-- ! 
     x"22" when (ScanCode = x"1E" and is_shift_down = "1") else	-- "
     x"23" when (ScanCode = x"26" and is_shift_down = "1") else	-- #
     x"00" when (ScanCode = x"25" and is_shift_down = "1") else	-- ¤
     x"25" when (ScanCode = x"2E" and is_shift_down = "1") else	-- %
     x"26" when (ScanCode = x"36" and is_shift_down = "1") else	-- & 
     x"2F" when (ScanCode = x"3D" and is_shift_down = "1") else	-- /  
     x"28" when (ScanCode = x"3E" and is_shift_down = "1") else	-- (  
     x"29" when (ScanCode = x"46" and is_shift_down = "1") else	-- )
     x"3D" when (ScanCode = x"45" and is_shift_down = "1") else	-- =
-- Alt numbers
     x"40" when (ScanCode = x"1E" and is_alt_down = "1") else	-- @
     x"00" when (ScanCode = x"26" and is_alt_down = "1") else	-- £
     x"24" when (ScanCode = x"25" and is_alt_down = "1") else	-- $
     x"00" when (ScanCode = x"2E" and is_alt_down = "1") else	-- €
     x"00" when (ScanCode = x"36" and is_alt_down = "1") else	-- ¥
     x"7B" when (ScanCode = x"3D" and is_alt_down = "1") else	-- {  
     x"5B" when (ScanCode = x"3E" and is_alt_down = "1") else	-- [  
     x"5D" when (ScanCode = x"46" and is_alt_down = "1") else	-- ]
     x"7D" when (ScanCode = x"45" and is_alt_down = "1") else	-- }
-- Numbers
     x"31" when ScanCode = x"16" else	-- 1
     x"32" when ScanCode = x"1E" else	-- 2
     x"33" when ScanCode = x"26" else	-- 3
     x"34" when ScanCode = x"25" else	-- 4
     x"35" when ScanCode = x"2E" else	-- 5
     x"36" when ScanCode = x"36" else	-- 6 
     x"37" when ScanCode = x"3D" else	-- 7  
     x"38" when ScanCode = x"3E" else	-- 8  
     x"39" when ScanCode = x"46" else	-- 9
     x"30" when ScanCode = x"45" else	-- 0

-- Special Shift 
     x"2F" when (ScanCode = x"4E" and is_shift_down = "1") else	-- ?
     x"5E" when (ScanCode = x"5B" and is_shift_down = "1") else	-- ^
     x"2A" when (ScanCode = x"5D" and is_shift_down = "1") else	-- *
     x"5F" when (ScanCode = x"4A" and is_shift_down = "1") else	-- _
     x"3A" when (ScanCode = x"49" and is_shift_down = "1") else	-- :
     x"3B" when (ScanCode = x"41" and is_shift_down = "1") else	-- ;
-- Special Alt 
     x"5C" when (ScanCode = x"4E" and is_alt_down = "1") else	-- Backslash
     x"7E" when (ScanCode = x"5B" and is_alt_down = "1") else	-- ~

-- Special
     x"2B" when ScanCode = x"4E" else	-- +
     x"27" when ScanCode = x"5D" else	-- '
     x"2D" when ScanCode = x"4A" else	-- -
     x"2E" when ScanCode = x"49" else	-- .
     x"2C" when ScanCode = x"41" else	-- ,

-- Non visisble --- 
-- Arrows  
     x"80" when ScanCode = x"6B" else	-- left
     x"81" when ScanCode = x"72" else	-- down
     x"82" when ScanCode = x"75" else	-- up
     x"83" when ScanCode = x"74" else	-- right
     x"88" when ScanCode = x"76" else	-- ESC


     x"41" when (ScanCode = x"1C" and is_shift_down = "1") else	-- A
     x"42" when (ScanCode = x"32" and is_shift_down = "1") else	-- B
		 x"43" when (ScanCode = x"21" and is_shift_down = "1") else	-- C
		 x"44" when (ScanCode = x"23" and is_shift_down = "1") else	-- D
		 x"45" when (ScanCode = x"24" and is_shift_down = "1") else	-- E
		 x"46" when (ScanCode = x"2B" and is_shift_down = "1") else	-- F
		 x"47" when (ScanCode = x"34" and is_shift_down = "1") else	-- G
		 x"48" when (ScanCode = x"33" and is_shift_down = "1") else	-- H
		 x"49" when (ScanCode = x"43" and is_shift_down = "1") else	-- I
		 x"4A" when (ScanCode = x"3B" and is_shift_down = "1") else	-- J
		 x"4B" when (ScanCode = x"42" and is_shift_down = "1") else	-- K
		 x"4C" when (ScanCode = x"4B" and is_shift_down = "1") else	-- L
		 x"4D" when (ScanCode = x"3A" and is_shift_down = "1") else	-- M
		 x"4E" when (ScanCode = x"31" and is_shift_down = "1") else	-- N
		 x"4F" when (ScanCode = x"44" and is_shift_down = "1") else	-- O
		 x"50" when (ScanCode = x"4D" and is_shift_down = "1") else	-- P
		 x"51" when (ScanCode = x"15" and is_shift_down = "1") else	-- Q
		 x"52" when (ScanCode = x"2D" and is_shift_down = "1") else	-- R
		 x"53" when (ScanCode = x"1B" and is_shift_down = "1") else	-- S
		 x"54" when (ScanCode = x"2C" and is_shift_down = "1") else	-- T
		 x"55" when (ScanCode = x"3C" and is_shift_down = "1") else	-- U
		 x"56" when (ScanCode = x"2A" and is_shift_down = "1") else	-- V
		 x"57" when (ScanCode = x"1D" and is_shift_down = "1") else	-- W
		 x"58" when (ScanCode = x"22" and is_shift_down = "1") else	-- X
		 x"59" when (ScanCode = x"35" and is_shift_down = "1") else	-- Y
		 x"5A" when (ScanCode = x"1A" and is_shift_down = "1") else	-- Z
     x"61" when ScanCode = x"1C" else	-- a
     x"62" when ScanCode = x"32" else	-- b
		 x"63" when ScanCode = x"21" else	-- c
		 x"64" when ScanCode = x"23" else	-- d
		 x"65" when ScanCode = x"24" else	-- e
		 x"66" when ScanCode = x"2B" else	-- f
		 x"67" when ScanCode = x"34" else	-- G
		 x"68" when ScanCode = x"33" else	-- H
		 x"69" when ScanCode = x"43" else	-- I
		 x"6A" when ScanCode = x"3B" else	-- J
		 x"6B" when ScanCode = x"42" else	-- K
		 x"6C" when ScanCode = x"4B" else	-- L
		 x"6D" when ScanCode = x"3A" else	-- M
		 x"6E" when ScanCode = x"31" else	-- N
		 x"6F" when ScanCode = x"44" else	-- O
		 x"70" when ScanCode = x"4D" else	-- P
		 x"71" when ScanCode = x"15" else	-- Q
		 x"72" when ScanCode = x"2D" else	-- R
		 x"73" when ScanCode = x"1B" else	-- S
		 x"74" when ScanCode = x"2C" else	-- T
		 x"75" when ScanCode = x"3C" else	-- U
		 x"76" when ScanCode = x"2A" else	-- V
		 x"77" when ScanCode = x"1D" else	-- W
		 x"78" when ScanCode = x"22" else	-- X
		 x"79" when ScanCode = x"35" else	-- Y
		 x"7A" when ScanCode = x"1A" else	-- Z
		 x"00";
						 
						 


  out_register <= OUT_PADDING & unsigned(ScanCode) & is_new  & is_make & is_ctrl_down & is_shift_down & is_alt_down & key_value;
  --out_register <= OUT_PADDING & unsigned(ScanCode) & is_new & is_make & is_ctrl_down & is_shift_down & is_alt_down & unsigned(ScanCode) ;
  --out_register <= OUT_PADDING & is_new & is_make & is_ctrl_down & is_shift_down & debug_counter;
  --out_register <= X"FFFF_FFFF";

  
end behavioral;
