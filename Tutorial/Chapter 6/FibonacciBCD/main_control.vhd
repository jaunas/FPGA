library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main_control is
    port(
        clk, reset      : in  STD_LOGIC;
        bcd_in          : in  STD_LOGIC_VECTOR (7 downto 0);
        bcd_out         : out STD_LOGIC_VECTOR (15 downto 0);
        start           : in  STD_LOGIC;
        ready, overflow : out STD_LOGIC
    );
end main_control;

architecture Behavioral of main_control is
    type state_type is (idle, bcd2bin, fib, bin2bcd);
    signal state_reg, state_next: state_type;
    signal bcd2bin_start, fib_start, bin2bcd_start: std_logic;
    signal bcd2bin_done_tick, fib_done_tick, bin2bcd_done_tick: std_logic;
    signal bin_n: std_logic_vector(6 downto 0);
    signal bin_fib: std_logic_vector(19 downto 0);
    signal bcd_fib: std_logic_vector(15 downto 0);
    signal overflow_fib, overflow_bcd: std_logic;
begin

    bcd2bin_unit: entity work.bcd2bin
    port map(
        clk => clk,
        reset => reset,
        bcd => bcd_in,
        bin => bin_n,
        start => bcd2bin_start,
        ready => open,
        done_tick => bcd2bin_done_tick
    );

    fib_unit: entity work.fibonacci
    port map(
        clk => clk,
        reset => reset,
        start => fib_start,
        i => bin_n(4 downto 0),
        ready => open,
        done_tick => fib_done_tick,
        overflow => overflow_fib,
        f => bin_fib
    );

    bin2bcd_unit: entity work.bin2bcd
    port map(
        clk => clk,
        reset => reset,
        start => bin2bcd_start,
        bin => bin_fib(12 downto 0),
        ready => open,
        done_tick => bin2bcd_done_tick,
        bcd3 => bcd_fib(15 downto 12),
        bcd2 => bcd_fib(11 downto 8),
        bcd1 => bcd_fib(7 downto 4),
        bcd0 => bcd_fib(3 downto 0)
    );

    process(clk, reset)
    begin
        if reset = '1' then
            state_reg <= idle;
        elsif rising_edge(clk) then
            state_reg <= state_next;
        end if;
    end process;

    process(state_reg, start,
        bcd2bin_done_tick, fib_done_tick, bin2bcd_done_tick)
    begin
        state_next <= state_reg;
        bcd2bin_start <= '0';
        fib_start <= '0';
        bin2bcd_start <= '0';
        ready <= '0';

        case state_reg is
            when idle =>
                ready <= '1';
                if start = '1' then
                    bcd2bin_start <= '1';
                    state_next <= bcd2bin;
                end if;
            when bcd2bin =>
                if bcd2bin_done_tick = '1' then
                    fib_start <= '1';
                    state_next <= fib;
                end if;
            when fib =>
                if fib_done_tick = '1' then
                    bin2bcd_start <= '1';
                    state_next <= bin2bcd;
                end if;
            when bin2bcd =>
                if bin2bcd_done_tick = '1' then
                    state_next <= idle;
                end if;
        end case;
    end process;

    overflow_bcd <= '1' when unsigned(bin_n) > 31 else '0';

    bcd_out(15 downto 12) <=
        bcd_fib(15 downto 12) when overflow_fib = '0' and overflow_bcd = '0' else
        "1001";
    bcd_out(11 downto 8) <=
        bcd_fib(11 downto 8) when overflow_fib = '0' and overflow_bcd = '0' else
        "1001";
    bcd_out(7 downto 4) <=
        bcd_fib(7 downto 4) when overflow_fib = '0' and overflow_bcd = '0' else
        "1001";
    bcd_out(3 downto 0) <=
        bcd_fib(3 downto 0) when overflow_fib = '0' and overflow_bcd = '0' else
        "1001";

    overflow <= overflow_fib or overflow_bcd;

end Behavioral;
