library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Stopwatch_impl is
    port(
        clk         : in  std_logic;
        btn, sw, up : in  std_logic;
        an          : out std_logic_vector(2 downto 0);
        sseg        : out std_logic_vector(7 downto 0)
    );
end Stopwatch_impl;

architecture Behavioral of Stopwatch_impl is
    signal d2, d1, d0: std_logic_vector(3 downto 0);
begin

    stopwatch: entity work.Stopwatch port map(
        clk => clk,
        go => not sw,
        clr => not btn,
        up => not up,
        d2 => d2,
        d1 => d1,
        d0 => d0
    );
    
    display: entity work.HexDisplay port map(
        clk => clk,
        hex2 => d2,
        hex1 => d1,
        hex0 => d0,
        dp_in => "011",
        an => an,
        sseg => sseg
    );

end Behavioral;
