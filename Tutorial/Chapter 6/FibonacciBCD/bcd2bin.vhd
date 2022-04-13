library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bcd2bin is
    port(
        clk, reset       : in  STD_LOGIC;
        bcd              : in  STD_LOGIC_VECTOR(7 downto 0);
        bin              : out STD_LOGIC_VECTOR(6 downto 0);
        start            : in  STD_LOGIC;
        ready, done_tick : out STD_LOGIC
    );
end bcd2bin;

architecture Behavioral of bcd2bin is
    type state_type is (idle, op, done);
    signal state_reg, state_next: state_type;
    signal bcd_reg, bcd_next: unsigned(7 downto 0);
    signal bcd_fixed, bcd_shifted: unsigned(7 downto 0);
    signal bin_reg, bin_next: unsigned(6 downto 0);
    signal n_reg, n_next: unsigned(2 downto 0); -- index
begin

    -- State and data registers
    process(clk, reset)
    begin
        if reset = '1' then
            state_reg <= idle;
            bcd_reg <= (others => '0');
            bin_reg <= (others => '0');
            n_reg <= (others => '0');
        elsif rising_edge(clk) then
            state_reg <= state_next;
            bcd_reg <= bcd_next;
            bin_reg <= bin_next;
            n_reg <= n_next;
        end if;
    end process;

    -- FSMD next-state logic and data path operations
    process(
        state_reg, state_next, start,
        bcd, bcd_fixed,
        bcd_reg, bcd_next,
        bin_reg, bin_next,
        n_reg, n_next
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
                    state_next <= op;
                    bin_next <= (others => '0');
                    bcd_next <= unsigned(bcd);
                    n_next <= "111"; -- count from 7
                end if;

            when op =>
                bcd_next <= bcd_fixed;
                bin_next <= bcd_reg(0) & bin_reg(6 downto 1);
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

    bin <= std_logic_vector(bin_reg);

end Behavioral;
