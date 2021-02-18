library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eq1 is
    port(
        a, b: in std_logic;
        eq: out std_logic
    );
end eq1;

architecture Behavioral of eq1 is
    signal p0, p1: std_logic;
begin
    eq <= p0 or p1;
    p0 <= (not a) and (not b);
    p1 <= a and b;
end Behavioral;

