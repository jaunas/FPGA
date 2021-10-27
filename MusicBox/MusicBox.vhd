library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity MusicBox is
    port(
        clk, reset       : in  STD_LOGIC;
        keys             : in  STD_LOGIC_VECTOR (5 downto 0);
        offset           : in  STD_LOGIC_VECTOR(2 downto 0);
        audio_l, audio_r : out STD_LOGIC
    );
end MusicBox;

architecture Behavioral of MusicBox is
    signal c_wave, d_wave, e_wave, f_wave, g_wave, a_wave: std_logic;
    signal wave: std_logic;
begin
    -- 12 MHz => 1 tick = 83.(3) ns
    
    c_generator: entity work.square_wave
        generic map(FREQ => 2093, REG_SIZE => 21)
        port map (
            clk => clk,
            reset => reset,
            offset => offset,
            output => c_wave
        );
        
    d_generator: entity work.square_wave
        generic map(FREQ => 2349, REG_SIZE => 21)
        port map (
            clk => clk,
            reset => reset,
            offset => offset,
            output => d_wave
        );
    
    e_generator: entity work.square_wave
        generic map(FREQ => 2637, REG_SIZE => 21)
        port map (
            clk => clk,
            reset => reset,
            offset => offset,
            output => e_wave
        );
    
    f_generator: entity work.square_wave
        generic map(FREQ => 2794, REG_SIZE => 21)
        port map (
            clk => clk,
            reset => reset,
            offset => offset,
            output => f_wave
        );
    g_generator: entity work.square_wave
        generic map(FREQ => 3136, REG_SIZE => 20)
        port map (
            clk => clk,
            reset => reset,
            offset => offset,
            output => g_wave
        );
    
    a_generator: entity work.square_wave
        generic map(FREQ => 3520, REG_SIZE => 20)
        port map (
            clk => clk,
            reset => reset,
            offset => offset,
            output => a_wave
        );

    -- Output
    wave <=
        (c_wave and keys(0)) or
        (d_wave and keys(1)) or
        (e_wave and keys(2)) or
        (f_wave and keys(3)) or
        (g_wave and keys(4)) or
        (a_wave and keys(5));
    
    audio_l <= wave;
    audio_r <= wave;

end Behavioral;
