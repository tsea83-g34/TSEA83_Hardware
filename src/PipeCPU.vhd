library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

entity PipeCPU is
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
        v_sync : out std_logic;
        -- 7-seg Debugging
        seg: out  UNSIGNED(7 downto 0);
        an : out  UNSIGNED (3 downto 0)

  );
end PipeCPU;

architecture Behavioral of PipeCPU is

  ---------------------- DEBUGGING SIGNALS ------------------------
  signal IR1_op, IR2_op, IR3_op, IR4_op : op_enum;  

  ----------------------- INTERNAL SIGNALS ------------------------
  signal pipe_IR1, pipe_IR2, pipe_IR3, pipe_IR4 : unsigned(31 downto 0) := X"0000_0000";
  signal pipe_IR1_next, pipe_IR2_next, pipe_IR3_next, pipe_IR4_next : unsigned(31 downto 0);

  signal pm_out : unsigned(31 downto 0);
  signal pipe_control_signal : pipe_op;

  -------------------------- ALIASES ------------------------------
  
  alias pipe_IR1_rD : unsigned(3 downto 0) is pipe_IR1(23 downto 20);
  alias pipe_IR1_rA : unsigned(3 downto 0) is pipe_IR1(19 downto 16);
  alias pipe_IR1_rB : unsigned(3 downto 0) is pipe_IR1(15 downto 12);
  alias pipe_IR1_IMM : unsigned(15 downto 0) is pipe_IR1(15 downto 0);

  alias pipe_IR2_IMM : unsigned(15 downto 0) is pipe_IR2(15 downto 0);  

  alias pipe_IR4_rD : unsigned(3 downto 0) is pipe_IR4(23 downto 20);

  ---------------------- EXTERNAL COMPONENTS ------------------------
  --- VGA ENGINE ---
  component VGA_Engine is
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
  component KeyboardDecoder is
  port ( 
        clk    : in std_logic;			-- system clock (100 MHz)
        rst    : in std_logic;			-- reset signal

        PS2KeyboardCLK	      : in std_logic; 		-- USB keyboard PS2 clock
        PS2KeyboardData	    : in std_logic;			-- USB keyboard PS2 data

        read_signal : in std_logic;

        out_register : out unsigned(31 downto 0)
  );
  end component;
  

  ---------------------- INTERNAL COMPONENTS ------------------------

  ----------- ControlUnit -------------
  component ControlUnit is
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
        -- Debugging outputs
        IR1_op : buffer op_enum;
        IR2_op : buffer op_enum;
        IR3_op : buffer op_enum;
        IR4_op : buffer op_enum;    
        -- Pipeline
        pipe_control_signal : out pipe_op;        
        -- PM 
        pm_jmp_stall : out pm_jmp_stall_enum;  
        pm_write_enable : out pm_write_enum;
        -- RegisterFile control SIGNALS
        rf_read_d_or_b_control_signal : out rf_read_d_or_b_enum;
        rf_write_d_control_signal : out rf_write_d_enum;
        -- DataForwarding        
        df_a_select : out df_select;
        df_b_select : out df_select;    
        df_alu_imm_or_b : out df_alu_imm_or_b_enum;
        df_ar_a_or_b : out df_ar_a_or_b_enum;
        -- ALU control signals  
        alu_update_flags_control_signal : out alu_update_flags_enum; -- 1 for true 0 for false
        alu_data_size_control_signal : out byte_mode;
        alu_op_control_signal : out alu_op;
        -- KEYBOARD
        kb_read_control_signal : out std_logic;
        -- DataMemory
        dm_write_or_read_control_signal : out dm_write_or_read_enum;
        dm_size_mode_control_signal : out byte_mode;
        -- VideoMemory
        vm_write_enable_control_signal : out vm_write_enable_enum;
        -- WriteBackLogic
        wb3_in_or_alu3 : out wb3_in_or_alu3_enum;
        wb4_dm_or_alu4 : out  wb4_dm_or_alu4_enum;
        led_write_control_signal : out std_logic

  );
  end component;

  ----------- ALU ------------
  component ALU is
  port (
        clk : in std_logic;
        rst : in std_logic;
        
        update_flags_control_signal : in alu_update_flags_enum;
        data_size_control_signal : in byte_mode;
        alu_op_control_signal : in alu_op;

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
        df_a_select : in df_select;
        df_b_select : in df_select;    
        df_alu_imm_or_b : in df_alu_imm_or_b_enum; 
        df_ar_a_or_b : in df_ar_a_or_b_enum;       
        ALU_a_out: buffer unsigned(31 downto 0);
        ALU_b_out: out unsigned(31 downto 0);
        AR3_out: out unsigned(15 downto 0) -- 16 bit address
  );  
  end component;


  ----------- DATA MEMORY ---------------
  component DataMemory is
  port (
        clk : in std_logic;
        rst : in std_logic;

        address : in unsigned(15 downto 0);

        write_or_read : in dm_write_or_read_enum;

        size_mode  : in byte_mode;
        
        write_data : in unsigned(31 downto 0);
        read_data  : out unsigned(31 downto 0)
  );
  end component;

  ------------ PROGRAM MEMORY ---------------
  component ProgramMemory is 
  port (
        clk : in std_logic;
        rst : in std_logic;

        pm_jmp_stall : in pm_jmp_stall_enum;
        pm_write_enable : in pm_write_enum;

        pm_jmp_offs_imm : in unsigned(15 downto 0);
        pm_jmp_offs_reg : in unsigned(15 downto 0);

        pm_write_data       : in unsigned(31 downto 0);
        pm_write_address    : in unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);

        pm_counter  : buffer unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
        pm_out      : out unsigned(31 downto 0)
  );
  end component; 

  ------------ REGISTER FILE ---------------
  component RegisterFile is
  port (
        clk : in std_logic;
        rst : in std_logic;

        read_addr_a : in unsigned(3 downto 0);
        read_addr_b : in unsigned(3 downto 0);
				read_addr_d : in unsigned(3 downto 0);
				
				read_d_or_b_control_signal : in rf_read_d_or_b_enum; -- 1 => read addr_d, 0 => read addr_b

        write_d_control_signal : in rf_write_d_enum; -- Should write

        write_addr_d : in unsigned(3 downto 0);
        write_data_d : in unsigned(31 downto 0);

        out_A2 : out unsigned(31 downto 0);
        out_B2 : out unsigned(31 downto 0)
  );
  end component;

  ------------ VIDEO MEMORY ---------------
  component VideoMemory is
  port (
        clk : in std_logic;
        rst : in std_logic;
        
        -- User port
        write_address : in unsigned(15 downto 0);
        write_data    : in unsigned(15 downto 0);
        write_enable  : in vm_write_enable_enum; -- Should write if true

        -- VGA engine port
        read_address : in  unsigned(15 downto 0);
        char         : out unsigned(7 downto 0);
        fg_color     : out unsigned(7 downto 0);
        bg_color     : out unsigned(7 downto 0)
  );
  end component;  

  ------------ WRITE BACK LOGIC ---------------
  component WriteBackLogic is
  port (
        clk : in std_logic;
        rst : in std_logic;

        alu_res : in unsigned(31 downto 0);
        dm_out : in unsigned(31 downto 0);
        keyboard_out : in unsigned(31 downto 0);

        wb3_in_or_alu3 : in wb3_in_or_alu3_enum;
        wb4_dm_or_alu4 : in wb4_dm_or_alu4_enum;

        write_back_out_3 : buffer unsigned(31 downto 0);
        write_back_out_4 : out unsigned(31 downto 0)
  );
  end component;

  -- DEBUGGING
  component leddriver
  Port ( 
         clk,rst : in  STD_LOGIC;
         seg : out  UNSIGNED(7 downto 0);
         an : out  UNSIGNED (3 downto 0);
         value : in  UNSIGNED (15 downto 0);
         write_enable : in std_logic
        );
  end component;


  ------------------------ MAPPING SIGNALS -----------------------
  -- MEM MAPPING SIGNALS --
  signal map_mem_address : unsigned(15 downto 0);

  signal map_update_flags_control_signal : alu_update_flags_enum;
  signal map_data_size_control_signal : byte_mode;
  signal map_alu_op_control_signal : alu_op;
  signal map_alu_res : unsigned(31 downto 0);
  signal map_Z_flag, map_N_flag, map_O_flag, map_C_flag : std_logic;
  
  signal map_vm_write_enable_control_signal : vm_write_enable_enum;
  
  signal map_vga_address : unsigned(15 downto 0);
  signal map_vga_char : unsigned(7 downto 0);
  signal map_vga_fg_color : unsigned(7 downto 0);
  signal map_vga_bg_color : unsigned(7 downto 0);

  signal map_pm_jmp_stall : pm_jmp_stall_enum;
  signal map_pm_write_enable : pm_write_enum;
  signal map_pm_counter : unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1); -- Currently UNUSED !!!!!!!
    
  signal map_rf_read_d_or_b_control_signal : rf_read_d_or_b_enum;
  signal map_rf_write_d_control_signal : rf_write_d_enum;
  signal map_rf_out_A2 : unsigned(31 downto 0);
  signal map_rf_out_B2 : unsigned(31 downto 0);

  signal map_df_a_select : df_select;
  signal map_df_b_select : df_select;    
  signal map_df_alu_imm_or_b : df_alu_imm_or_b_enum; -- 1 for IMM, 0 for b
  signal map_df_ar_a_or_b : df_ar_a_or_b_enum; -- 1 for a, 0 for b
  signal map_df_a_out : unsigned(31 downto 0);
  signal map_df_b_out : unsigned(31 downto 0);

  signal map_kb_read_signal : std_logic;
  signal map_kb_out : unsigned(31 downto 0);

  signal map_dm_write_or_read_control_signal : dm_write_or_read_enum;
  signal map_dm_size_mode_control_signal : byte_mode;
  signal map_dm_read_data_out : unsigned(31 downto 0);

  signal map_wb3_in_or_alu3 : wb3_in_or_alu3_enum;
  signal map_wb4_dm_or_alu4 : wb4_dm_or_alu4_enum;

  signal map_wb_out_3 : unsigned(31 downto 0);
  signal map_wb_out_4 : unsigned(31 downto 0);
  signal keyboard_display_value : unsigned(15 downto 0) := X"0000";
  signal map_led_write : std_logic := '0';
  signal map_led_value : unsigned(15 downto 0);

