-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY lab_tb IS
END lab_tb;

ARCHITECTURE behavior OF lab_tb IS 

  -- Component Declaration
  COMPONENT lab
    PORT(
      clk,rst,rx : IN std_logic;
      seg: OUT unsigned(7 downto 0);       
      an : OUT unsigned(3 downto 0)
      );
  END COMPONENT;

  SIGNAL clk : std_logic := '0';
  SIGNAL rst : std_logic := '0';
  signal rx : std_logic := '1';
  SIGNAL seg : unsigned(7 downto 0);
  SIGNAL an :  unsigned(3 downto 0);
  SIGNAL tb_running : boolean := true;
  -- alla bitar för 1234
  SIGNAL rxs :  unsigned(0 to 39) := "0100011001001001100101100110010001011001";
BEGIN

  -- Component Instantiation
  uut: lab PORT MAP(
    clk => clk,
    rst => rst,
    rx => rx,
    seg => seg,
    an => an);


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
    rst <= '1';
    wait for 500 ns;

    wait until rising_edge(clk);        -- se till att reset släpps synkront
                                        -- med klockan
    rst <= '0';
    report "Reset released" severity note;
    wait for 1 us;
    
    for i in 0 to 39 loop
      rx <= rxs(i);
      wait for 8.68 us;
    end loop;  -- i
    
    for i in 0 to 50000000 loop         -- Vänta ett antal klockcykler
      wait until rising_edge(clk);
    end loop;  -- i
    
    tb_running <= false;                -- Stanna klockan (vilket medför att inga
                                        -- nya event genereras vilket stannar
                                        -- simuleringen).
    wait;
  end process;
      
END;
