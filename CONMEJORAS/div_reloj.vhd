------------------------------------------------------------
-- DIVISOR DEL RELOJ
--
-- Este modulo tiene como senal de entrada un reloj 
-- CLK con un periodo de 20 ns, negando el valor de la salida
-- cada 1ms/(20ns*2) conseguimos crear un CLK que cambia
-- (de 0 a 1 o de 1 a 0) cada 0.5 ms y por tanto es un
-- reloj de perido un 1 ms.
-------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
entity div_reloj is
 Port ( CLK : in STD_LOGIC; -- Entrada reloj de la FPGA 50 MHz (Periodo de 20 ns)
		  CLK_1ms : out STD_LOGIC); -- Salida reloj a 1 KHz (Periodo de 1 ms)
end div_reloj;

architecture a_div_reloj of div_reloj is
signal contador : STD_LOGIC_VECTOR (15 downto 0):="0000000000000000";
signal flag : STD_LOGIC:='0';

begin
process(CLK)
 begin
 if (CLK'event and CLK='1') then
	contador<=contador+1;
	if (contador=25000) then --Cuando la cuenta llegue  a medio periodo
		contador<=(others=>'0');
		flag<=not flag; -- Se niega el valor anterior de la salida
	end if;
 end if;
end process;

CLK_1ms<=flag;
end a_div_reloj;