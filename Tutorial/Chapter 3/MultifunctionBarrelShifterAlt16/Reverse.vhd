library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reverse is
    port(
        a: in STD_LOGIC_VECTOR (15 downto 0);
        y: out STD_LOGIC_VECTOR (15 downto 0)
    );
end Reverse;

architecture Behavioral of Reverse is
begin
    y(0)  <= a(15);
    y(1)  <= a(14);
    y(2)  <= a(13);
    y(3)  <= a(12);
    y(4)  <= a(11);
    y(5)  <= a(10);
    y(6)  <= a(9);
    y(7)  <= a(8);
    y(8)  <= a(7);
    y(9)  <= a(6);
    y(10) <= a(5);
    y(11) <= a(4);
    y(12) <= a(3);
    y(13) <= a(2);
    y(14) <= a(1);
    y(15) <= a(0);
end Behavioral;

