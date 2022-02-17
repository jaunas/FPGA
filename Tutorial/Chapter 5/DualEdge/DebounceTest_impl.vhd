library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DebounceTest_impl is
    port(
        Clk : in  STD_LOGIC;
        Switch : in  STD_LOGIC_VECTOR (1 downto 0);
        Enable : out  STD_LOGIC_VECTOR (2 downto 0);
        SevenSegment : out  STD_LOGIC_VECTOR (7 downto 0)
    );
end DebounceTest_impl;

architecture Behavioral of DebounceTest_impl is

begin

    debounce: entity work.DebounceTest
    port map(
        clk => Clk,
        btn => not Switch,
        an => Enable,
        sseg => SevenSegment
    );

end Behavioral;

