library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

entity pipe_CPU is
  port(
        clk : in std_logic;
        rst : in std_logic;

        -- KEYBOARD --
        PS2KeyboardCLK : in std_logic;
        PS2KeyboardData : in std_logic;
        
        -- VGA ENGINE --
        vga_r  : out std_logic_vector(2 downto 0);
        vga_g  : out std_logic_vector(2 downto 0);
        vga_b  : out std_logic_vector(2 downto 1);
        h_sync : out std_logic;
        v_sync : out std_logic

  );
end pipe_CPU;

architecture Behavioral of pipe_CPU is

  -------------------------- CONSTANTS ----------------------------
  constant NOP : unsigned(31 downto 0) := (others => '0'); -- NOP variabl
  
  ----------------------- INTERNAL SIGNALS ------------------------
  signal IR1, IR2, IR3, IR4 : unsigned(31 downto 0);
  signal IR1_next, IR2_next, IR3_next, IR4_next : unsigned(31 downto 0);
  signal pm_out : unsigned(31 downto 0);
  signal pipe_control_signal : unsigned(1 downto 0);

  -------------------------- ALIASES ------------------------------
  
  alias IR1_IMM : unsigned(15 downto 0) is IR1(15 downto 0);
  alias IR2_IMM : unsigned(15 downto 0) is IR2(15 downto 0);  


  ---------------------- EXTERNAL COMPONENTS ------------------------
  --- VGA ENGINE ---
  component vga_engine is
  port (
        clk		 : in std_logic;
        rst    : in std_logic;
        
        char	   : in  unsigned(7 downto 0);
        fg_color : in  unsigned(7 downto 0);
        bg_color : in  unsigned(7 downto 0);
        addr	   : out unsigned(15 downto 0);
        
        vga_r  : out std_logic_vector(2 downto 0);
        vga_g  : out std_logic_vector(2 downto 0);
        vga_b  : out std_logic_vector(2 downto 1);
        h_sync : out std_logic;
        v_sync : out std_logic
  );
  end component;

  --- Keyboard Decoder ---
  component keyboard_decoder is
  port ( 
        clk    : in std_logic;			-- system clock (100 MHz)
        rst    : in std_logic;			-- reset signal

        PS2KeyboardCLK	      : in std_logic; 		-- USB keyboard PS2 clock
        PS2KeyboardData	    : in std_logic;			-- USB keyboard PS2 data
        read_control_signal  : in std_logic; 

        out_register : out unsigned(31 downto 0)
  );
  end component;
  

  ---------------------- INTERNAL COMPONENTS ------------------------

  ----------- ControlUnit ------------
  component control_unit is
  port (
        clk : in std_logic;
        rst : in std_logic;
        -- IR in
        IR1 : in unsigned(31 downto 0);
        IR2 : in unsigned(31 downto 0);
        IR3 : in unsigned(31 downto 0);
        IR4 : in unsigned(31 downto 0);
        -- Flags input
        Z_flag : in std_logic;
        N_flag : in std_logic;
        O_flag : in std_logic;
        C_flag : in std_logic;
        -- Pipeline
        pipe_control_signal : out unsigned(1 downto 0);        
        -- PM 
        pm_control_signal : out unsigned(2 downto 0);
        -- RegisterFile control SIGNALS
        rf_read_d_or_b_control_signal : out std_logic;
        rf_write_d_control_signal : out std_logic;
        -- DataForwarding        
        df_control_signal : out unsigned(5 downto 0);
        -- ALU control signals  
        alu_update_flags_control_signal : out std_logic; -- 1 for true 0 for false
        alu_data_size_control_signal : out byte_mode;
        alu_op_control_signal : out op_code;
        -- KEYBOARD
        keyboard_read_signal : out std_logic;        
        -- DataMemory
        dm_write_or_read_control_signal : out std_logic;
        dm_size_mode_control_signal : out byte_mode;
        -- VideoMemory
        vm_write_enable_control_signal : out std_logic;
        -- WriteBackLogic
        wb_control_signal : out unsigned(1 downto 0)
  );
  end component;

  ----------- ALU ------------
  component ALU is
  port (
        clk : in std_logic;
        rst : in std_logic;
        
        update_flags_control_signal : in std_logic;
        data_size_control_signal : in byte_mode;
        alu_op_control_signal : in unsigned(5 downto 0);

        alu_a : in unsigned(31 downto 0); -- rA
        alu_b : in unsigned(31 downto 0); -- rB or IMM

        alu_res : out unsigned(31 downto 0);

        Z_flag, N_flag, O_flag, C_flag : buffer std_logic
  );
  end component;
  
  ----------- DATA FORWARDING ------------  
  component DataForwarding is 
  port (
        clk: in std_logic;
				rst : in std_logic;
        A2 : in unsigned(31 downto 0);
        B2 : in unsigned(31 downto 0);
        D3 : in unsigned(31 downto 0);
        D4 : in unsigned(31 downto 0);
        IMM2 : in unsigned(15 downto 0); -- 16 bit immediate
        control_signal : in unsigned(5 downto 0);        
        ALU_a_out: buffer unsigned(31 downto 0);
        ALU_b_out: out unsigned(31 downto 0);
        AR3_out: out unsigned(15 downto 0) -- 16 bit address
  );  
  end component;


  ----------- DATA MEMORY ---------------
  component data_memory is
  port (
        clk : in std_logic;
        rst : in std_logic;

        address : in unsigned(15 downto 0);

        write_or_read : in std_logic; -- Should write if '1' , else read

        size_mode  : in byte_mode;
        
        write_data : in unsigned(31 downto 0);
        read_data  : out unsigned(31 downto 0)
  );
  end component;

  ------------ PROGRAM MEMORY ---------------
  component program_memory is 
  port (
        clk : in std_logic;
        rst : in std_logic;

        pm_control_signal   : in unsigned(2 downto 0); -- stall, write, jmp
        pm_jump_offset           : in unsigned(15 downto 0);
        pm_write_data       : in unsigned(31 downto 0);
        pm_write_address    : in unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);

        pm_counter  : buffer unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
        pm_out      : out unsigned(31 downto 0)
  );
  end component; 

  ------- VIDEO MEMORY -------
  component video_memory is
  port (
        clk : in std_logic;
        rst : in std_logic;
        
        -- User port
        write_address : in unsigned(15 downto 0);
        write_data    : in unsigned(15 downto 0);
        write_enable  : in std_logic; -- Should write if true

        -- VGA engine port
        read_address : in  unsigned(15 downto 0);
        char         : out unsigned(7 downto 0);
        fg_color     : out unsigned(7 downto 0);
        bg_color     : out unsigned(7 downto 0)
  );
  end component;  


  ------------------------ MAPPING SIGNALS -----------------------
  -- MEM MAPPING SIGNALS --
  signal map_mem_address : unsigned(15 downto 0);
  signal map_mem_write_data : unsigned(31 downto 0);  

  signal map_update_flags_control_signal : std_logic;
  signal map_data_size_control_signal : byte_mode;
  signal map_alu_op_control_signal : unsigned(5 downto 0);
  signal map_alu_a : unsigned(31 downto 0);
  signal map_alu_b : unsigned(31 downto 0);
  signal map_alu_res : unsigned(31 downto 0);
  signal map_Z_flag, map_N_flag, map_O_flag, map_C_flag : std_logic;
  
  signal map_vm_write_enable_control_signal : std_logic;
  
  signal map_vga_address : unsigned(15 downto 0);
  signal map_vga_char : unsigned(7 downto 0);
  signal map_vga_fg_color : unsigned(7 downto 0);
  signal map_vga_bg_color : unsigned(7 downto 0);

  signal map_pm_control_signal : unsigned(2 downto 0);
  signal map_pm_counter : unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1); -- Currently UNUSED !!!!!!!
    
  signal map_rf_read_d_or_b_control_signal : std_logic;
  signal map_rf_write_d_control_signal : std_logic;
  signal map_rf_out_a : unsigned(31 downto 0);
  signal map_rf_out_b : unsigned(31 downto 0);  

  signal map_df_control_signal : unsigned(5 downto 0);

  signal map_kb_read_control_signal : std_logic;
  signal map_kb_out : unsigned(31 downto 0);

  signal map_dm_write_or_read_control_signal : std_logic;
  signal map_dm_size_mode_control_signal : byte_mode;
  signal map_dm_read_data_out : unsigned(31 downto 0);

  signal map_wb_control_signal : unsigned(1 downto 0);
  signal map_wb_out_3 : unsigned(31 downto 0);
  signal map_wb_out_4 : unsigned(31 downto 0);


