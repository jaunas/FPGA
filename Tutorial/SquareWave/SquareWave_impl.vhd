library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SquareWave_impl is
    port(
        clk, reset              : in  STD_LOGIC;
        m, n                    : in  STD_LOGIC_VECTOR (3 downto 0);
        audio_l, audio_r, logic : out  STD_LOGIC
    );
end SquareWave_impl;

architecture Behavioral of SquareWave_impl is
    signal wave: std_logic;
    signal m_shifted, n_shifted: std_logic_vector(15 downto 0);
begin

    m_shifted <= (not m) & "000000000000";
    n_shifted <= (not n) & "000000000000";

    square_wave: entity work.SquareWave
    generic map(BITS => 16)
    port map(
        clk => clk,
        reset => not reset,
        m => m_shifted,
        n => n_shifted,
        wave => wave
    );

    audio_l <= wave;
    audio_r <= wave;
    logic <= wave;
end Behavioral;

