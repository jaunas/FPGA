library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Banner_impl is
    port(
        Clk          : in  std_logic;
        DPSwitch     : in  std_logic_vector(1 downto 0);
        SevenSegment : out std_logic_vector(7 downto 0);
        Enable       : out std_logic_vector(2 downto 0)
    );
end Banner_impl;

architecture Behavioral of Banner_impl is

begin

    banner: entity work.Banner
    port map(
        clk => Clk,
        reset => '0',
        en => not DPSwitch(0),
        dir => not DPSwitch(1),
        an => Enable,
        sseg => SevenSegment
    );

end Behavioral;

