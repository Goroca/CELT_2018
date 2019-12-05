----------------------------------------------------------------------------------
-- COMPARADOR
--
-- Si P es mayor que un umbral la salida es '1',
-- en caso contrario la salida es '0'.
-- Sirve para comparar la duracion de los simbolos
-- y distinguir entre RAYA Y PUNTO y entre
-- ESPACIO Y PAUSA (Y PALABRA).
----------------------------------------------------------------------------------

library IEEE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity comp_16 is
  Port ( P : in  STD_LOGIC_VECTOR (15 downto 0);
         Q : in  STD_LOGIC_VECTOR (15 downto 0);
         P_GT_Q : out  STD_LOGIC);
end comp_16;

architecture Behavioral of comp_16 is
SIGNAL M : STD_LOGIC;

begin	
	M<= '1' when (P>Q) else '0';
	P_GT_Q<=M;
end Behavioral;

