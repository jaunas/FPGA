library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity period_counter is
    port(
        clk, reset       : in  STD_LOGIC;
        start, si        : in  STD_LOGIC;
        ready, done_tick : out STD_LOGIC;
        prd              : out STD_LOGIC_VECTOR(9 downto 0)
    );
end period_counter;

architecture Behavioral of period_counter is
    constant CLK_MS_COUNT: integer := 50000; -- 1 ms tick
    type state_type is (idle, wait_edge, count, done);

    signal state_reg, state_next : state_type;
    signal t_reg, t_next         : unsigned(15 downto 0);
    signal p_reg, p_next         : unsigned(9 downto 0);
    signal delay_reg             : std_logic;
    signal edge                  : std_logic;
begin

    -- state and data register
    process(clk, reset)
    begin
        if reset = '1' then
            state_reg <= idle;
            t_reg <= (others => '0');
            p_reg <= (others => '0');
            delay_reg <= '0';
        elsif rising_edge(clk) then
            state_reg <= state_next;
            t_reg <= t_next;
            p_reg <= p_next;
            delay_reg <= si;
        end if;
    end process;
    
    -- edge detection circuit
    edge <= (not delay_reg) and si;
    
    -- fsmd next-state logic / data path operations
    process(start, edge, state_reg, t_reg, t_next, p_reg)
    begin
        ready <= '0';
        done_tick <= '0';
        state_next <= state_reg;
        p_next <= p_reg;
        t_next <= t_reg;
        case state_reg is
            when idle =>
                ready <= '1';
                if start = '1' then
                    state_next <= wait_edge;
                end if;
            when wait_edge => -- wait for the first edge
                if edge = '1' then
                    state_next <= count;
                    t_next <= (others => '0');
                    p_next <= (others => '0');
                end if;
            when count =>
                if edge = '1' then -- 2nd edge arrived
                    state_next <= done;
                else               -- otherwise count
                    if t_reg = CLK_MS_COUNT - 1 then
                        t_next <= (others => '0');
                        p_next <= p_reg + 1;
                    else
                        t_next <= t_reg + 1;
                    end if;
                end if;
            when done =>
                done_tick <= '1';
                state_next <= idle;
        end case;
    end process;
    
    prd <= std_logic_vector(p_reg);

end Behavioral;


















