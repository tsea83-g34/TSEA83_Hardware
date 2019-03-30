-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity $file_name is 
end $file_name;

architecture behavior of $file_name is 

  component $entity_name
    port(
      $ports
    );
  end component;

  type test_record is record 
    A2, B2, D3, D4, IMM1: unsigned(31 downto 0);
    control_signal: unsigned(5 downto 0);
    ALU_a_out, ALU_b_out, AR_out;
  end record; 
  type test_record_array is array(natural range <>) of test_record;
  constant test_records : test_record_array := (
    -- A2, B2, D3, D4, IMM1, control_signal, ALU_a_out, ALU_b_out, AR_out
    (X"2000_0000", X"1000_0000", X"0000_0000", X"0000_0000", X"0000_0000", "1_000_00" , X"0000_0000", X"0000_0000", X"0000_0000") 
  );

  $signals
  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: $entity_name port map(
    $ports_mapping
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
      A2 <= test_records(i).A2;
      B2 <= test_records(i).B2;
      control_signal <= test_records(i).control_signal;
      wait until rising_edge(clk);
      assert (
        (AR_out = test_records(i).AR_out) and (ALU_a_out = test_records(i).ALU_a_out) 
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
