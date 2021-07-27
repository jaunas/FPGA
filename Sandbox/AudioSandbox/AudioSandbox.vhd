library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity AudioSandbox is
    port(
        clk:     in  STD_LOGIC;
        audio_l: out STD_LOGIC;
        audio_r: out STD_LOGIC
    );
end AudioSandbox;

architecture Behavioral of AudioSandbox is
    signal q_reg, q_next: STD_LOGIC_VECTOR(20 downto 0);
    signal audio: std_logic;
begin
    
    process(clk)
    begin
        if rising_edge(clk)
        then
            q_reg <= q_next;
        end if;
    end process;
    
    q_next <= std_logic_vector(unsigned(q_reg) + 1);
    
    audio <= q_reg(14);
    
    audio_l <= audio;
    audio_r <= audio;

end Behavioral;
