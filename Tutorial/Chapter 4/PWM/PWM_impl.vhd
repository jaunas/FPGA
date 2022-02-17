library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PWM_impl is
    port(
        Clk      : in  std_logic;
        Switch   : in  std_logic;
        DPSwitch : in  std_logic_vector(3 downto 0);
        LED      : out std_logic;
        IO_P5    : out std_logic
    );
end PWM_impl;

architecture Behavioral of PWM_impl is
    signal reset, wave: std_logic;
    signal w: std_logic_vector(3 downto 0);
begin

    reset <= not Switch;
    w <= not DPSwitch;
    IO_P5 <= wave;
    LED <= wave;

    pwm: entity work.PWM
    port map(
        clk => Clk,
        reset => reset,
        w => w,
        wave => wave
    );

end Behavioral;

