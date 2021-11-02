library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SquareWave_impl is
    port(
        clk, btn   : in  std_logic;
        switch     : in  std_logic_vector(7 downto 0);
        logic      : out std_logic
    );
end SquareWave_impl;

architecture Behavioral of SquareWave_impl is
    signal reset: std_logic;
    signal m, n: std_logic_vector(3 downto 0);
begin
    
    reset <= not btn;
    m <= not switch(7 downto 4);
    n <= not switch(3 downto 0);

    square_wave: entity work.SquareWave
    port map(
        clk => clk,
        reset => reset,
        m => m,
        n => n,
        wave => logic
    );
end Behavioral;

