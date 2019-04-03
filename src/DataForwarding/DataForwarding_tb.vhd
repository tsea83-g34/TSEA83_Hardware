-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataForwarding_tb is 
end DataForwarding_tb;

architecture behavior of DataForwarding_tb is 

  component data_forwarding
    port(
      clk : in std_logic;
      A2 : in unsigned(31 downto 0);
      B2 : in unsigned(31 downto 0);
      D3 : in unsigned(31 downto 0);
      D4 : in unsigned(31 downto 0);
      IMM1 : in unsigned(31 downto 0);
      control_signal : in unsigned(5 downto 0);
      ALU_a_out : out unsigned(31 downto 0);
      ALU_b_out : out unsigned(31 downto 0);
      AR_out : out unsigned(31 downto 0)
    );
  end component;

  type test_record is record 
    A2 : unsigned(31 downto 0);
    B2 : unsigned(31 downto 0);
    D3 : unsigned(31 downto 0);
    D4 : unsigned(31 downto 0);
    IMM1 : unsigned(31 downto 0);
    control_signal : unsigned(5 downto 0);
    ALU_a_out : unsigned(31 downto 0);
    ALU_b_out : unsigned(31 downto 0);
    AR_out : unsigned(31 downto 0);
  end record; 
  type test_record_array is array(natural range <>) of test_record;
  constant test_records : test_record_array := (
    -- A2, B2, D3, D4, IMM1, control_signal, ALU_a_out, ALU_b_out, AR_out
    (X"1000_0000", X"2000_0000", X"0000_0000", X"0000_0000", X"0000_0000", "0_000_00", X"1000_0000", X"2000_0000", X"0000_0000")
  );

  signal clk : std_logic;
  signal A2 : unsigned(31 downto 0);
  signal B2 : unsigned(31 downto 0);
  signal D3 : unsigned(31 downto 0);
  signal D4 : unsigned(31 downto 0);
  signal IMM1 : unsigned(31 downto 0);
  signal control_signal : unsigned(5 downto 0);
  signal ALU_a_out : unsigned(31 downto 0);
  signal ALU_b_out : unsigned(31 downto 0);
  signal AR_out : unsigned(31 downto 0);

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: data_forwarding port map(
    clk => clk,
    A2 => A2,
    B2 => B2,
    D3 => D3,
    D4 => D4,
    IMM1 => IMM1,
    control_signal => control_signal,
    ALU_a_out => ALU_a_out,
    ALU_b_out => ALU_b_out,
    AR_out => AR_out
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
    for i in test_records'range loop 
      A2 <= test_records(i).A2
      B2 <= test_records(i).B2
      D3 <= test_records(i).D3
      D4 <= test_records(i).D4
      IMM1 <= test_records(i).IMM1
      control_signal <= test_records(i).control_signal
      
      wait until rising_edge(clk);
      assert (
        (ALU_a_out = test_records(i).ALU_a_out) and (ALU_b_out = test_records(i).ALU_b_out) and (AR_out = test_records(i).AR_out)
      )
      report "Failed test " & integer'image(i) & "failed." severity error;
    end loop;
    -- Insert test here, and add more if you want 
    wait until rising_edge(clk);
    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
