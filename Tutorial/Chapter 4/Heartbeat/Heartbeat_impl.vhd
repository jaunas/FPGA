library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Heartbeat_impl is
    port(
        Clk          : in  std_logic;
        SevenSegment : out std_logic_vector(7 downto 0);
        Enable       : out std_logic_vector(2 downto 0)
    );
end Heartbeat_impl;

architecture Behavioral of Heartbeat_impl is

begin

    heartbeat: entity work.Heartbeat
    port map(
        clk => Clk,
        reset => '0',
        an => Enable,
        sseg => SevenSegment
    );

end Behavioral;

