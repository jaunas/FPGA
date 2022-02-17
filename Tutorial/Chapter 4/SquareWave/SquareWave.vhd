library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Generate square wave with m us on, and n us off
-- 12 MHz => 1 tick = 83.(3) ns => 1 us = 12 ticks

entity SquareWave is
    generic(
        -- Input bits for m and n
        BITS: integer := 4;
        -- Clock ticks for every m or n
        TICKS: integer := 12;
        -- ceil(ln2((2^4 - 1) * TICKS)) - BITS
        EXTRA_BITS: integer := 4
    );
    port(
        clk   : in  std_logic;
        reset : in  std_logic;
        m, n  : in  std_logic_vector(BITS-1 downto 0);
        wave  : out std_logic
    );
end SquareWave;

architecture Behavioral of SquareWave is
    signal m_reg, m_next, m_max: unsigned(BITS + EXTRA_BITS - 1 downto 0);
    signal n_reg, n_next, n_max: unsigned(BITS + EXTRA_BITS - 1 downto 0);
    signal m_tick, n_tick: std_logic;
    -- level_reg=1 => m is running, level_reg=0 => n is running
    signal level_reg, level_next: std_logic;
begin
    -- register
    process(clk, reset)
    begin
        if reset = '1' then
            m_reg <= (others => '0');
            n_reg <= (others => '0');
            level_reg <= '1';
        elsif rising_edge(clk) then
            m_reg <= m_next;
            n_reg <= n_next;
            level_reg <= level_next;
        end if;
    end process;
    
    m_max <= (unsigned(m) * TICKS) - 1;
    n_max <= (unsigned(n) * TICKS) - 1;
    
    -- next-state logic
    m_next <=        -- run when level is 1
        (others => '0') when level_reg = '1' and m_tick = '1' else
        m_reg + 1       when level_reg = '1' else
        m_reg;
    n_next <=        -- run when level is 0
        (others => '0') when level_reg = '0' and n_tick = '1' else
        n_reg + 1       when level_reg = '0' else
        n_reg;
    
    -- next-state logic for level
    level_next <=
        '1' when n_tick = '1' else
        '0' when m_tick = '1' else
        level_reg;
    
    -- ticks
    m_tick <=
        '1' when m_reg >= m_max else
        '0';
    n_tick <=
        '1' when n_reg >= n_max else
        '0';
    
    -- output logic
    wave <= level_reg;

end Behavioral;

