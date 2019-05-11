library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.PIPECPU_STD.ALL;


entity ProgramMemory_tb is 
end ProgramMemory_tb;

architecture behavior of ProgramMemory_tb is 

  component ProgramMemory
    port(
      clk : in std_logic;
      rst : in std_logic;
      pm_jmp_stall : in pm_jmp_stall_enum;
      pm_write_enable : in pm_write_enum;
      pm_jump_offset : in unsigned(15 downto 0);
      pm_write_data : in unsigned(31 downto 0);
      pm_write_address : in unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
      pm_counter : buffer unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
      pm_out : out unsigned(31 downto 0)
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal pm_jmp_stall : pm_jmp_stall_enum;
  signal pm_write_enable : pm_write_enum;
  signal pm_jump_offset : unsigned(15 downto 0);
  signal pm_write_data : unsigned(31 downto 0);
  signal pm_write_address : unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
  signal pm_counter : unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
  signal pm_out : unsigned(31 downto 0);

  signal tb_running: boolean := true;



  
  
  
begin

  -- Component Instantiation
  uut: ProgramMemory port map(
    clk => clk,
    rst => rst,
    pm_jmp_stall => pm_jmp_stall,
    pm_write_enable => pm_write_enable,
    pm_jump_offset => pm_jump_offset,
    pm_write_data => pm_write_data,
    pm_write_address => pm_write_address,
    pm_counter => pm_counter,
    pm_out => pm_out
  );

  clk_gen : process
  begin
    while tb_running loop
      clk <= '0';
      wait for 5 ns;
      clk <= '1';
      wait for 5 ns;
    end loop;
    wait;
  end process;

  

  process
  begin


    ------ Format of a test case -------

    wait until rising_edge(clk); -- Lag
    assert(pm_out = X"0000_0000" and pm_counter = X"0000") report "Value 0 is not at addr 0" severity error; -- PC -> 1

    pm_jmp_stall <= PM_STALL;
    pm_write_enable <= PM_NO_WRITE;
    pm_write_data <= X"0000_0020";
    pm_write_address <= X"0001";
    wait until rising_edge(clk);

    assert (
      (pm_out = X"0000_0001") and (pm_counter = X"0001")
    )
    report "Failed (Counter tracking and fetch addr 1 = 1). Expected output: pm_out = 1, pm_counter = 1"
    severity error; -- PC -> 2


    -- The offset here should maybe be 0. 
    -- Because we read from address 1, and then jump back to address 1.
    -- So probably add PC <= PC + offset - 1; In program memory
    -- Or maybe this is up to the control signal unit.
    pm_jmp_stall <= PM_JMP;
    pm_write_enable <= PM_NO_WRITE;
    pm_jump_offset <= X"FFFF"; -- (-1) 
    wait until rising_edge(clk);

    assert (
     pm_out = X"0000_0002" and pm_counter = X"0002"
    )
    report "Failed (Made jmp to 1 and read from 2). Expected out: 0x02" -- PC -> 2
    severity error;
    
    pm_jmp_stall <= PM_NORMAL;
    pm_write_enable <= PM_NO_WRITE;
    wait until rising_edge(clk);
    assert (pm_counter = X"0001" and pm_out = X"0000_0020") report "Failed to read correct from addr: 1 after jump" severity error;
    
    wait until rising_edge(clk);
    assert(pm_counter = X"0002") report "Failed to increment after jump" severity error;

    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
