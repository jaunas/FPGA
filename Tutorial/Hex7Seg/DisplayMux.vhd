library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity DisplayMux is
    port(
        clk, reset : in  STD_LOGIC;
        in3, in2, in1, in0 : in  STD_LOGIC_VECTOR (7 downto 0);
        an : out  STD_LOGIC_VECTOR (3 downto 0);
        sseg : out  STD_LOGIC_VECTOR (7 downto 0)
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
        elsif (clk'event and clk = '1') then
            q_reg <= q_next;
        end if;
    end process;

    -- next-state logic for the counter
    q_next <= q_reg + 1;
    
    -- 2 MSBs of counter to control 4-to-1 multiplexing
    -- and to generate active-low enable signal
    sel <= std_logic_vector(q_reg(N-1 downto N-2));
    process(sel, in0, in1, in2, in3)
    begin
        case sel is
            when "00" =>
                an <= "1110";
                sseg <= in0;
            when "01" =>
                an <= "1101";
                sseg <= in1;
            when "10" =>
                an <= "1011";
                sseg <= in2;
            when others =>
                an <= "0111";
                sseg <= in3;
        end case;
    end process;
end Behavioral;