begin

  ------------------------- PORT MAPPINGS ------------------------
  ---------- INTERNAl MAPPINGS -------------

  ----------- ControlUnit ------------
  U_CONTROL_UNIT : control_unit
  port map (
        clk => clk, -- IN
        rst => rst, -- IN
        -- IR in
        IR1 => IR1, -- IN
        IR2 => IR2, -- IN
        IR3 => IR3, -- IN
        IR4 => IR4, -- IN
        -- Flags input
        Z_flag => map_Z_flag, -- IN
        N_flag => map_N_flag, -- IN
        O_flag => map_O_flag, -- IN
        C_flag => map_C_flag, -- IN
        -- Pipeline
        pipe_control_signal => pipe_control_signal, -- OUT        
        -- PM 
        pm_control_signal => map_pm_control_signal, -- OUT
        -- RegisterFile control SIGNALS
        rf_read_d_or_b_control_signal => map_rf_read_d_or_b_control_signal, -- OUT
        rf_write_d_control_signal => map_rf_write_d_control_signal, -- OUT
        -- DataForwarding        
        df_control_signal => map_df_control_signal, -- OUT
        -- ALU control signals  
        alu_update_flags_control_signal => map_update_flags_control_signal, -- OUT
        alu_data_size_control_signal => map_data_size_control_signal, -- OUT
        alu_op_control_signal => map_alu_op_control_signal, -- OUT
        -- KEYBOARD
        keyboard_read_signal => map_kb_read_control_signal, -- OUT
        -- DataMemory
        dm_write_or_read_control_signal => map_dm_write_or_read_control_signal, -- OUT
        dm_size_mode_control_signal => map_dm_size_mode_control_signal, -- OUT 
        -- VideoMemory
        vm_write_enable_control_signal => map_vm_write_enable_control_signal, -- OUT
        -- WriteBackLogic
        wb_control_signal => map_wb_control_signal -- OUT
  );

  ----------- ALU ------------
  U_ALU : ALU
  port map (
      clk => clk,                                                     -- IN
      rst => rst,                                                     -- IN
      update_flags_control_signal => map_update_flags_control_signal, -- IN
      data_size_control_signal => map_data_size_control_signal,       -- IN
      alu_op_control_signal => map_alu_op_control_signal,             -- IN
      alu_a => map_alu_a,                                             -- IN
      alu_b => map_alu_b,                                             -- IN

      alu_res => map_alu_res,                                         -- OUT
      Z_flag => map_Z_flag,                                           -- OUT
      N_flag => map_N_flag,                                           -- OUT
      O_flag => map_O_flag,                                           -- OUT
      C_flag => map_C_flag                                            -- OUT
  );

  ----------- DATA FORWARDING ------------
  U_DF : DataForwarding 
  port map (
      clk => clk, -- IN
			rst => rst, -- IN
      A2 => map_rf_out_a, -- IN
      B2 => map_rf_out_b, -- IN
      D3 => map_wb_out_3, -- IN
      D4 => map_wb_out_4, -- IN
      IMM2 => IR2_IMM, -- IN
      control_signal => map_df_control_signal, -- IN    

      ALU_a_out => map_alu_a, -- OUT
      ALU_b_out => map_alu_b, -- OUT
      AR3_out => map_mem_address -- OUT
  );

  ----------- DATA MEMORY ---------------
  U_DM : data_memory
  port map (
      clk => clk, -- IN
      rst => rst, -- IN
      address => map_mem_address, -- IN
      write_or_read => map_dm_write_or_read_control_signal, -- IN
      size_mode  => map_dm_size_mode_control_signal, -- IN
      write_data => map_mem_write_data, -- IN

      read_data  => map_dm_read_data_out -- OUT
  );

  ----------- PROGRAM MEMORY ---------------
  U_PM : program_memory  
  port map (
        clk => clk, -- IN
        rst => rst, -- IN

        pm_control_signal => map_pm_control_signal, -- IN
        pm_jump_offset => IR1_IMM, -- IN, -- Maps to pipeline
        pm_write_data => map_mem_write_data, -- IN
        pm_write_address => map_mem_address, -- IN

        pm_counter => map_pm_counter, -- OUT
        pm_out => pm_out -- OUT, maps to Pipeline
  );

  ----------- VIDEO MEM ------------
  U_VMEM: video_memory 
  port map (
     clk => clk,                                           -- IN
     rst => rst,                                           -- IN
     write_address => map_mem_address,                     -- IN 
     write_data => map_mem_write_data(15 downto 0),        -- IN
     write_enable => map_vm_write_enable_control_signal,   -- IN         
     read_address => map_vga_address,                      -- IN

     char => map_vga_char,                                 -- OUT
     fg_color => map_vga_fg_color,                         -- OUT
     bg_color => map_vga_bg_color                          -- OUT
  );


  ---------- EXTERNAL MAPPINGS -------------

  ----------- VGA ------------
   U_VGA : vga_engine 
   port map (
      -- INTERNAL
      clk => clk,                        -- IN
      rst => rst,                        -- IN
      char => map_vga_char,              -- IN
      fg_color => map_vga_fg_color,      -- IN
      bg_color => map_vga_bg_color,      -- IN
      addr => map_vga_address,           -- OUT
      -- EXTERNAL
      vga_r => vga_r,                    -- OUT
      vga_g => vga_g,                    -- OUT
      vga_b => vga_b,                    -- OUT
      h_sync => h_sync,                  -- OUT
      v_sync => v_sync                   -- OUT
   );

  ------ KEYBOARD DECODER ------
  U_KD : keyboard_decoder
  port map ( 
        clk => clk, -- IN
        rst => rst, -- IN
        PS2KeyboardCLK => PS2KeyboardCLK, -- IN
        PS2KeyboardData	=> PS2KeyboardData, -- IN
        read_control_signal => map_kb_read_control_signal, -- IN

        out_register => map_kb_out -- OUT
  );
  


  -------------------------- INTERNAL LOGIC ----------------------------



  -- Data stall / jump mux logic
  with pipe_control_signal select
  IR1_next <= NOP when PIPE_JMP,
              IR1 when PIPE_STALL,
              pm_out when others;
    
  with pipe_control_signal select
  IR2_next <= NOP when PIPE_STALL,
              IR1 when others;
  
  IR3_next <= IR2;

  IR4_next <= IR3;

  -- Update registers on clock cycle
  process(clk)
  begin
    if rising_edge(clk) then 
      if rst = '1' then 
        IR1 <= NOP;
        IR2 <= NOP;
        IR3 <= NOP;
        IR4 <= NOP;
      else
        IR1 <= IR1_next;
        IR2 <= IR2_next;
        IR3 <= IR3_next;
        IR4 <= IR4_next;
      end if;
    end if;
  end process;

------------------------------------ END ---------------------------------

end architecture;    

