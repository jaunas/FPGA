library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reverse is
    port(
        a: in STD_LOGIC_VECTOR (7 downto 0);
        y: out STD_LOGIC_VECTOR (7 downto 0)
    );
end Reverse;

architecture Behavioral of Reverse is
begin
    y(0) <= a(7);
    y(1) <= a(6);
    y(2) <= a(5);
    y(3) <= a(4);
    y(4) <= a(3);
    y(5) <= a(2);
    y(6) <= a(1);
    y(7) <= a(0);
end Behavioral;

