library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RotatingSquare_impl is
    port(
        Clk          : in  std_logic;
        Switch       : in  std_logic;
        DPSwitch     : in  std_logic;
        SevenSegment : out std_logic_vector(7 downto 0);
        Enable       : out std_logic_vector(2 downto 0));
end RotatingSquare_impl;

architecture Behavioral of RotatingSquare_impl is

begin

    rotating_square: entity work.RotatingSquare
    port map(
        clk => Clk,
        reset => '0',
        en => not Switch,
        cw => not DPSwitch,
        an => Enable,
        sseg => SevenSegment
    );

end Behavioral;

