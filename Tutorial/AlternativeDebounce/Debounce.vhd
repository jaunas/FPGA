library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Debounce is
    generic(N : integer := 17); -- 2^17 * 83.(3) = ~10 ms
    port(
        clk, reset : in  STD_LOGIC;
        sw         : in  STD_LOGIC;
        db         : out STD_LOGIC
    );
end Debounce;

architecture Behavioral of Debounce is
    signal q_reg, q_next: unsigned(N-1 downto 0);
    signal m_tick: std_logic;
    type eg_state_type is (
        stable0_1, stable0_2, stable0_3, zero,
        stable1_1, stable1_2, stable1_3, one
    );
    signal state_reg, state_next: eg_state_type;
begin

    -- Counter
    process(clk, reset)
    begin
        if reset = '1' then
            q_reg <= (others => '0');
        elsif rising_edge(clk) then
            q_reg <= q_next;
        end if;
    end process;
    -- next state logic
    q_next <= q_reg + 1;
    -- output tick
    m_tick <= '1' when q_reg = 0 else '0';
    
    -- Debouncing register
    process(clk, reset)
    begin
        if reset = '1' then
            state_reg <= zero;
        elsif rising_edge(clk) then
            state_reg <= state_next;
        end if;
    end process;
    
    -- next state logic
    process(state_reg, sw, m_tick)
    begin
        state_next <= state_reg; -- default: don't change state
        db <= '0';
        case state_reg is
            when stable0_1 =>
                if m_tick = '1' then
                    state_next <= stable0_2;
                end if;
            when stable0_2 =>
                if m_tick = '1' then
                    state_next <= stable0_3;
                end if;
            when stable0_3 =>
                if m_tick = '1' then
                    state_next <= zero;
                end if;
        
            when zero =>
                if sw = '1' then
                    state_next <= stable1_1;
                end if;
                
            when stable1_1 =>
                db <= '1';
                if m_tick = '1' then
                    state_next <= stable1_2;
                end if;
            when stable1_2 =>
                db <= '1';
                if m_tick = '1' then
                    state_next <= stable1_3;
                end if;
            when stable1_3 =>
                db <= '1';
                if m_tick = '1' then
                    state_next <= one;
                end if;

            when one =>
                db <= '1';
                if sw = '0' then
                    state_next <= stable0_1;
                end if;
        end case;
    end process;


end Behavioral;
















