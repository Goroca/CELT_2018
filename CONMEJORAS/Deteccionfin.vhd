----------------------------------------------------------------------------------
-- DETECTORFIN
-- 
-- Tiene como entrada el codigo de cada simbolo que va saliendo,
-- Si la secuencia de los ultimos tres simbolos es
-- ESPACIO-K-ESPACIO
-- La salida FINAL se pone a '1'
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Deteccionfin is
 Port( CLK_1ms : in STD_LOGIC;
		 CODIGO : in STD_LOGIC_VECTOR (7 downto 0); -- codigo morse obtenido
		 VALID_DISP : in STD_LOGIC;
		 FINAL : out STD_LOGIC );
end Deteccionfin;

architecture Deteccionfin of Deteccionfin is
SIGNAL QS0: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL QS1: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL QS2: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL K: STD_LOGIC_VECTOR(23 DOWNTO 0);

begin
process(CLK_1ms)
begin
if (CLK_1ms'event and CLK_1ms='1') then
 if(VALID_DISP='1') then -- Se actualiza cuando llega un nuevo valor,
  QS0<=QS1;					 -- al igual que el registro de desplazamiento
  QS1<=QS2;
  QS2<=CODIGO;
 end if;
end if; 
end process;

K(23 downto 16) <= QS0;
K(15 downto 8) <= QS1;
K(7 downto 0) <=  QS2;

with K SELECT FINAL <= --Una ROM con una sola salida '1' y el resto '0'
'1' when "010110000111010001011000",-- Secuencia M-K-M
'0' when others;
end Deteccionfin;