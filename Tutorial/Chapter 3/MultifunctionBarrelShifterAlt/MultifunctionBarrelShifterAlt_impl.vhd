library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MultifunctionBarrelShifterAlt_impl is
    port(
        a: in STD_LOGIC_VECTOR (7 downto 0);
        amt: in STD_LOGIC_VECTOR (2 downto 0);
        lr: in STD_LOGIC;
        y: out STD_LOGIC_VECTOR (7 downto 0)
    );
end MultifunctionBarrelShifterAlt_impl;

architecture Behavioral of MultifunctionBarrelShifterAlt_impl is
begin
    shifter: entity work.MultifunctionBarrelShifterAlt port map(
        a => not a,
        amt => not amt,
        lr => not lr,
        y => y
    );
end Behavioral;