begin

  ------------------------- PORT MAPPINGS ------------------------
  ---------- INTERNAl MAPPINGS -------------



  ----------- ControlUnit ------------
  U_CONTROL_UNIT : ControlUnit
  port map (
        clk => clk, -- IN, from pipe
        rst => rst, -- IN, from pipe
        -- IR in
        IR1 => pipe_IR1, -- IN, from pipe pipe
        IR2 => pipe_IR2, -- IN, from pipe pipe
        IR3 => pipe_IR3, -- IN, from pipe pipe
        IR4 => pipe_IR4, -- IN, from pipe pipe
        -- Flags input
        Z_flag => map_Z_flag, -- IN, from ALU
        N_flag => map_N_flag, -- IN, from ALU 
        O_flag => map_O_flag, -- IN, from ALU
        C_flag => map_C_flag, -- IN, from ALU
        -- Debugging outputs
        IR1_op => IR1_op, -- OUT, to pipe
        IR2_op => IR2_op, -- OUT, to pipe 
        IR3_op => IR3_op, -- OUT, to pipe
        IR4_op => IR4_op, -- OUT, to pipe
        -- Pipeline
        pipe_control_signal => pipe_control_signal, -- OUT, to pipe     
        -- PM 
        pm_jmp_stall => map_pm_jmp_stall,
        pm_write_enable => map_pm_write_enable,
        -- RegisterFile control SIGNALS
        rf_read_d_or_b_control_signal => map_rf_read_d_or_b_control_signal, -- OUT, to register file
        rf_write_d_control_signal => map_rf_write_d_control_signal, -- OUT, to register file
        -- DataForwarding        
        df_a_select => map_df_a_select, -- OUT, to data forwarding
        df_b_select => map_df_b_select, -- OUT, to data forwarding    
        df_alu_imm_or_b => map_df_alu_imm_or_b, -- OUT, to data forwarding
        df_ar_a_or_b => map_df_ar_a_or_b, -- OUT, to data forwarding      
        -- ALU control signals  
        alu_update_flags_control_signal => map_update_flags_control_signal, -- OUT, to ALU
        alu_data_size_control_signal => map_data_size_control_signal, -- OUT, to ALU
        alu_op_control_signal => map_alu_op_control_signal, -- OUT, to ALU
        -- KEYBOARD
        kb_read_control_signal => map_kb_read_signal, -- OUT, to keyboard
        -- DataMemory
        dm_write_or_read_control_signal => map_dm_write_or_read_control_signal, -- OUT, to data memory
        dm_size_mode_control_signal => map_dm_size_mode_control_signal, -- OUT, to data memory
        -- VideoMemory
        vm_write_enable_control_signal => map_vm_write_enable_control_signal, -- OUT, to video memory
        -- WriteBackLogic
        wb3_in_or_alu3 => map_wb3_in_or_alu3, -- OUT, to write back logic
        wb4_dm_or_alu4 => map_wb4_dm_or_alu4,
        led_write_control_signal => map_led_write

  );

  ----------- ALU ------------
  U_ALU : ALU
  port map (
      clk => clk,                                                     -- IN, from pipe
      rst => rst,                                                     -- IN, from pipe
      update_flags_control_signal => map_update_flags_control_signal, -- IN, from control unit
      data_size_control_signal => map_data_size_control_signal,       -- IN, from control unit
      alu_op_control_signal => map_alu_op_control_signal,             -- IN, from contorl unit
      alu_a => map_df_a_out,                                          -- IN, from data forwarding
      alu_b => map_df_b_out,                                          -- IN, from data forwarding

      alu_res => map_alu_res,                                         -- OUT, to writebacklogic and data/program/video memory
      Z_flag => map_Z_flag,                                           -- OUT, to control unit
      N_flag => map_N_flag,                                           -- OUT, to control unit
      O_flag => map_O_flag,                                           -- OUT, to control unit
      C_flag => map_C_flag                                            -- OUT, to control unit
  );

  ----------- DATA FORWARDING ------------
  U_DF : DataForwarding 
  port map (
      clk => clk, -- IN, from pipe
			rst => rst, -- IN, from pipe
      A2 => map_rf_out_A2, -- IN, from register file
      B2 => map_rf_out_B2, -- IN, from register file
      D3 => map_wb_out_3, -- IN, from write back logic
      D4 => map_wb_out_4, -- IN, from write back logic
      IMM2 => pipe_IR2_IMM, -- IN, from pipe
      df_a_select => map_df_a_select, -- IN, from control unit
      df_b_select => map_df_b_select, -- IN, from control unit    
      df_alu_imm_or_b => map_df_alu_imm_or_b, -- IN, from control unit
      df_ar_a_or_b => map_df_ar_a_or_b, -- IN, from control unit

      ALU_a_out => map_df_a_out, -- OUT, to ALU
      ALU_b_out => map_df_b_out, -- OUT, to ALU
      AR3_out => map_mem_address -- OUT, to program memory, data memory, video memory
  );

  ----------- DATA MEMORY ---------------
  U_DM : DataMemory
  port map (
      clk => clk, -- IN, from pipe
      rst => rst, -- IN, from pipe
      address => map_mem_address, -- IN, from data forwarding
      write_or_read => map_dm_write_or_read_control_signal, -- IN, from control unit
      size_mode  => map_dm_size_mode_control_signal, -- IN, from control unit
      write_data => map_alu_res, -- IN, write data from ALU

      read_data  => map_dm_read_data_out -- OUT, to write back logic
  );

  ------------ PROGRAM MEMORY ---------------
  U_PM : ProgramMemory  
  port map (
        clk => clk, -- IN, from pipe
        rst => rst, -- IN, from pipe

        pm_jmp_stall => map_pm_jmp_stall,
        pm_write_enable => map_pm_write_enable,

        pm_jmp_offs_imm => pipe_IR1_IMM, -- IN, from pipe pipe_IR1 immediate
        pm_jmp_offs_reg => map_df_a_out(15 downto 0), -- IN, from dataforwarding
        pm_write_data => map_alu_res, -- IN, write data from ALU
        pm_write_address => map_mem_address, -- IN, from data forwarding

        pm_counter => map_pm_counter, -- OUT, NOT USED CURRENTLY!!!
        pm_out => pm_out -- OUT, to pipe
  );

  ------------- REGISTER FILE ---------------
  U_RF : RegisterFile
  port map (
        clk => clk, -- IN, from pipe
        rst => rst, -- IN, from pipe

        read_addr_a => pipe_IR1_rA, -- IN, from pipe pipe
        read_addr_b => pipe_IR1_rB, -- IN, from pipe pipe
				read_addr_d => pipe_IR1_rD, -- IN, from pipe pipe

				read_d_or_b_control_signal => map_rf_read_d_or_b_control_signal, -- IN, from ControlUnit

        write_d_control_signal => map_rf_write_d_control_signal, -- IN, from ControlUnit
        write_addr_d => pipe_IR4_rD, -- IN, from pipe pipe_IR4
        write_data_d => map_wb_out_4, -- IN, from WriteBackLogic

        out_A2 => map_rf_out_A2, -- OUT, to DataForwarding
        out_B2 => map_rf_out_B2  -- OUT, to DataForwarding
   );

  ------------- VIDEO MEMORY ---------------
  U_VMEM: VideoMemory 
  port map (
     clk => clk,                                           -- IN, from pipe
     rst => rst,                                           -- IN, from pipe
     write_address => map_mem_address,                     -- IN, from data forwarding
     write_data => map_alu_res(15 downto 0),               -- IN, write data from ALU res
     write_enable => map_vm_write_enable_control_signal,   -- IN, from control unit

     read_address => map_vga_address,                      -- IN, from VGA

     char => map_vga_char,                                 -- OUT, to VGA
     fg_color => map_vga_fg_color,                         -- OUT, to VGA
     bg_color => map_vga_bg_color                          -- OUT, to VGA
  );
  
  ------------ WRITE BACK LOGIC ---------------
  U_WB : WriteBackLogic
  port map (
        clk => clk, -- IN, from pipe
        rst => rst, -- IN, from pipe

        alu_res => map_alu_res, -- IN, from ALU
        dm_out => map_dm_read_data_out, -- IN, from DataMemory 
        keyboard_out => map_kb_out, -- IN, from keyboard 

        wb3_in_or_alu3 => map_wb3_in_or_alu3, -- OUT, to write back logic
        wb4_dm_or_alu4 => map_wb4_dm_or_alu4,

        write_back_out_3 => map_wb_out_3, -- OUT, to data forwarding
        write_back_out_4 => map_wb_out_4 -- OUT, to data forwarding and register file (for write back)
  );

  ---------- EXTERNAL MAPPINGS -------------

  ----------- VGA ------------
   U_VGA : VGA_Engine 
   port map (
      -- INTERNAL
      clk => clk,                        -- IN, from pipe
      rst => rst,                        -- IN, from pipe
      char => map_vga_char,              -- IN, from video memory
      fg_color => map_vga_fg_color,      -- IN, from video memory
      bg_color => map_vga_bg_color,      -- IN, from video memory
      addr => map_vga_address,           -- OUT, to video memory
      -- EXTERNAL
      vga_r => vga_r,                    -- OUT, from pipe
      vga_g => vga_g,                    -- OUT, from pipe
      vga_b => vga_b,                    -- OUT, from pipe
      h_sync => h_sync,                  -- OUT, from pipe
      v_sync => v_sync                   -- OUT, from pipe
   );

  ------ KEYBOARD DECODER ------
  U_KD : KeyboardDecoder
  port map ( 
        clk => clk, -- IN, from pipe
        rst => rst, -- IN, from pipe
        PS2KeyboardCLK => PS2KeyboardCLK, -- IN, from pipe
        PS2KeyboardData	=> PS2KeyboardData, -- IN, from pipe

        read_signal => map_kb_read_signal, -- IN, from control unit

        out_register => map_kb_out -- OUT, to write back logic
  );
  
  ----------- DEBUGGING 7-seg -----------------
  led: leddriver port map (
      clk => clk, 
      rst => rst, 
      seg => seg,
      an => an,
      value => map_led_value,
      write_enable => map_led_write
);

  
  -------------------------- INTERNAL LOGIC ----------------------------;


  -- Data stall / jump mux logic
  with pipe_control_signal select
  pipe_IR1_next <= NOP_REG when PIPE_JMP,
                   pipe_IR1 when PIPE_STALL,
                   pm_out when PIPE_NORMAl;
    

  with pipe_control_signal select
  pipe_IR2_next <= NOP_REG when PIPE_STALL,
                   pipe_IR1 when others;
  

  pipe_IR3_next <= pipe_IR2;


  pipe_IR4_next <= pipe_IR3;
  keyboard_display_value <= map_kb_out(15 downto 0);
  map_led_value <= map_df_a_out(15 downto 0);

  -- Update registers on clock cycle
  process(clk)
  begin
    if rising_edge(clk) then 
      if rst = '1' then 
        pipe_IR1 <= NOP_REG;
        pipe_IR2 <= NOP_REG;
        pipe_IR3 <= NOP_REG;
        pipe_IR4 <= NOP_REG;
      else
        pipe_IR1 <= pipe_IR1_next;
        pipe_IR2 <= pipe_IR2_next;
        pipe_IR3 <= pipe_IR3_next;
        pipe_IR4 <= pipe_IR4_next;
      end if;
    end if;
  end process;

------------------------------------ END ---------------------------------

end architecture;    

