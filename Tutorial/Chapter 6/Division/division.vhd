library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity division is
    generic(
        W: integer := 8;
        CBIT: integer := 4 -- CBIT = log2(W) + 1
    );
    port(
        clk, reset       : in  std_logic;
        start            : in  std_logic;
        dvsr, dvnd       : in  std_logic_vector(W-1 downto 0);
        ready, done_tick : out std_logic;
        quo, rmd         : out std_logic_vector(W-1 downto 0)
    );
end division;

architecture arch of division is
    type state_type is (idle, op, last, done);
    signal state_reg, state_next: state_type;
    signal rh_reg, rh_next: unsigned(W-1 downto 0);
    signal rl_reg, rl_next: std_logic_vector(W-1 downto 0);
    signal rh_tmp: unsigned(W-1 downto 0);
    signal d_reg, d_next: unsigned(W-1 downto 0);
    signal n_reg, n_next: unsigned(CBIT-1 downto 0);
    signal q_bit: std_logic;
begin

    -- FSMD state & data registers
    process(clk, reset)
    begin
        if reset = '1' then
            state_reg <= idle;
            rh_reg <= (others => '0');
            rl_reg <= (others => '0');
            d_reg <= (others => '0');
            n_reg <= (others => '0');
        elsif rising_edge(clk) then
            state_reg <= state_next;
            rh_reg <= rh_next;
            rl_reg <= rl_next;
            d_reg <= d_next;
            n_reg <= n_next;
        end if;
    end process;
--------------------------------------------------------------------------------
    -- FSMD next-state logic & data path logic
    process(state_reg, n_reg, rh_reg, rl_reg, d_reg,
        start, dvsr, dvnd, q_bit, rh_tmp, n_next)
    begin
        ready <= '0';
        done_tick <= '0';
        state_next <= state_reg;
        rh_next <= rh_reg;
        rl_next <= rl_reg;
        d_next <= d_reg;
        n_next <= n_reg;
        
        case state_reg is
            when idle =>
                ready <= '1';
                if start = '1' then
                    rh_next <= (others => '0');
                    rl_next <= dvnd;                    -- dividend
                    d_next <= unsigned(dvsr);           -- divisor
                    n_next <= to_unsigned(W+1, CBIT);   -- index
                    state_next <= op;
                end if;

            when op =>
                -- shift rh & rl left
                rl_next <= rl_reg(W-2 downto 0) & q_bit;
                rh_next <= rh_tmp(W-2 downto 0) & rl_reg(W-1);
                -- decrease index
                n_next <= n_reg - 1;
                if n_next = 1 then
                    state_next <= last;
                end if;

            when last =>
                rl_next <= rl_reg(W-2 downto 0) & q_bit;
                rh_next <= rh_tmp;
                state_next <= done;
            
            when done =>
                state_next <= idle;
                done_tick <= '1';
        end case;
    end process;
    
    -- compare & subtract
    process(rh_reg, d_reg)
    begin
        if rh_reg >= d_reg then
            rh_tmp <= rh_reg - d_reg;
            q_bit <= '1';
        else
            rh_tmp <= rh_reg;
            q_bit <= '0';
        end if;
    end process;

    -- output
    quo <= rl_reg;
    rmd <= std_logic_vector(rh_reg);

end arch;
