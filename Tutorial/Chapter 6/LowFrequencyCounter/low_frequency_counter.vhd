library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity low_frequency_counter is
    port(
        clk, reset             : in  STD_LOGIC;
        start                  : in  STD_LOGIC;
        si                     : in  STD_LOGIC;
        bcd3, bcd2, bcd1, bcd0 : out STD_LOGIC_VECTOR (3 downto 0)
    );
end low_frequency_counter;

architecture Behavioral of low_frequency_counter is
    type state_type is (idle, count, frequency, bin2bcd);
    
    signal state_reg, state_next            : state_type;
    signal period                           : std_logic_vector(9 downto 0);
    signal dvsr, dvnd, quo                  : std_logic_vector(19 downto 0);

    signal period_start, period_done_tick   : std_logic;
    signal div_start, div_done_tick         : std_logic;
    signal bin2bcd_start, bin2bcd_done_tick : std_logic;
begin

    --=========================--
    -- component instatiantion --
    --=========================--

    -- instantiate period counter
    period_count_unit: entity work.period_counter
    port map(
        clk       => clk,
        reset     => reset,
        start     => period_start,
        si        => si,
        ready     => open,
        done_tick => period_done_tick,
        prd       => period
    );

    -- instantiate division circuit
    division_unit: entity work.division
    generic map(W => 20, CBIT => 5)
    port map(
        clk       => clk,
        reset     => reset,
        start     => div_start,
        dvsr      => dvsr,
        dvnd      => dvnd,
        quo       => quo,
        rmd       => open,
        ready     => open,
        done_tick => div_done_tick
    );
    
    bin2bcd_unit: entity work.bin2bcd
    port map(
        clk       => clk,
        reset     => reset,
        start     => bin2bcd_start,
        bin       => quo(12 downto 0),
        ready     => open,
        done_tick => bin2bcd_done_tick,
        bcd3      => bcd3,
        bcd2      => bcd2,
        bcd1      => bcd1,
        bcd0      => bcd0
    );
    
    -- signal width extension
    dvnd <= std_logic_vector(to_unsigned(1_000_000, 20));
    dvsr <= "0000000000" & period;
    
    --============--
    -- master FSM --
    --============--
    process(clk, reset)
    begin
        if reset = '1' then
            state_reg <= idle;
        elsif rising_edge(clk) then
            state_reg <= state_next;
        end if;
    end process;
    
    process(
        state_reg,
        start,
        period_done_tick,
        div_done_tick,
        bin2bcd_done_tick
    )
    begin
        state_next <= state_reg;
        period_start <= '0';
        div_start <= '0';
        bin2bcd_start <= '0';
        case state_reg is
            when idle =>
                if start = '1' then
                    state_next <= count;
                    period_start <= '1';
                end if;
            when count =>
                if period_done_tick = '1' then
                    div_start <= '1';
                    state_next <= frequency;
                end if;
            when frequency =>
                if div_done_tick = '1' then
                    bin2bcd_start <= '1';
                    state_next <= bin2bcd;
                end if;
            when bin2bcd =>
                if bin2bcd_done_tick = '1' then
                    state_next <= idle;
                end if;
        end case;
    end process;

end Behavioral;
