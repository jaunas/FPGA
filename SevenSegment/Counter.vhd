library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter is
   Port(
      SevenSegment: out STD_LOGIC_VECTOR(7 downto 0);
      Enable: out STD_LOGIC_VECTOR(2 downto 0);
      Clk: in STD_LOGIC
   );
end Counter;

architecture Behavioral of Counter is
   signal counter: STD_LOGIC_VECTOR(34 downto 0);
   signal activating_counter: STD_LOGIC_VECTOR(1 downto 0);
   signal displayed_digit: STD_LOGIC_VECTOR(3 downto 0);
   signal number: STD_LOGIC_VECTOR(11 downto 0);
   signal coded_digit: STD_LOGIC_VECTOR(6 downto 0);
   signal display: integer range 0 to 3 := 0;
begin
   process(Clk)
   begin
      if (rising_edge(Clk)) then
         counter <= counter + 1;
      end if;
   end process;
   
   number <= counter(34 downto 23);
   
   activating_counter <= counter(14 downto 13);
   process(activating_counter)
   begin
      case activating_counter is
         when "00" =>
            display <= 0;
            displayed_digit <= number(3 downto 0);
         when "01" =>
            display <= 1;
            displayed_digit <= number(7 downto 4);
         when "10" =>
            display <= 2;
            displayed_digit <= number(11 downto 8);
         when others =>
            display <= 3;
            displayed_digit <= x"0";
      end case;
   end process;
   
   coded_digit <= "0000001" when displayed_digit = x"0" else
                  "1001111" when displayed_digit = x"1" else
                  "0010010" when displayed_digit = x"2" else
                  "0000110" when displayed_digit = x"3" else
                  "1001100" when displayed_digit = x"4" else
                  "0100100" when displayed_digit = x"5" else
                  "0100000" when displayed_digit = x"6" else
                  "0001111" when displayed_digit = x"7" else
                  "0000000" when displayed_digit = x"8" else
                  "0000100" when displayed_digit = x"9" else
                  "0001000" when displayed_digit = x"a" else
                  "1100000" when displayed_digit = x"b" else
                  "0110001" when displayed_digit = x"c" else
                  "1000010" when displayed_digit = x"d" else
                  "0110000" when displayed_digit = x"e" else
                  "0111000" when displayed_digit = x"f" else
                  "1111111";
   
   SevenSegment <= coded_digit & counter(22) when display = 0 else
                   coded_digit & "1";
   
   Enable <= "110" when display = 0 else
             "101" when display = 1 else
             "011" when display = 2 else
             "111";
end Behavioral;

