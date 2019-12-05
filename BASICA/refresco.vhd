----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:43:32 11/03/2018 
-- Design Name: 
-- Module Name:    refresco - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity refresco is
 Port ( CLK_1ms : in STD_LOGIC; -- reloj de refresco
 S : out STD_LOGIC_VECTOR (1 downto 0); -- Control para el mux
 AN : out STD_LOGIC_VECTOR (3 downto 0)); -- Control displays
end refresco;
architecture Behavioral of refresco is
SIGNAL M: STD_LOGIC_VECTOR(1 DOWNTO 0):="00";
begin

process(CLK_1ms)
begin
if (CLK_1ms'event and CLK_1ms='1') then

if(M="11") then
M<="00";
else
M <= M+1;
end if;
end if;
end process;
S<=M;

WITH M SELECT AN <= 
"1110" WHEN "00",
"1101" WHEN "01",
"1011" WHEN "10",
"0111" WHEN others; 

end Behavioral;

