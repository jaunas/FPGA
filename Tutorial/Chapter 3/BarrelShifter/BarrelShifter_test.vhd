library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BarrelShifter_test is
    port(
        sw: in STD_LOGIC_VECTOR(7 downto 0);
        btn: in STD_LOGIC_VECTOR(2 downto 0);
        led: out STD_LOGIC_VECTOR(7 downto 0)
    );
end BarrelShifter_test;

architecture Behavioral of BarrelShifter_test is
begin
    shift_unit: entity work.BarrelShifter
        port map(
            a => sw,
            amt => not btn,
            y => led
        );
end Behavioral;

