library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DebounceTest_impl is
    port(
        Clk               : in  std_logic;
        Reset             : in  std_logic;
        Switch            : in  std_logic;
        Enable            : out std_logic_vector(3 downto 0);
        SevenSegment      : out std_logic_vector(7 downto 0);
        SevenSegmentPoint : out std_logic
    );
end DebounceTest_impl;

architecture Behavioral of DebounceTest_impl is

begin

    debounce: entity work.DebounceTest
    port map(
        clk => Clk,
        reset => not Reset,
        btn => not Switch,
        an => Enable,
        sseg => SevenSegment
    );
    
    SevenSegmentPoint <= '0';

end Behavioral;

