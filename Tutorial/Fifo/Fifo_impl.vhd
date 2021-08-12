library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Fifo_impl is
    port(
        clk        : in  STD_LOGIC;
        btn        : in  STD_LOGIC_VECTOR (2 downto 0);
        sw         : in  STD_LOGIC_VECTOR (2 downto 0);
        led        : out STD_LOGIC_VECTOR (7 downto 0)
    );
end Fifo_impl;

architecture Behavioral of Fifo_impl is
    signal db_btn: std_logic_vector(1 downto 0);
    signal reset: std_logic;
begin

    reset <= not btn(2);

    -- Debouncing circuits

    btn0_db: entity work.Debounce port map(
        clk => clk,
        reset => reset,
        sw => not btn(0),
        db_level => open,
        db_tick => db_btn(0)
    );
    
    btn1_db: entity work.Debounce port map(
        clk => clk,
        reset => reset,
        sw => not btn(1),
        db_level => open,
        db_tick => db_btn(1)
    );
    
    -- instantiate a 2^2-by-3 FIFO
    
    fifo_unit: entity work.Fifo
    generic map(B => 3, W => 2)
    port map(
        clk => clk,
        reset => reset,
        rd => db_btn(0),
        wr => db_btn(1),
        w_data => sw,
        r_data => led(2 downto 0),
        full => led(7),
        empty => led(6)
    );
    
    -- disable unsuded leds
    led(5 downto 3) <= (others => '0');

end Behavioral;

