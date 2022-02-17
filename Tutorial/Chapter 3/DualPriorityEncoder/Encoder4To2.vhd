library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Encoder4To2 is
    port(
        req: in STD_LOGIC_VECTOR (3 downto 0);
        first: out STD_LOGIC_VECTOR (1 downto 0);
        second: out STD_LOGIC_VECTOR (1 downto 0)
    );
end Encoder4To2;

architecture Behavioral of Encoder4To2 is
begin
    first(0) <= (req(1) and not req(2)) or req(3);
    first(1) <= req(2) or req(3);
    
    second(0) <= req(1) and (req(2) xor req(3));
    second(1) <= req(2) and req(3);
end Behavioral;

