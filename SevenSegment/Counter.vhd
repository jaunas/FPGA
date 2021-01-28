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
   signal counter: STD_LOGIC_VECTOR(23 downto 0);
   signal activating_counter: STD_LOGIC_VECTOR(1 downto 0);
   signal displayed_digit: STD_LOGIC_VECTOR(6 downto 0);
   signal display_number: integer range 0 to 3 := 0;
begin
   process(Clk)
   begin
      if (rising_edge(Clk)) then
         counter <= counter + 1;
      end if;
   end process;
   
   activating_counter <= counter(14 downto 13);
   process(activating_counter)
   begin
      case activating_counter is
         when "00" =>
            display_number <= 0;
            displayed_digit <= "0000110";
         when "01" =>
            display_number <= 1;
            displayed_digit <= "0010010";
         when "10" =>
            display_number <= 2;
            displayed_digit <= "1001111";
         when others =>
            display_number <= 3;
            displayed_digit <= "1111111";
      end case;
   end process;
   
   SevenSegment <= displayed_digit & counter(23) when display_number = 0 else
                   displayed_digit & "1";
   
   Enable <= "110" when display_number = 0 else
             "101" when display_number = 1 else
             "011" when display_number = 2 else
             "111";
end Behavioral;

