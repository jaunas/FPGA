library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PriorityEncoder is
    port(
        req: in STD_LOGIC_VECTOR (12 downto 1);
        code: out STD_LOGIC_VECTOR (3 downto 0)
    );
end PriorityEncoder;

architecture Behavioral of PriorityEncoder is
begin
    code <= "1100" when (req(12) = '1') else
            "1011" when (req(11) = '1') else
            "1010" when (req(10) = '1') else
            "1001" when (req(9)  = '1') else
            "1000" when (req(8)  = '1') else
            "0111" when (req(7)  = '1') else
            "0110" when (req(6)  = '1') else
            "0101" when (req(5)  = '1') else
            "0100" when (req(4)  = '1') else
            "0011" when (req(3)  = '1') else
            "0010" when (req(2)  = '1') else
            "0001" when (req(1)  = '1') else
            "0000";
end Behavioral;
