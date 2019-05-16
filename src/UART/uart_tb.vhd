-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY uar_tb IS
END uar_tb;

ARCHITECTURE behavior OF uar_tb IS 

  -- Component Declaration
  COMPONENT uart
    PORT(
      clk,rst,rx : IN std_logic
      );
  END COMPONENT;

  SIGNAL clk : std_logic := '0';
  SIGNAL rst : std_logic := '0';
  signal rx : std_logic := '1';
  SIGNAL tb_running : boolean := true;
  -- alla bitar för 1234
  type uart_array is array (natural range<>) of unsigned(0 to 9);
  constant uart_signals : uart_array := (
    "0" & X"FE" & "1",
    "0" & X"DC" & "1",
    "0" & X"BA" & "1",
    "0" & X"98" & "1",

    "0" & X"AE" & "1",
    "0" & X"DC" & "1",
    "0" & X"BA" & "1",
    "0" & X"98" & "1",

    "0" & X"BE" & "1",
    "0" & X"DC" & "1",
    "0" & X"BA" & "1",
    "0" & X"98" & "1",
   
    "0" & X"0E" & "1",
    "0" & X"DC" & "1",
    "0" & X"BA" & "1",
    "0" & X"98" & "1",



    "0" & X"00" & "1",
    "0" & X"DC" & "1",
    "0" & X"5A" & "1",
    "0" & X"98" & "1",

    "0" & X"50" & "1",
    "0" & X"DC" & "1",
    "0" & X"BA" & "1",
    "0" & X"18" & "1",

    "0" & X"E0" & "1",
    "0" & X"1C" & "1",
    "0" & X"BA" & "1",
    "0" & X"28" & "1",

    "0" & X"E0" & "1",
    "0" & X"4C" & "1",
    "0" & X"88" & "1",
    "0" & X"88" & "1"
  );
BEGIN

  -- Component Instantiation
  uut: uart PORT MAP(
    clk => clk,
    rst => rst,
    rx => rx
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
