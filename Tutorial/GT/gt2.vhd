library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity gt2 is
    port(
        a, b: in std_logic_vector(1 downto 0);
        gt: out std_logic
    );
end gt2;

architecture Behavioral of gt2 is
    signal p0, p1, p2: std_logic;
begin
    -- sum of 3 products terms
    gt <= p0 or p1 or p2;
    -- product terms
    p0 <= a(1) and (not b(1));
    p1 <= (not a(1)) and a(0) and (not b(1)) and (not b(0));
    p2 <= a(1) and a(0) and b(1) and (not b(0));
end Behavioral;
