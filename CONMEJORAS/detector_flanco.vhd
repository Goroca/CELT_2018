----------------------------------------------------------------------------------
-- DETECTOR DE FLANCOS
--
-- Corrige perturbaciones de la parte analogica (LIN) 
-- debidas al ruido, el modulo evita y corrige la falsa 
-- alarma (Tener '1' cuando el mensaje es '0') y pequeas 
-- variaciones de la seal que son errores.
-- La variable suma tiene 20 muestras de los ltmos 
-- 20 ms de entrada.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity detector_flanco is
 Port ( CLK_1ms : in STD_LOGIC; -- Reloj
		  LIN : in STD_LOGIC; -- Linea de datos
		  VALOR : out STD_LOGIC); -- Valor detectado en el flanco
end detector_flanco;

architecture a_detector_flanco of detector_flanco is
constant UMBRAL0 : STD_LOGIC_VECTOR (7 downto 0) := "00000101"; -- 5 umbral para el 0
constant UMBRAL1 : STD_LOGIC_VECTOR (7 downto 0) := "00001111"; -- 15 umbral para el 1
signal reg_desp : STD_LOGIC_VECTOR (19 downto 0):="00000000000000000000"; -- Registro de los ultimos 20 ciclos de reloj
signal suma : STD_LOGIC_VECTOR (7 downto 0) :="00000000"; -- Suma de todos los '1' de reg_desp
signal s_valor : STD_LOGIC :='0';

begin
process (CLK_1ms)
 begin
 if (CLK_1ms'event and CLK_1ms='1') then
	suma <= suma +LIN -reg_desp(19); --Resta el ultimo valor en el registro 
												--y suma el futuro primer valor (LIN)

	reg_desp (19 downto 1)<=reg_desp(18 downto 0); --Desplaza todos los bits a la izquierda
	reg_desp (0) <= LIN;									  --Anade el nuevo valor al registro

   if(s_valor='1' and suma<UMBRAL0) then  -- Si la salida es '1' y la suma de '1'
		s_valor<='0';								-- de las ultimas 20 muestras no supera
														-- el umbral de comparacion, la salida pasa a ser '0'

	elsif(s_valor='0' and suma>UMBRAL1) then -- Si la salida es '0' y la suma de '1' de  				
		s_valor<='1';                         -- las ultimas 20 muestras supera el umbral 
	end if;											  -- de comparacion, la salida pasa a ser '1'
 end if;
end process;
 
VALOR<=s_valor;
end a_detector_flanco;
