----------------------------------------------------------------------------------
-- REFRESCO
--
-- Este modulo tiene solo como entrada el Clk
-- Y en cada ciclo de este (cada milisegundo)
-- activa uno de los 4 displays (salida AN)
-- y indica que display esta activado usando
-- el vector S.
-- De esta forma cada display actualiza su valor
-- durante un ciclo de reloj (1 ms) y se mantiene
-- sin cambios durante 3 ciclos (3 ms).
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity refresco is
Port( CLK_1ms : in STD_LOGIC; -- reloj de refresco
		S : out STD_LOGIC_VECTOR (1 downto 0); -- Control para el mux
		AN : out STD_LOGIC_VECTOR (3 downto 0)); -- Control displays
end refresco;

architecture Behavioral of refresco is
SIGNAL M: STD_LOGIC_VECTOR(1 DOWNTO 0):="00"; --Inicializacion de M

begin
process(CLK_1ms)
begin
if (CLK_1ms'event and CLK_1ms='1') then
	if(M="11") then -- Va actualizando el valor de M de
		M<="00";     -- 0 a 3 en cada ciclo de reloj
	else
		M <= M+1; --Paso al siguiente display
	end if;
 end if;
end process;

WITH M SELECT AN <= 
 "1110" WHEN "00", --Activo el cuarto display
 "1101" WHEN "01", --Activo el tercer display
 "1011" WHEN "10", --Activo el segundo display
 "0111" WHEN others;--Activo el primer display

S<=M;
end Behavioral;