----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:12:05 11/01/2018 
-- Design Name: 
-- Module Name:    rdesp_disp - Behavioral 
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


entity rdesp_disp is
Port( CLK_1ms : in STD_LOGIC; -- entrada de reloj
 EN : in STD_LOGIC; -- enable
 E : in STD_LOGIC_VECTOR (7 downto 0); -- entrada de datos
 Q0 : out STD_LOGIC_VECTOR (7 downto 0); -- salida Q0
 Q1 : out STD_LOGIC_VECTOR (7 downto 0); -- salida Q1
 Q2 : out STD_LOGIC_VECTOR (7 downto 0); -- salida Q2
 Q3 : out STD_LOGIC_VECTOR (7 downto 0)); -- salida Q3
end rdesp_disp;
architecture rdesp_disp of rdesp_disp is

SIGNAL QS0: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL QS1: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL QS2: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL QS3: STD_LOGIC_VECTOR(7 DOWNTO 0);


begin
process(CLK_1ms)
begin
 if (CLK_1ms'event and CLK_1ms='1') then
 if(EN='1') then
  QS0<=QS1;
  QS1<=QS2;
  QS2<=QS3;
  QS3<=E;
 end if;
 end if; 
end process;

Q0<=QS0;
Q1<=QS1;
Q2<=QS2;
Q3<=QS3;
end rdesp_disp;

