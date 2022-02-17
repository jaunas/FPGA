library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Stopwatch is
    port(
        clk         : in  std_logic;
        go, clr, up : in  std_logic;
        d2, d1, d0  : out std_logic_vector(3 downto 0)
    );
end Stopwatch;

architecture Behavioral of Stopwatch is
    constant DVSR: integer := 12000000-1;
    signal s_reg, s_next: unsigned(23 downto 0);
    signal d2_reg, d1_reg, d0_reg: unsigned(3 downto 0);
    signal d2_next, d1_next, d0_next: unsigned(3 downto 0);
    signal d2_en, d1_en, d0_en: std_logic;
    signal s_tick, d1_tick, d0_tick: std_logic;
begin

    process(clk)
    begin
        if rising_edge(clk) then
            s_reg <= s_next;
            d2_reg <= d2_next;
            d1_reg <= d1_next;
            d0_reg <= d0_next;
        end if;
    end process;
    
    -- next-state logic

    -- 1 s tick generator: mod-12000000
    s_next <=
        (others => '0') when clr = '1' or (s_reg = DVSR and go = '1') else
        s_reg + 1       when go = '1' else
        s_reg;
    s_tick <=
        '1' when s_reg = DVSR else
        '0';
    
    -- 1 s counter
    d0_en <=
        '1' when s_tick = '1' else
        '0';
    d0_next <=
        "0000"     when (clr = '1') or (d0_en = '1' and d0_reg = 9 and up = '1') else
        "1001"     when d0_en = '1' and d0_reg = 0 and up = '0' else
        d0_reg + 1 when d0_en = '1' and up = '1' else
        d0_reg - 1 when d0_en = '1' and up = '0' else
        d0_reg;
    d0_tick <=
        '1' when (d0_reg = 9 and up = '1') or (d0_reg = 0 and up = '0') else
        '0';
    
    -- 10 s counter
    d1_en <=
        '1' when s_tick = '1' and d0_tick = '1' else
        '0';
    d1_next <=
        "0000"     when clr = '1' or (d1_en = '1' and d1_reg = 5 and up = '1') else
        "0101"     when d1_en = '1' and d1_reg = 0 and up = '0' else
        d1_reg + 1 when d1_en = '1' and up = '1' else
        d1_reg - 1 when d1_en = '1' and up = '0' else
        d1_reg;
    d1_tick <=
        '1' when (d1_reg = 5 and up = '1') or (d1_reg = 0 and up = '0') else
        '0';
    
    -- 1 min counter
    d2_en <=
        '1' when s_tick = '1' and d0_tick = '1' and d1_tick = '1' else
        '0';
    d2_next <=
        "0000"     when clr = '1' or (d2_en = '1' and d2_reg = 9 and up = '1') else
        "1001"     when d2_en = '1' and d2_reg = 0 and up = '0' else
        d2_reg + 1 when d2_en = '1' and up = '1' else
        d2_reg - 1 when d2_en = '1' and up = '0' else
        d2_reg;
    
    -- output logic
    d0 <= std_logic_vector(d0_reg);
    d1 <= std_logic_vector(d1_reg);
    d2 <= std_logic_vector(d2_reg);

end Behavioral;






















