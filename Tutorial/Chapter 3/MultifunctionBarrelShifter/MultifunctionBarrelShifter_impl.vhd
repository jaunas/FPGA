library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MultifunctionBarrelShifter_impl is
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           amt : in  STD_LOGIC_VECTOR (2 downto 0);
           lr : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR (7 downto 0));
end MultifunctionBarrelShifter_impl;

architecture Behavioral of MultifunctionBarrelShifter_impl is
begin
    shifter: entity work.MultifunctionBarrelShifter port map(
        a => not a,
        amt => not amt,
        lr => not lr,
        y => y
    );
end Behavioral;

