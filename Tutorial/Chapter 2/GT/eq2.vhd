library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eq2 is
    port(
        a, b: in std_logic_vector(1 downto 0);
        eq: out std_logic
    );
end eq2;

architecture Behavioral of eq2 is
    signal eq0, eq1: std_logic;
begin
    eq_bit0_unit: entity work.eq1
        port map(a => a(0), b => b(0), eq => eq0);
    eq_bit1_unit: entity work.eq1
        port map(a => a(1), b => b(1), eq => eq1);
    
    eq <= eq0 and eq1;
end Behavioral;
