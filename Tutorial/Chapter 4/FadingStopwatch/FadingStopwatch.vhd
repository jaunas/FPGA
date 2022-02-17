library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FadingStopwatch is
    port(
        Clk          : in  std_logic;
        Switch       : in  std_logic_vector(1 downto 0);
        SevenSegment : out std_logic_vector(7 downto 0);
        Enable       : out std_logic_vector(2 downto 0));
end FadingStopwatch;

architecture Behavioral of FadingStopwatch is
    signal d2, d1, d0: std_logic_vector(3 downto 0);
    signal wave: std_logic;
    signal an: std_logic_vector(2 downto 0);
    signal w: std_logic_vector(3 downto 0);
begin

    stopwatch: entity work.Stopwatch
    port map(
        clk => Clk,
        go => not Switch(0),
        clr => not Switch(1),
        d2 => d2,
        d1 => d1,
        d0 => d0
    );
    
    hex_display: entity work.HexDisplay
    port map(
        clk => Clk,
        hex2 => d2,
        hex1 => d1,
        hex0 => d0,
        dp_in => "111",
        an => an,
        sseg => SevenSegment
    );
    
    Enable <= an when wave = '1' else "111";
    w <= std_logic_vector(unsigned(d0) + 2);
    
    pwm: entity work.PWM
    port map(
        clk => Clk,
        reset => '0',
        w => w,
        wave => wave
    );

end Behavioral;

