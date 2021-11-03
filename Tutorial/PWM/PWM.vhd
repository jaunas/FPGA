library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity PWM is
    generic(
        RESOLUTION: integer := 4
    );
    port(
        clk, reset : in  std_logic;
        w          : in  std_logic_vector(RESOLUTION-1 downto 0);
        wave       : out std_logic
    );
end PWM;

architecture Behavioral of PWM is
    signal r_reg, r_next: unsigned(RESOLUTION-1 downto 0);
begin

    -- register
    process(clk, reset)
    begin
        if reset = '1' then
            r_reg <= (others => '0');
        elsif rising_edge(clk) then
            r_reg <= r_next;
        end if;
    end process;
    
    -- next-state logic
    r_next <= r_reg + 1;
    
    -- output
    wave <= '1' when r_reg < unsigned(w) else '0';

end Behavioral;
