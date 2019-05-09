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
  signal is_new: unsigned(0 downto 0) := "0"; -- TODO: Reset it if get a fetch signal
  signal is_make:unsigned(0 downto 0) := "1";
  type state_type is (IDLE, MAKE, BREAK);			-- declare state types for PS2
  signal PS2state : state_type;					-- PS2 state

  constant SHIFT_KEY : std_logic_vector(7 downto 0) := X"30";
  constant CTRL_KEY : std_logic_vector(7 downto 0) := X"31";
  constant OUT_PADDING : unsigned(19 downto 0) := "00000000000000000000"; -- We have 12 bits of information
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
      end if;
    end if;
  end process;



  ScanCode <= PS2Data_sr(8 downto 1);
	
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
      if PS2state = MAKE or PS2state = BREAK then 
        is_new <= "1"; -- Get's reseted when assembly requests 'in'
      end if;
      if rst='1' then
        PS2state <= IDLE; 
      elsif PS2state = IDLE then 
        if make_op = '1' and ScanCode = X"F0" then 
          PS2state <= BREAK;
        elsif make_op = '1' then
          PS2state <= MAKE;
          is_make <= "1";
          if ScanCode = SHIFT_KEY then 
            is_shift_down <= "1";
          else if ScanCode = CTRL_KEY then 
            is_ctrl_down <= "1";
          end if;
        end if;
      elsif PS2state = MAKE then 
        PS2state <= IDLE;
      elsif PS2state = BREAK then
        if make_op = '1' then
          -- Get the ScanCode: This is the key that was lifted.
          PS2state <= IDLE;
          is_make <= "0";
          if ScanCode = SHIFT_KEY then 
            is_shift_down <= "0";
          elsif ScanCode = CTRL_KEY then 
            is_ctrl_down <= "0";
          end if;
        end if;
      end if;
    end if;
  end if;
  end process;
	


  -- Scan Code -> Tile Index mapping
  with ScanCode select
    key_value <= 
     x"00" when x"29",	-- space
     x"01" when x"1C",	-- A
     x"02" when x"32",	-- B
		 x"03" when x"21",	-- C
		 x"04" when x"23",	-- D
		 x"05" when x"24",	-- E
		 x"06" when x"2B",	-- F
		 x"07" when x"34",	-- G
		 x"08" when x"33",	-- H
		 x"09" when x"43",	-- I
		 x"0A" when x"3B",	-- J
		 x"0B" when x"42",	-- K
		 x"0C" when x"4B",	-- L
		 x"0D" when x"3A",	-- M
		 x"0E" when x"31",	-- N
		 x"0F" when x"44",	-- O
		 x"10" when x"4D",	-- P
		 x"11" when x"15",	-- Q
		 x"12" when x"2D",	-- R
		 x"13" when x"1B",	-- S
		 x"14" when x"2C",	-- T
		 x"15" when x"3C",	-- U
		 x"16" when x"2A",	-- V
		 x"17" when x"1D",	-- W
		 x"18" when x"22",	-- X
		 x"19" when x"35",	-- Y
		 x"1A" when x"1A",	-- Z
     x"1B" when x"54",  -- Å
     x"1C" when x"52",  -- Ä
     x"1D" when x"4C",  -- Ö
     x"1E" when x"5A",  -- \n
     x"1F" when x"66",  -- backspace
		 x"00" when others;
						 
						 


  out_register <= OUT_PADDING & is_new & is_make & is_ctrl_down & is_shift_down & key_value;


  
end behavioral;
