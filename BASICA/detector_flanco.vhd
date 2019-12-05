----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:23:47 10/07/2018 
-- Design Name: 
-- Module Name:    detector_flanco - Behavioral 
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

entity detector_flanco is
 Port ( CLK_1ms : in STD_LOGIC; -- reloj
 LIN : in STD_LOGIC; -- Lnea de datos
 VALOR : out STD_LOGIC); -- Valor detectado en el flanco
end detector_flanco;
architecture a_detector_flanco of detector_flanco is
constant UMBRAL0 : STD_LOGIC_VECTOR (7 downto 0) := "00000101"; -- 5 umbral para el 0
constant UMBRAL1 : STD_LOGIC_VECTOR (7 downto 0) := "00001111"; -- 15 umbral para el 1
signal reg_desp : STD_LOGIC_VECTOR (19 downto 0):="00000000000000000000";
signal suma : STD_LOGIC_VECTOR (7 downto 0) :="00000000";
signal s_valor : STD_LOGIC :='0';
begin
 process (CLK_1ms)
 begin
 if (CLK_1ms'event and CLK_1ms='1') then
 suma <= suma +LIN -reg_desp(19);

 reg_desp (19) <=reg_desp(18); 
 reg_desp (18) <=reg_desp(17);
 reg_desp (17) <=reg_desp(16);
 reg_desp (16) <=reg_desp(15);
 reg_desp (15) <=reg_desp(14);
 reg_desp (14) <=reg_desp(13);
 reg_desp (13) <=reg_desp(12);
 reg_desp (12) <=reg_desp(11);
 reg_desp (11) <=reg_desp(10);
 reg_desp (10) <=reg_desp(9);
 reg_desp (9) <=reg_desp(8);
 reg_desp (8) <=reg_desp(7);
 reg_desp (7) <=reg_desp(6);
 reg_desp (6) <=reg_desp(5);
 reg_desp (5) <=reg_desp(4);
 reg_desp (4) <=reg_desp(3);
 reg_desp (3) <=reg_desp(2);
 reg_desp (2) <=reg_desp(1);
 reg_desp (1) <=reg_desp(0);
 reg_desp (0) <= LIN;



 if(s_valor='1' and suma<UMBRAL0) then
	s_valor<='0';
 
 
 elsif(s_valor='0' and suma>UMBRAL1) then
	s_valor<='1';
	end if;
 end if;
 end process;
 VALOR<=s_valor;

end a_detector_flanco;