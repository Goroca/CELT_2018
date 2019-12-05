----------------------------------------------------------------------------------
-- MULTIPLEXOR
-- 
-- La senales de entrada E0-E3 son las 4 seales 
-- que deberan salir en los displays mientras 
-- que S es el display que en ese momento esta activo
-- Por lo que la salida sera la senal correspondiente
-- al display que en ese momento este activo.
-- El objetivo es que este modulo este sincronizado con refresco
-- Para que a la vez que se activa un dispay se le pase la senal
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity MUX4x8 is
 Port ( E0 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada 0
		  E1 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada 1
		  E2 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada 2
		  E3 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada 3
		  S : in STD_LOGIC_VECTOR (1 downto 0); -- Senal de control
		  Y : out STD_LOGIC_VECTOR (7 downto 0)); -- Salida
end MUX4x8;

architecture MUX4x8 of MUX4x8 is
begin
with S select Y<= -- S es la senal de control
	E0 when "00", -- Cuarto Display
	E1 when "01", -- Tercer Display
	E2 when "10", -- Segundo Display
	E3 when others;-- Primer Display


end MUX4x8;

