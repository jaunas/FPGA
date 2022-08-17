library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fibonacci is
    port(
        clk, reset       : in  STD_LOGIC;
        start            : in  STD_LOGIC;
        ready, done_tick : out  STD_LOGIC;
        bcd_in           : in  STD_LOGIC_VECTOR (7 downto 0);
        bcd_out          : out  STD_LOGIC_VECTOR (11 downto 0)
    );
end fibonacci;

architecture Behavioral of fibonacci is
    type state_type is (idle, bcd2bin, fib, bin2bcd, done);
    signal state_reg, state_next: state_type;
    signal n_reg, n_next: unsigned(4 downto 0);
    -- bcd2bin and bin2bcd registers
    signal bcd_reg, bcd_next: unsigned(15 downto 0); -- bcd2bin uses only (7 downto 0)
    signal bin_reg, bin_next: unsigned(12 downto 0); -- bcd2bin uses only (6 downto 0)
    -- bcd2bin registers
    signal bcd_fixed, bcd_shifted: unsigned(7 downto 0);
    -- bin2bcd registers
    signal bcd_tmp: unsigned(15 downto 0);
    -- fib registers
    signal t0_reg, t0_next: unsigned(19 downto 0);
    signal t1_reg, t1_next: unsigned(19 downto 0);
begin

    -- State and data registers
    process(clk, reset)
    begin
        if reset = '1' then
            state_reg <= idle;
            n_reg <= (others => '0');

            bcd_reg <= (others => '0');
            bin_reg <= (others => '0');

            t0_reg <= (others => '0');
            t1_reg <= (others => '0');
        elsif rising_edge(clk) then
            state_reg <= state_next;
            n_reg <= n_next;

            bcd_reg <= bcd_next;
            bin_reg <= bin_next;

            t0_reg <= t0_next;
            t1_reg <= t1_next;
        end if;
    end process;

    -- FSMD next-state logic and data path operations
    process(
        state_reg, state_next, start,
        n_reg, n_next,
        -- bcd2bin
        bcd_in, bcd_fixed,
        -- bcd2bin & bin2bcd
        bcd_reg, bcd_next,
        bin_reg, bin_next,
        -- bin2bcd
        bcd_tmp,
        -- fib
        t0_reg, t1_reg -- ...bin_reg aka 'i'
        
    )
    begin
        state_next <= state_reg;
        bcd_next <= bcd_reg;
        bin_next <= bin_reg;
        n_next <= n_reg;
        ready <= '0';
        done_tick <= '0';
    
        case state_reg is
            when idle =>
                ready <= '1';
                if start = '1' then
                    -- prepare for bcd2bin
                    state_next <= bcd2bin;
                    bin_next <= (others => '0');
                    bcd_next(7 downto 0) <= unsigned(bcd_in);
                    bcd_next(15 downto 8) <= (others => '0');
                    n_next <= "00111";
                end if;
            
            when bcd2bin =>
                bcd_next(7 downto 0) <= bcd_fixed;
                bin_next(6 downto 0) <= bcd_reg(0) & bin_reg(6 downto 1);
                n_next <= n_reg - 1;
                if n_next = 0 then
                    -- prepare for fib
                    state_next <= fib;
                    t0_next <= (others => '0');
                    t1_next <= (0 => '1', others => '0');
                    n_next <= bin_next(4 downto 0); -- trim MSBs
                end if;
            
            when fib =>
                --n_reg <= bin_reg(4 downto 0); -- trim MSBs
                if n_reg <= 1 then
                    if n_reg = 0 then
                        t1_next <= (others => '0');
                    end if;
                    -- prepare for bin2bcd
                    state_next <= bin2bcd;
                    bcd_next <= (others => '0');
                    n_next <= "01101";
                    bin_next <= t1_next(12 downto 0);
                else
                    t1_next <= t1_reg + t0_reg;
                    t0_next <= t1_reg;
                    n_next <= n_reg - 1;
                end if;
            
            when bin2bcd =>
                bin_next <= bin_reg(11 downto 0) & '0';
                bcd_next <= bcd_tmp(14 downto 0) & bin_reg(12);
                n_next <= n_reg - 1;
                if n_next = 0 then
                    state_next <= done;
                end if;
            
            when done =>
                state_next <= idle;
                done_tick <= '1';
        end case;
    end process;
    
    bcd_shifted <= '0' & bcd_reg(7 downto 1);
    bcd_fixed(3 downto 0) <=
        bcd_shifted(3 downto 0) - 3 when bcd_shifted(3 downto 0) > 7 else
        bcd_shifted(3 downto 0);
    bcd_fixed(7 downto 4) <=
        bcd_shifted(7 downto 4) - 3 when bcd_shifted(7 downto 4) > 7 else
        bcd_shifted(7 downto 4);
    
    bcd_tmp(3 downto 0) <=
        bcd_reg(3 downto 0) + 3 when bcd_reg(3 downto 0) > 4 else
        bcd_reg(3 downto 0);
    bcd_tmp(7 downto 4) <=
        bcd_reg(7 downto 4) + 3 when bcd_reg(7 downto 4) > 4 else
        bcd_reg(7 downto 4);
    bcd_tmp(11 downto 8) <=
        bcd_reg(11 downto 8) + 3 when bcd_reg(11 downto 8) > 4 else
        bcd_reg(11 downto 8);
    bcd_tmp(15 downto 12) <=
        bcd_reg(15 downto 12) + 3 when bcd_reg(15 downto 12) > 4 else
        bcd_reg(15 downto 12);
        
    -- Output
    bcd_out <= std_logic_vector(bcd_reg(11 downto 0));

end Behavioral;
