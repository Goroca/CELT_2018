----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:20:39 10/30/2018 
-- Design Name: 
-- Module Name:    comp_16 - Behavioral 
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

