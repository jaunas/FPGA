library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bin2bcd is
    port(
        clk, reset             : in  std_logic;
        start                  : in  std_logic;
        bin                    : in  std_logic_vector(12 downto 0);
        ready, done_tick       : out std_logic;
        bcd3, bcd2, bcd1, bcd0 : out std_logic_vector(3 downto 0)
    );
end bin2bcd;
--------------------------------------------------------------------------------
architecture arch of bin2bcd is
    type state_type is (idle, op, done);
    signal state_reg, state_next: state_type;
    signal bin_reg, bin_next: std_logic_vector(12 downto 0);
    signal n_reg, n_next: unsigned(3 downto 0);
    signal bcd_reg, bcd_next, bcd_tmp: unsigned(15 downto 0);
    -- bcd0 = bcd(3 downto 0);
    -- bcd1 = bcd(7 downto 4);
    -- bcd2 = bcd(11 downto 8);
    -- bcd3 = bcd(15 downto 12);
begin

    -- State and data registers
    process(clk, reset)
    begin
        if reset = '1' then
            state_reg <= idle;
            bin_reg <= (others => '0');
            n_reg <= (others => '0');
            bcd_reg <= (others => '0');
        elsif rising_edge(clk) then
            state_reg <= state_next;
            bin_reg <= bin_next;
            n_reg <= n_next;
            bcd_reg <= bcd_next;
        end if;
    end process;
    
    -- FSMD next-state logic / data path operations
    process(state_reg, start, bin_reg, n_reg, n_next, bin, bcd_reg, bcd_tmp)
    begin
        state_next <= state_reg;
        ready <= '0';
        done_tick <= '0';
        bin_next <= bin_reg;
        --bcd0_next <= bcd0_reg;
        --bcd1_next <= bcd1_reg;
        --bcd2_next <= bcd2_reg;
        --bcd3_next <= bcd3_reg;
        bcd_next <= bcd_reg;
        n_next <= n_reg;
        
        case state_reg is
            when idle =>
                ready <= '1';
                if start = '1' then
                    state_next <= op;
                    bcd_next <= (others => '0');
                    n_next <= "1101"; -- index
                    bin_next <= bin; -- input shift register
                    state_next <= op;
                end if;
            
            when op =>
                -- shift in binary bit
                bin_next <= bin_reg(11 downto 0) & '0';
                -- shift 4 BCD digits
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
    
    -- Data path function units
    -- 4 BCD adjustment circuits
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
    bcd0 <= std_logic_vector(bcd_reg(3 downto 0));
    bcd1 <= std_logic_vector(bcd_reg(7 downto 4));
    bcd2 <= std_logic_vector(bcd_reg(11 downto 8));
    bcd3 <= std_logic_vector(bcd_reg(15 downto 12));

end arch;
