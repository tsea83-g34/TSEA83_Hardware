-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY DataForwarding_tb IS
end DataForwarding_tb;

architecture behavior OF DataForwarding_tb IS 

  component DataForwarding
    PORT(
      clk : in std_logic;
      IMM1: in unsigned(31 downto 0);
      A2: in unsigned(31 downto 0);       
      B2: in unsigned(31 downto 0);
      D3: in unsigned(31 downto 0);
      D4: in unsigned(31 downto 0);
      control_signal: in unsigned(5 downto 0);
      ALU_a_out: out unsigned(31 downto 0);      
      ALU_b_out: out unsigned(31 downto 0);
      AR_out: out unsigned(31 downto 0)
      );
  end component;

  signal clk : std_logic := '0';
  signal IMM1: unsigned(0 to 31) := "11001001100101100110010001011001";
  signal B2: unsigned(0 to 31) := (others => '0');
  signal A2: unsigned(0 to 31) := "11111111100101100110010001011001";
  signal D3: unsigned(0 to 31) := (others => '0');
  signal D4: unsigned(0 to 31) := (others => '0');
  signal control_signal: unsigned(5 downto 0) := "010000";
  -- alla bitar för 1234
  signal ALU_a: unsigned(0 to 31);
  signal ALU_b: unsigned(0 to 31);
  signal AR_out: unsigned(0 to 31);
  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: DataForwarding PORT MAP(
    clk => clk,
    A2 => A2,
    B2 => B2,
    D3 => D3,
    D4 => D4,
    IMM1 => IMM1,
    control_signal => control_signal,
    ALU_a_out => ALU_a,
    ALU_b_out => ALU_b,
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

  

  stimuli_generator : process
    variable i : integer;
  begin
    -- Aktivera reset ett litet tag.
    D3 <= D3 + 333;
    D4 <= D4 + 444;
    wait for 500 ns;

    wait until rising_edge(clk);        -- se till att reset släpps synkront
                                        -- med klockan
    wait for 1 us;
    
    for i in 0 to 39 loop
      IMM1 <= IMM1 + 1;
      wait for 8.68 us;
      control_signal <= "100000";
    end loop;  -- i
    
    for i in 0 to 50000000 loop         -- Vänta ett antal klockcykler
      wait until rising_edge(clk);
    end loop;  -- i
    
    tb_running <= false;                -- Stanna klockan (vilket medför att inga
                                        -- nya event genereras vilket stannar
                                        -- simuleringen).
    wait;
  end process;
      
end;
