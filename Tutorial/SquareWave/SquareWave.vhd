library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- TODO:
-- 1. Make shortest tick to one cycle
-- 2. Fix problem with all switches on

entity SquareWave is
    generic(
        BITS: integer := 4
    );
    port(
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        m, n  : in  STD_LOGIC_VECTOR (BITS-1 downto 0);
        wave  : out STD_LOGIC
    );
end SquareWave;

architecture Behavioral of SquareWave is
    -- We want to start with 1, not 0, so we need +1 size registers
    signal m_reg, m_next: unsigned(BITS downto 0);
    signal n_reg, n_next: unsigned(BITS downto 0);
    signal m_tick, n_tick: std_logic;
    signal level_reg, level_next: std_logic;
begin
    -- 12 MHz => 1 tick = 83.(3) ns
    
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
        '1' when m_reg = unsigned(m)+1 else
        '0';
    n_tick <=
        '1' when n_reg = unsigned(n)+1 else
        '0';
    
    -- output logic
    wave <= level_reg;

end Behavioral;

