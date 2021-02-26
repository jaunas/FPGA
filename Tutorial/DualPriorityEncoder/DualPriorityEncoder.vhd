library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DualPriorityEncoder is
    port(
        req: in STD_LOGIC_VECTOR (12 downto 0);
        first: out STD_LOGIC_VECTOR (4 downto 0);
        second: out STD_LOGIC_VECTOR (4 downto 0)
    );
end DualPriorityEncoder;

architecture Behavioral of DualPriorityEncoder is

begin
end Behavioral;

