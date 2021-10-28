library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity MusicBox is
    port(
        clk, reset : in  std_logic;
        keys       : in  std_logic_vector(5 downto 0);
        offset     : in  std_logic_vector(2 downto 0);
        duty       : in  std_logic_vector(2 downto 0);
        audio      : out std_logic
    );
end MusicBox;

architecture Behavioral of MusicBox is
    signal c_wave, d_wave, e_wave, f_wave, g_wave, a_wave: std_logic;
begin
    -- 12 MHz => 1 tick = 83.(3) ns
    
    c_generator: entity work.square_wave
        generic map(FREQ => 2093, REG_SIZE => 20)
        port map (
            clk => clk,
            reset => reset,
            offset => offset,
            duty => duty,
            output => c_wave
        );
        
    d_generator: entity work.square_wave
        generic map(FREQ => 2349, REG_SIZE => 20)
        port map (
            clk => clk,
            reset => reset,
            offset => offset,
            duty => duty,
            output => d_wave
        );
    
    e_generator: entity work.square_wave
        generic map(FREQ => 2637, REG_SIZE => 20)
        port map (
            clk => clk,
            reset => reset,
            offset => offset,
            duty => duty,
            output => e_wave
        );
    
    f_generator: entity work.square_wave
        generic map(FREQ => 2794, REG_SIZE => 20)
        port map (
            clk => clk,
            reset => reset,
            offset => offset,
            duty => duty,
            output => f_wave
        );
    g_generator: entity work.square_wave
        generic map(FREQ => 3136, REG_SIZE => 19)
        port map (
            clk => clk,
            reset => reset,
            offset => offset,
            duty => duty,
            output => g_wave
        );
    
    a_generator: entity work.square_wave
        generic map(FREQ => 3520, REG_SIZE => 19)
        port map (
            clk => clk,
            reset => reset,
            offset => offset,
            duty => duty,
            output => a_wave
        );

    -- Output
    audio <=
        (c_wave and keys(0)) or
        (d_wave and keys(1)) or
        (e_wave and keys(2)) or
        (f_wave and keys(3)) or
        (g_wave and keys(4)) or
        (a_wave and keys(5));
    
end Behavioral;
