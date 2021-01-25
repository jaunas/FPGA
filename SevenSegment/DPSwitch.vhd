library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DPSwitch is
   Port(
      DPSwitch: in STD_LOGIC_VECTOR(7 downto 0);
      Switch: in STD_LOGIC_VECTOR(2 downto 0);
      SevenSegment: out STD_LOGIC_VECTOR(7 downto 0);
      Enable: out STD_LOGIC_VECTOR(2 downto 0)
   );
end DPSwitch;

architecture Behavioral of DPSwitch is

begin

   SevenSegment <= DPSwitch;
   Enable <= not Switch;

end Behavioral;
