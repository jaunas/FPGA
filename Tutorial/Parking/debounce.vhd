library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity debounce is
    port(
        clk, reset : in  STD_LOGIC;
        sw         : in  STD_LOGIC;
        db         : out STD_LOGIC
    );
end debounce;

architecture Behavioral of debounce is
    constant N: integer := 17; -- 2^17 * 83.(3) = ~10 ms
    signal q_reg, q_next: unsigned(N-1 downto 0);
    signal m_tick: std_logic;
    type eg_state_type is (
        zero, wait1_1, wait1_2, wait1_3,
        one, wait0_1, wait0_2, wait0_3
    );
    signal state_reg, state_next: eg_state_type;
begin

    -- Counter
    process(clk, reset)
    begin
        if rising_edge(clk) then
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
            when zero =>
                if sw = '1' then
                    state_next <= wait1_1;
                end if;

            when wait1_1 =>
                if sw = '0' then
                    state_next <= zero;
                elsif m_tick = '1' then
                    state_next <= wait1_2;
                end if;
            when wait1_2 =>
                if sw = '0' then
                    state_next <= zero;
                elsif m_tick = '1' then
                    state_next <= wait1_3;
                end if;
            when wait1_3 =>
                if sw = '0' then
                    state_next <= zero;
                elsif m_tick = '1' then
                    state_next <= one;
                end if;

            when one =>
                db <= '1';
                if sw = '0' then
                    state_next <= wait0_1;
                end if;

            when wait0_1 =>
                db <= '1';
                if sw = '1' then
                    state_next <= one;
                elsif m_tick = '1' then
                    state_next <= wait0_2;
                end if;
            when wait0_2 =>
                db <= '1';
                if sw = '1' then
                    state_next <= one;
                elsif m_tick = '1' then
                    state_next <= wait0_3;
                end if;
            when wait0_3 =>
                db <= '1';
                if sw = '1' then
                    state_next <= one;
                elsif m_tick = '1' then
                    state_next <= zero;
                end if;
        end case;
    end process;


end Behavioral;