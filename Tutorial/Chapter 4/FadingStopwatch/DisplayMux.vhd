library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity DisplayMux is
    port(
        clk, reset    : in  std_logic;
        in2, in1, in0 : in  std_logic_vector(7 downto 0);
        an            : out std_logic_vector(2 downto 0);
        sseg          : out std_logic_vector(7 downto 0)
    );
end DisplayMux;

architecture Behavioral of DisplayMux is
    -- refreshing rate
    constant N: integer := 16;
    signal q_reg, q_next: unsigned(N-1 downto 0);
    signal sel: std_logic_vector(1 downto 0);
begin
    -- register
    process(clk, reset)
    begin
        if (reset = '1') then
            q_reg <= (others => '0');
        elsif rising_edge(clk) then
            q_reg <= q_next;
        end if;
    end process;

    -- next-state logic for the counter
    q_next <= q_reg + 1;
    
    -- 2 MSBs of counter to control 4-to-1 multiplexing
    -- and to generate active-low enable signal
    sel <= std_logic_vector(q_reg(N-1 downto N-2));
    process(sel, in0, in1, in2)
    begin
        case sel is
            when "00" =>
                an <= "110";
                sseg <= in0;
            when "01" =>
                an <= "101";
                sseg <= in1;
            when "10" =>
                an <= "011";
                sseg <= in2;
            -- This section is never reached
            when others =>
                an <= "111";
                sseg <= (others => '1');
        end case;
    end process;
end Behavioral;

