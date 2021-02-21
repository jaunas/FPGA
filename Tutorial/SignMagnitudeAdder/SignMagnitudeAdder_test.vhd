library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignMagnitudeAdder_test is
    port(
        clk: in STD_LOGIC;
        btn: in STD_LOGIC_VECTOR(1 downto 0);
        sw: in STD_LOGIC_VECTOR(7 downto 0);
        an: out STD_LOGIC_VECTOR(2 downto 0);
        sseg: out STD_LOGIC_VECTOR(7 downto 0)
    );
end SignMagnitudeAdder_test;

architecture Behavioral of SignMagnitudeAdder_test is
    signal sum, mout, oct: std_logic_vector(3 downto 0);
    signal led2, led1, led0: std_logic_vector(7 downto 0);
begin
    -- instantiate adder
    sm_adder_unit: entity work.SignMagnitudeAdder
        generic map (N => 4)
        port map(
            a => sw(3 downto 0),
            b => sw(7 downto 4),
            sum => sum
        );

    -- 3-to-1 mux to select a number to display
    with btn select
        mout <= sw(3 downto 0) when "10", --a
                sw(7 downto 4) when "01", --b
                sum when others;
    
    -- magnitude displayed on rightmost 7-seg LED
    oct <= '0' & mout(2 downto 0);
    sseg_unit: entity work.Hex7Seg
        port map(
            hex => oct,
            dp => '0',
            sseg => led0
        );
    -- sign displayed on 2nd 7-seg LED
    led1 <= "11111101" when mout(3) = '1' else
            "11111111";
    -- 3rd 7-seg LED blank
    led2 <= "11111111";
    
    disp_unit: entity work.DisplayMux
        port map(
            clk => clk, reset => '0',
            in0 => led0, in1 => led1, in2 => led2,
            an => an, sseg => sseg
        );
end Behavioral;

