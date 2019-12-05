----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:47:19 11/01/2018 
-- Design Name: 
-- Module Name:    aut_control - Behavioral 
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

entity aut_control is
 Port ( CLK_1ms : in STD_LOGIC; -- reloj
 VALID : in STD_LOGIC; -- entrada de dato vlido
 DATO : in STD_LOGIC; -- dato (0 o 1)
 C0 : in STD_LOGIC; -- resultado comparador de ceros
 C1 : in STD_LOGIC; -- resultado comparador de unos
 CODIGO : out STD_LOGIC_VECTOR (7 downto 0); -- cdigo morse obtenido
 VALID_DISP : out STD_LOGIC); -- validacin del display
end aut_control;
architecture a_aut_control of aut_control is
type STATE_TYPE is (ESPACIO,RESET,SIMBOLO,ESPERA);
signal ST : STATE_TYPE := RESET;
signal s_ncod : STD_LOGIC_VECTOR (2 downto 0):="000";
signal s_cod : STD_LOGIC_VECTOR (4 downto 0):="00000";
signal n : INTEGER range 0 to 4;
begin
process (CLK_1ms)
 begin
 if (CLK_1ms'event and CLK_1ms='1') then
 case ST is
 when SIMBOLO =>
 s_ncod<=s_ncod+1;
 s_cod(n)<=C1; -- el resultado del comparador indica punto o raya
 n<=n-1;
 ST<=ESPERA;
 
 when ESPERA =>
 if (valid='1' and dato='1') then
 ST<=SIMBOLO;
 elsif(valid='1' and dato='0' and C0='0') then
 ST<=ESPERA;
  elsif(valid='1' and dato='0' and C0='1') then
 ST<=ESPACIO;
	end if;
 when ESPACIO =>
 ST<=RESET;
 

 when RESET =>
 n <= 4;
 s_ncod<="000";
 s_cod<="00000";
 if (VALID='1' and dato='1') then
 ST<=SIMBOLO;
 else
 ST<=RESET;
 end if;

 end case;
 end if;
 end process;

-- PARTE COMBINACIONAL
VALID_DISP<='1' when (ST=ESPACIO)  else '0';
CODIGO(4 downto 0)<= s_cod; -- Complete las asignaciones
CODIGO(7 downto 5)<= s_ncod;

end a_aut_control;