library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity DigitIncrementor is
   port(
      digit: in STD_LOGIC_VECTOR(3 downto 0);
      enable: in STD_LOGIC;
      incremented_digit: out STD_LOGIC_VECTOR(3 downto 0);
      carry: out STD_LOGIC
   );
end DigitIncrementor;

architecture Behavioral of DigitIncrementor is
begin

   incremented_digit <= digit  when enable = '0' else
                        "0000" when digit = "1001" else
                        std_logic_vector(unsigned(digit) + 1);
   
   carry <= '1' when (digit = "1001" and enable = '1') else
            '0';

end Behavioral;
