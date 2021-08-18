library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity MusicBox is
    port(
        clk, reset       : in  STD_LOGIC;
        keys             : in  STD_LOGIC_VECTOR (5 downto 0);
        audio_l, audio_r : out STD_LOGIC
    );
end MusicBox;

architecture Behavioral of MusicBox is
    constant FREQ : integer := 12E6;
    constant C : integer := 262;
    constant D : integer := 294;
    constant E : integer := 330;
    constant F : integer := 349;
    constant G : integer := 392;
    constant A : integer := 440;

    signal c_reg, c_next: unsigned(15 downto 0);
    signal c_wave: std_logic;

    signal d_reg, d_next: unsigned(15 downto 0);
    signal d_wave: std_logic;

    signal e_reg, e_next: unsigned(15 downto 0);
    signal e_wave: std_logic;

    signal f_reg, f_next: unsigned(15 downto 0);
    signal f_wave: std_logic;

    signal g_reg, g_next: unsigned(14 downto 0);
    signal g_wave: std_logic;

    signal a_reg, a_next: unsigned(14 downto 0);
    signal a_wave: std_logic;

    signal wave: std_logic;
begin
    -- 12 Mhz => 1 tick = 83.(3) ns
    
    -- register
    process(clk, reset)
    begin
        if reset = '1' then
            c_reg <= (others => '0');
            d_reg <= (others => '0');
            e_reg <= (others => '0');
            f_reg <= (others => '0');
            g_reg <= (others => '0');
            a_reg <= (others => '0');
        elsif rising_edge(clk) then
            c_reg <= c_next;
            d_reg <= d_next;
            e_reg <= e_next;
            f_reg <= f_next;
            g_reg <= g_next;
            a_reg <= a_next;
        end if;
    end process;
    
    -- next-state logic
    c_next <=
        (others => '0') when c_reg = FREQ/C else
        c_reg + 1;
    c_wave <=
        '1' when c_reg < (FREQ/C)/2 else
        '0';

    d_next <=
        (others => '0') when d_reg = FREQ/D else
        d_reg + 1;
    d_wave <=
        '1' when d_reg < (FREQ/D)/2 else
        '0';

    e_next <=
        (others => '0') when e_reg = FREQ/E else
        e_reg + 1;
    e_wave <=
        '1' when e_reg < (FREQ/E)/2 else
        '0';

    f_next <=
        (others => '0') when f_reg = FREQ/F else
        f_reg + 1;
    f_wave <=
        '1' when f_reg < (FREQ/F)/2 else
        '0';

    g_next <=
        (others => '0') when g_reg = FREQ/G else
        g_reg + 1;
    g_wave <=
        '1' when g_reg < (FREQ/G)/2 else
        '0';

    a_next <=
        (others => '0') when a_reg = FREQ/A else
        a_reg + 1;
    a_wave <=
        '1' when a_reg < (FREQ/A)/2 else
        '0';


    -- Output
    wave <=
        (c_wave and keys(0)) or
        (d_wave and keys(1)) or
        (e_wave and keys(2)) or
        (f_wave and keys(3)) or
        (g_wave and keys(4)) or
        (a_wave and keys(5));
    
    audio_l <= wave;
    audio_r <= wave;

end Behavioral;
