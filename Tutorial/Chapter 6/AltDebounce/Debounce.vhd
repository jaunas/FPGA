library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Debounce is
    port(
        clk, reset        : in  STD_LOGIC;
        sw                : in  STD_LOGIC;
        db_level, db_tick : out STD_LOGIC
    );
end Debounce;

architecture Behavioral of Debounce is
    constant N: integer := 21; -- filter of 2^N * 20 ns = 40 ms
    type state_type is (zero, wait1, one, wait0);
    signal state_reg, state_next: state_type;
    signal q_reg, q_next: unsigned(N-1 downto 0);
begin

    -- FSMD state and data registers
    process(clk, reset)
    begin
        if reset = '1' then
            state_reg <= zero;
            q_reg <= (others => '0');
        elsif rising_edge(clk) then
            state_reg <= state_next;
            q_reg <= q_next;
        end if;
    end process;

    -- Next-state logic and data path functional units/routing
    process(state_reg, q_reg, sw, q_next)
    begin
        state_next <= state_reg;
        q_next <= q_reg;
        db_tick <= '0';
        case state_reg is
            when zero =>
                db_level <= '0';
                if sw = '1' then
                    state_next <= wait1;
                    q_next <= (others => '1');
                    db_tick <= '1';
                end if;
            when wait1 =>
                db_level <= '1';
                q_next <= q_reg - 1;
                if q_next = 0 then
                    state_next <= one;
                end if;
            when one =>
                db_level <= '1';
                if sw = '0' then
                    state_next <= wait0;
                    q_next <= (others => '1');
                end if;
            when wait0 =>
                db_level <= '0';
                q_next <= q_reg - 1;
                if q_next = 0 then
                    state_next <= zero;
                end if;
        end case;
    end process;

end Behavioral;
