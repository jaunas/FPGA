library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BrightDisplay is
    port(
        Clk          : in  std_logic;
        DPSwitch     : in  std_logic_vector(3 downto 0);
        SevenSegment : out std_logic_vector(7 downto 0);
        Enable       : out std_logic_vector(2 downto 0)
    );
end BrightDisplay;

architecture Behavioral of BrightDisplay is
    signal wave: std_logic;
    signal an: std_logic_vector(2 downto 0);
begin

    display_mux: entity work.DisplayMux
    port map (
        clk => Clk,
        reset => '0',
        in2 => "10010001",
        in1 => "01100001",
        in0 => "10000111",
        an => an,
        sseg => SevenSegment
    );
    
    Enable <= an when wave = '1' else "111";
    
    pwm: entity work.PWM
    port map (
        clk => Clk,
        reset => '0',
        w => not DPSwitch,
        wave => wave
    );

end Behavioral;

