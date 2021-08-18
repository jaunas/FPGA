library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MusicBox_impl is
    port(
        clk              : in  STD_LOGIC;
        btn              : in  STD_LOGIC_VECTOR (5 downto 0);
        audio_l, audio_r : out STD_LOGIC;
        logic            : out std_logic
    );
end MusicBox_impl;

architecture Behavioral of MusicBox_impl is
    signal audio: std_logic;
begin

    music_box: entity work.MusicBox
    port map(
        clk => clk,
        reset => '0',
        keys => not btn,
        audio_l => audio,
        audio_r => audio_r
    );
    
    audio_l <= audio;
    logic <= audio;

end Behavioral;
