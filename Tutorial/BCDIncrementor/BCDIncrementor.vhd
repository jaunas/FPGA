library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity BCDIncrementor is
	port(
		number: in STD_LOGIC_VECTOR (11 downto 0);
	   incremented_number: out STD_LOGIC_VECTOR (11 downto 0)
	);
end BCDIncrementor;

architecture Behavioral of BCDIncrementor is
   signal first_carry, second_carry: std_logic;
begin
   
   first_digit: entity work.DigitIncrementor port map(
      digit => number(3 downto 0),
      enable => '1',
      incremented_digit => incremented_number(3 downto 0),
      carry => first_carry
   );
   
   second_digit: entity work.DigitIncrementor port map(
      digit => number(7 downto 4),
      enable => first_carry,
      incremented_digit => incremented_number(7 downto 4),
      carry => second_carry
   );
   
   third_digit: entity work.DigitIncrementor port map(
      digit => number(11 downto 8),
      enable => second_carry,
      incremented_digit => incremented_number(11 downto 8)
   );
   
end Behavioral;
