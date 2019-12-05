----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:27:27 11/01/2018 
-- Design Name: 
-- Module Name:    MUX4x8 - MUX4x8 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX4x8 is
 Port ( E0 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada 0
 E1 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada 1
 E2 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada 2
 E3 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada 3
 S : in STD_LOGIC_VECTOR (1 downto 0); -- Seal de control
 Y : out STD_LOGIC_VECTOR (7 downto 0)); -- Salida
end MUX4x8;

architecture MUX4x8 of MUX4x8 is
begin
with S select Y<=
E0 when "00",
E1 when "01",
E2 when "10",
E3 when others;
end MUX4x8;

