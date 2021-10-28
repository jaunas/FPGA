library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MusicBox_impl is
    port(
        clk              : in  STD_LOGIC;
        btn              : in  STD_LOGIC_VECTOR (5 downto 0);
        switch           : in  STD_LOGIC_VECTOR(5 downto 0);
        audio_l, audio_r : out STD_LOGIC;
        logic            : out STD_LOGIC
    );
end MusicBox_impl;

architecture Behavioral of MusicBox_impl is
    signal audio: std_logic;
    signal keys: std_logic_vector(5 downto 0);
    signal offset, duty: std_logic_vector(2 downto 0);
begin

    keys <= not btn;
    offset <= not switch(2 downto 0);
    duty <= not switch(5 downto 3);

    music_box: entity work.MusicBox
    port map(
        clk => clk,
        reset => '0',
        keys => keys,
        offset => offset,
        duty => duty,
        audio => audio
    );
    
    audio_l <= audio;
    audio_r <= audio;
    logic   <= audio;

end Behavioral;
