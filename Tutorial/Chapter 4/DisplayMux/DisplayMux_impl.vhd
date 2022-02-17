library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DisplayMux_impl is
    port(
        clk:  in  STD_LOGIC;
        btn:  in  STD_LOGIC_VECTOR (2 downto 0);
        sw:   in  STD_LOGIC_VECTOR (7 downto 0);
        an:   out STD_LOGIC_VECTOR (2 downto 0);
        sseg: out STD_LOGIC_VECTOR (7 downto 0)
    );
end DisplayMux_impl;

architecture Behavioral of DisplayMux_impl is
    signal d2_reg, d1_reg, d0_reg: std_logic_vector(7 downto 0);
begin

    disp_unit: entity work.DisplayMux
    port map(
        clk   => clk,
        reset => '0',
        in2   => d2_reg,
        in1   => d1_reg,
        in0   => d0_reg,
        an    => an,
        sseg  => sseg
    );
    
    process(clk)
    begin
        if rising_edge(clk) then

            if btn(2)='0' then
                d2_reg <= sw;
            end if;

            if btn(1)='0' then
                d1_reg <= sw;
            end if;

            if btn(0)='0' then
                d0_reg <= sw;
            end if;
            
        end if;
    end process;

end Behavioral;
