-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY uart_tb IS
END uart_tb;

ARCHITECTURE behavior OF uart_tb IS 

  -- Component Declaration
  COMPONENT UART
    PORT(
      clk,rst,rx : IN std_logic;
      out_port : out unsigned(31 downto 0);
      read_signal : in std_logic
     );
  END COMPONENT;

  SIGNAL clk : std_logic := '0';
  SIGNAL rst : std_logic := '0';
  signal rx : std_logic := '1';
  signal out_port : unsigned(31 downto 0);
  signal read_signal : std_logic := '0';
  SIGNAL tb_running : boolean := true;
  -- alla bitar för 1234
  type uart_array is array (natural range<>) of unsigned(0 to 9);
  constant uart_signals : uart_array := (
    "0" & X"FF" & "1",
    "0" & X"ED" & "1",
    "0" & X"CB" & "1",
    "0" & X"A9" & "1",

    "0" & X"12" & "1",
    "0" & X"34" & "1",
    "0" & X"56" & "1",
    "0" & X"78" & "1",

    "0" & X"BE" & "1",
    "0" & X"DC" & "1",
    "0" & X"BA" & "1",
    "0" & X"98" & "1",
    "11" & X"11",
    "11" & X"11",
    "11" & X"11",
    "11" & X"11"

  );
BEGIN

  -- Component Instantiation
  uut: UART PORT MAP(
    clk => clk,
    rst => rst,
    rx => rx,
    out_port => out_port,
    read_signal => read_signal
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
    variable j : integer;
    variable uart_signal : unsigned(0 to 9);
  begin
    -- Aktivera reset ett litet tag.
    rst <= '1';
    wait for 500 ns;

    wait until rising_edge(clk);        -- se till att reset släpps synkront
                                        -- med klockan
    rst <= '0';
    report "Reset released" severity note;
    wait for 1 us;
    
    for i in uart_signals'range loop
        uart_signal := uart_signals(i);
        for j in 0 to 9 loop
          rx <= uart_signal(j);
          wait for 8.68 us;
        end loop;
        wait for 1 us;
        read_signal <= '1';
        wait for 1 us;
        read_signal <= '0';
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
