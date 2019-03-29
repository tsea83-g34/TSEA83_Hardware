library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_unit is
  port (
        clk : in std_logic;
        rst : in std_logic;

        IR1 : in unsigned(31 downto 0);
        IR2 : in unsigned(31 downto 0);
        IR3 : in unsigned(31 downto 0);
        IR4 : in unsigned(31 downto 0);

        pm_control_signal : out unsigned(1 downto 0);
        pipe_control_signal : out unsigned(1 downto 0);
        alu_control_signal : out unsigned(3 downto 0);
        dataforwarding_control_signal : out unsigned(1 downto 0);
        dm_control_signal : out std_logic;
  );
end control_unit;

architecture Behavioral of control_unit is 

alias IR2_op = unsigned(5 downto 0) is IR2(31 downto 26); 
alias IR2_a = unsigned(4 downto 0) is IR2(20 downto 16); 
alias IR2_b = unsigned(4 downto 0) is IR2(15 downto 11); 
alias IR3_d = unsigned(4 downto 0) is IR3(25 downto 21);
alias IR4_d = unsigned(4 downto 0) is IR4(25 downto 21);


end Behavioral
