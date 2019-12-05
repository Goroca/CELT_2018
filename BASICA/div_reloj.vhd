----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:56:35 10/07/2018 
-- Design Name: 
-- Module Name:    div_reloj - Behavioral 
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
entity div_reloj is
 Port ( CLK : in STD_LOGIC; -- Entrada reloj de la FPGA 50 MHz
 CLK_1ms : out STD_LOGIC); -- Salida reloj a 1 KHz
end div_reloj;
architecture a_div_reloj of div_reloj is
signal contador : STD_LOGIC_VECTOR (15 downto 0):="0000000000000000";
signal flag : STD_LOGIC:='0';
begin
process(CLK)
 begin
 if (CLK'event and CLK='1') then
 contador<=contador+1;
 if (contador=25000) then
 contador<=(others=>'0');
 flag<=not flag;
 end if;
 end if;
 end process;

CLK_1ms<=flag;
end a_div_reloj;