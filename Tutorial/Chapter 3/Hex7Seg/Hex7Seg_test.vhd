library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Hex7Seg_test is
    port(
        clk: in STD_LOGIC;
        sw: in STD_LOGIC_VECTOR(7 downto 0);
        an: out STD_LOGIC_VECTOR(2 downto 0);
        sseg: out STD_LOGIC_VECTOR(7 downto 0)
    );
end Hex7Seg_test;

architecture Behavioral of Hex7Seg_test is
    signal inc: std_logic_vector(3 downto 0);
    signal led2, led1, led0: std_logic_vector(7 downto 0);
begin
    -- trim (only 1 display is available for that) and increment input
    inc <= std_logic_vector(unsigned(sw(3 downto 0)) + 1);
    

    -- instantiate four instances of hex decoders

    -- instance for 4 LSBs of input
    sseg_unit_0: entity work.Hex7Seg
        port map(
            hex => sw(3 downto 0),
            dp => '0',
            sseg => led0
        );

    -- instance for 4 MSBs of input
    sseg_unit_1: entity work.Hex7Seg
        port map(
            hex => sw(7 downto 4),
            dp => '0',
            sseg => led1
        );

    -- instance for 4 LSBs of incremented value
    sseg_unit_2: entity work.Hex7Seg
        port map(
            hex => inc(3 downto 0),
            dp => '1',
            sseg => led2
        );

        
    -- instantiate 7-seg LED display time-multiplexing module
    disp_unit: entity work.DisplayMux
        port map(
            clk => clk,
            reset => '0',
            in0 => led0, in1 => led1, in2 => led2,
            an => an,
            sseg => sseg
        );
end Behavioral;

