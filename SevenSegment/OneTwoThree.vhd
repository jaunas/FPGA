library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity OneTwoThree is
   Port(
      SevenSegment: out STD_LOGIC_VECTOR(7 downto 0);
      Enable: out STD_LOGIC_VECTOR(2 downto 0);
      Clk: in STD_LOGIC
   );
end OneTwoThree;

architecture Behavioral of OneTwoThree is
   signal counter: STD_LOGIC_VECTOR(15 downto 0);
   signal activating_counter: STD_LOGIC_VECTOR(1 downto 0);
begin
   process(Clk)
   begin
      if (rising_edge(Clk)) then
         counter <= counter + 1;
      end if;
   end process;
   
   activating_counter <= counter(15 downto 14);
   
   process(activating_counter)
   begin
      case activating_counter is
         when "00" =>
            Enable <= "110";
            SevenSegment <= "00001101";
         when "01" =>
            Enable <= "101";
            SevenSegment <= "00100101";
         when "10" =>
            Enable <= "011";
            SevenSegment <= "10011111";
         when others =>
            Enable <= "111";
            SevenSegment <= "11111111";
      end case;
   end process;
end Behavioral;

