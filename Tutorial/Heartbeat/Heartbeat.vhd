library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Heartbeat is
    port(
        clk, reset : in  std_logic;
        an         : out std_logic_vector(2 downto 0);
        sseg       : out std_logic_vector(7 downto 0)
    );
end Heartbeat;

architecture Behavioral of Heartbeat is
    -- constant DELAY_RATE: integer := 500000; -- ~ 72/3 Hz
    constant DELAY_RATE: integer := 1000000; -- better effect with higher rate
    
    signal delay_reg, delay_next: unsigned(19 downto 0);
    signal delay_tick: std_logic;
    
    signal bar_reg, bar_next: unsigned(1 downto 0);
    
    signal in2, in1, in0: std_logic_vector(7 downto 0);
    
    constant LEFT_BAR: std_logic_vector(7 downto 0) := "11110011";
    constant RIGHT_BAR: std_logic_vector(7 downto 0) := "10011111";
begin

    -- register
    process(clk, reset)
    begin
        if reset = '1' then
            delay_reg <= (others => '0');
            bar_reg <= (others => '0');
        elsif rising_edge(clk) then
            delay_reg <= delay_next;
            bar_reg <= bar_next;
        end if;
    end process;

    -- next state-logic
    delay_next <=
        (others => '0') when delay_reg = DELAY_RATE else
        delay_reg + 1;
    
    delay_tick <= '1' when delay_reg = DELAY_RATE else '0';
    
    bar_next <=
        bar_reg when delay_tick = '0' else
        "00"    when bar_reg = "10" else
        bar_reg + 1;
    
    -- output
    in2 <=
        RIGHT_BAR when bar_reg = "01" else
        LEFT_BAR  when bar_reg = "10" else
        (others => '1');
    
    in1 <=
        LEFT_BAR and RIGHT_BAR when bar_reg = "00" else
        (others => '1');
    
    in0 <=
        LEFT_BAR  when bar_reg = "01" else
        RIGHT_BAR when bar_reg = "10" else
        (others => '1');
    
    display_mux: entity work.DisplayMux
    port map(
        clk => clk,
        reset => reset,
        in2 => in2,
        in1 => in1,
        in0 => in0,
        an => an,
        sseg => sseg
    );

end Behavioral;

