library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Stopwatch is
    port(
        clk        : in  STD_LOGIC;
        go, clr    : in  STD_LOGIC;
        d2, d1, d0 : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Stopwatch;

architecture Behavioral of Stopwatch is
    constant DVSR: integer := 1200000;
    signal ms_reg, ms_next: unsigned(22 downto 0);
    signal d2_reg, d1_reg, d0_reg: unsigned(3 downto 0);
    signal d2_next, d1_next, d0_next: unsigned(3 downto 0);
    signal ms_tick: std_logic;
begin

    process(clk)
    begin
        if rising_edge(clk) then
            ms_reg <= ms_next;
            d2_reg <= d2_next;
            d1_reg <= d1_next;
            d0_reg <= d0_next;
        end if;
    end process;
    
    -- next-state logic
    
    -- 0.1 s tick generator: mod-1,200,000 (12 MHz clock)
    ms_next <=
        (others => '0') when clr = '1' or (ms_reg = DVSR and go = '1') else
        ms_reg + 1 when go = '1' else
        ms_reg;
    ms_tick <= '1' when ms_reg = DVSR else '0';
    
    -- 3 digit incrementor
    process(d0_reg, d1_reg, d2_reg, ms_tick, clr)
    begin
        -- default
        d0_next <= d0_reg;
        d1_next <= d1_reg;
        d2_next <= d2_reg;
        if clr = '1' then
            d0_next <= "0000";
            d1_next <= "0000";
            d2_next <= "0000";
        elsif ms_tick = '1' then
            if d0_reg /= 9 then
                d0_next <= d0_reg + 1;
            else
                d0_next <= "0000";
                if d1_reg /= 9 then
                    d1_next <= d1_reg + 1;
                else
                    d1_next <= "0000";
                    if d2_reg /= 9 then
                        d2_next <= d2_reg + 1;
                    else
                        d2_next <= "0000";
                    end if;
                end if;
            end if;
        end if;
    end process;
    
    -- output logic
    d0 <= std_logic_vector(d0_reg);
    d1 <= std_logic_vector(d1_reg);
    d2 <= std_logic_vector(d2_reg);

end Behavioral;

