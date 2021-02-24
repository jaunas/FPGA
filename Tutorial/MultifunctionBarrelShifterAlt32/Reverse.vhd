library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reverse is
    port(
        a: in STD_LOGIC_VECTOR (31 downto 0);
        y: out STD_LOGIC_VECTOR (31 downto 0)
    );
end Reverse;

architecture Behavioral of Reverse is
begin
    y(0)  <= a(31);
    y(1)  <= a(30);
    y(2)  <= a(29);
    y(3)  <= a(28);
    y(4)  <= a(27);
    y(5)  <= a(26);
    y(6)  <= a(25);
    y(7)  <= a(24);
    y(8)  <= a(23);
    y(9)  <= a(22);
    y(10) <= a(21);
    y(11) <= a(20);
    y(12) <= a(19);
    y(13) <= a(18);
    y(14) <= a(17);
    y(15) <= a(16);
    y(16)  <= a(15);
    y(17)  <= a(14);
    y(18)  <= a(13);
    y(19)  <= a(12);
    y(20)  <= a(11);
    y(21)  <= a(10);
    y(22)  <= a(9);
    y(23)  <= a(8);
    y(24)  <= a(7);
    y(25)  <= a(6);
    y(26) <= a(5);
    y(27) <= a(4);
    y(28) <= a(3);
    y(29) <= a(2);
    y(30) <= a(1);
    y(31) <= a(0);
end Behavioral;

