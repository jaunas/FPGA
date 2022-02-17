library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce is
    port(
        clk, reset        : in  std_logic;
        sw                : in  std_logic;
        db_level, db_tick : out std_logic
    );
end debounce;

architecture explicit_data_path of debounce is
    constant N: integer := 21;
    type state_type is (zero, wait0, one, wait1);
    signal state_reg, state_next: state_type;
    signal q_reg, q_next: unsigned(N-1 downto 0);
    signal q_load, q_dec, q_zero: std_logic;
begin

    -- FSMD state & data register
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
    
    -- FSMD data path (counter) next-state logic
    q_next <=
        (others => '1') when q_load = '1' else
        q_reg - 1       when q_dec = '1' else
        q_reg;
    q_zero <= '1' when q_next = 0 else '0';
    
    -- FSMD control path next-state logic
    process(state_reg, sw, q_zero)
    begin
        q_load <= '0';
        q_dec <= '0';
        db_tick <= '0';
        state_next <= state_reg;
        case state_reg is
            when zero =>
                db_level <= '0';
                if sw = '1' then
                    state_next <= wait1;
                    q_load <= '1';
                end if;
            when wait1 =>
                db_level <= '0';
                if sw = '1' then
                    q_dec <= '1';
                    if q_zero = '1' then
                        state_next <= one;
                        db_tick <= '1';
                    end if;
                else
                    state_next <= zero;
                end if;
            when one =>
                db_level <= '1';
                if sw = '0' then
                    state_next <= wait0;
                    q_load <= '1';
                end if;
            when wait0 =>
                db_level <= '1';
                if sw = '0' then
                    q_dec <= '1';
                    if q_zero = '1' then
                        state_next <= zero;
                    end if;
                else
                    state_next <= one;
                end if;
        end case;
    end process;

end explicit_data_path;

architecture implicit_data_path of debounce is
    constant N: integer := 21; -- filter od 2^N * 20ns = 40ms
    type state_type is (zero, wait0, one, wait1);
    signal state_reg, state_next: state_type;
    signal q_reg, q_next: unsigned(N-1 downto 0);
begin

    -- FSMD state & data registers
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
    
    -- next-state logic & data path functional units/routing
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
                end if;
            when wait1 =>
                db_level <= '0';
                if sw = '1' then
                    q_next <= q_reg - 1;
                    if q_next = 0 then
                        state_next <= one;
                        db_tick <= '1';
                    end if;
                else
                    state_next <= zero;
                end if;
            when one =>
                db_level <= '1';
                if sw = '0' then
                    state_next <= wait0;
                    q_next <= (others => '1');
                end if;
            when wait0 =>
                db_level <= '1';
                if sw = '0' then
                    q_next <= q_reg - 1;
                    if q_next = 0 then
                        state_next <= zero;
                    end if;
                else
                    state_next <= one;
                end if;
        end case;
    end process;

end implicit_data_path;
