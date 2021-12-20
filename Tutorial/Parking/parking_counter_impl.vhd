library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parking_counter_impl is
    port(
        clk, reset   : in  std_logic;
        switch       : in  std_logic_vector(1 downto 0);
        sevenSegment : out std_logic_vector(7 downto 0);
        enable       : out std_logic_vector(3 downto 0)
    );
end parking_counter_impl;

architecture Behavioral of parking_counter_impl is
    signal an: std_logic_vector(1 downto 0);
begin

    parking_counter: entity work.parking_counter port map(
        clk => clk,
        reset => not reset,
        sensor => not switch,
        sseg => sevenSegment,
        an => an
    );
    
    enable <= "00" & an;

end Behavioral;

