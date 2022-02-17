library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Stack_impl is
    port(
        Clk      : in  STD_LOGIC;
        DPSwitch : in  STD_LOGIC_VECTOR (2 downto 0);
        Switch   : in  STD_LOGIC_VECTOR (2 downto 0);
        LED      : out STD_LOGIC_VECTOR (7 downto 0)
    );
end Stack_impl;

architecture Behavioral of Stack_impl is
    signal db_btn: std_logic_vector(1 downto 0);
    signal reset: std_logic;
    signal r_data: std_logic_vector(2 downto 0);
    signal full, empty: std_logic;
begin

    reset <= not Switch(0);

    btn_db0: entity work.Debounce
    port map(
        clk => Clk,
        reset => reset,
        sw => not Switch(1),
        db_level => open,
        db_tick => db_btn(0)
    );

    btn_db1: entity work.Debounce
    port map(
        clk => Clk,
        reset => reset,
        sw => not Switch(2),
        db_level => open,
        db_tick => db_btn(1)
    );

    stack: entity work.Stack
    generic map(B=>3, W=>2)
    port map(
        clk => Clk,
        reset => reset,
        push => db_btn(0),
        pop => db_btn(1),
        w_data => not DPSwitch(2 downto 0),
        r_data => r_data,
        full => full,
        empty => empty
    );
    
    LED(7) <= full;
    LED(6) <= empty;
    LED(5 downto 3) <= (others => '0');
    LED(2 downto 0) <= r_data;

end Behavioral;

