library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
    port(
        clk, reset : in  std_logic;
        inc, dec   : in  std_logic;
        count      : out std_logic_vector(7 downto 0)
    );
end counter;

architecture Behavioral of counter is
    signal count_reg, count_next: unsigned(7 downto 0);
begin

    -- register
    process(clk, reset)
    begin
        if reset = '1' then
            count_reg <= (others => '0');
        elsif rising_edge(clk) then
            count_reg <= count_next;
        end if;
    end process;
    
    -- next-state logic
    count_next <=
        count_reg + 1 when inc = '1' else
        count_reg - 1 when dec = '1' else
        count_reg;
    
    -- output
    count <= std_logic_vector(count_reg);

end Behavioral;

