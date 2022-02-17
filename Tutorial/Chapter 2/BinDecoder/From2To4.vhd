library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity From2To4 is
    port(
        enable: in std_logic;
        from2: in std_logic_vector(1 downto 0);
        to4: out std_logic_vector(3 downto 0)
    );
end From2To4;

architecture Behavioral of From2To4 is

begin
    to4(0) <= (not from2(0)) and (not from2(1)) and enable;
    to4(1) <= from2(0) and (not from2(1)) and enable;
    to4(2) <= (not from2(0)) and from2(1) and enable;
    to4(3) <= from2(0) and from2(1) and enable;
end Behavioral;

