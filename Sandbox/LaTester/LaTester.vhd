library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity LaTester is
    port(
        clk:   in  STD_LOGIC;
        test: out STD_LOGIC_VECTOR(1 downto 0);
        audio_r: out STD_LOGIC
    );
end LaTester;

architecture Behavioral of LaTester is
    signal q_reg, q_next: std_logic_vector(13 downto 0);
begin

    process(clk)
    begin
        if rising_edge(clk) then
            q_reg <= q_next;
        end if;
    end process;
    
    q_next <= std_logic_vector(unsigned(q_reg) + 1);
    test(0) <= q_reg(5);
    test(1) <= q_reg(8);
    audio_r <= q_reg(13);

end Behavioral;
