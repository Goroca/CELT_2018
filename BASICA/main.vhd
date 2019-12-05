----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:14:41 11/06/2018 
-- Design Name: 
-- Module Name:    main - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main is
 Port ( CLK : in STD_LOGIC;
 BTN_START : in STD_LOGIC;
 BTN_STOP : in STD_LOGIC;
 SPI_CLK : out STD_LOGIC;
 SPI_DIN : out STD_LOGIC;
 SPI_CS1 : out STD_LOGIC;
 LIN : in STD_LOGIC; -- Lnea de entrada de datos
 AN : out STD_LOGIC_VECTOR (3 downto 0); -- Activacin individual displays
 SEG7 : out STD_LOGIC_VECTOR (0 to 6)); -- Salida para los displays
end main;
architecture a_main of main is


component GEN_SENAL is

    Port ( CLK : in  STD_LOGIC;
			  BTN_START : in  STD_LOGIC;-- acciona la reproducción del mensaje automático.
			  BTN_STOP : in  STD_LOGIC;-- para la reproducción del mensaje automático.
           SPI_CLK : out STD_LOGIC;
           SPI_DIN : out STD_LOGIC;     -- DATA_IN
			  SPI_CS1 : out STD_LOGIC);    -- CHIP_SELECT

end component;

component receptor
 Port ( CLK : in STD_LOGIC; -- reloj de la FPGA
 LIN : in STD_LOGIC; -- Lnea de entrada de datos
 AN : out STD_LOGIC_VECTOR (3 downto 0); -- Activacin individual
 SEG7 : out STD_LOGIC_VECTOR (0 to 6)); -- Salida para los displays
end component;
begin
U1 : gen_senal port map
 (CLK => CLK,
 BTN_START => BTN_START,
 BTN_STOP => BTN_STOP,
 SPI_CLK => SPI_CLK,
 SPI_DIN => SPI_DIN,
 SPI_CS1 => SPI_CS1);
U2 : receptor port map
 (CLK => CLK,
 LIN => LIN,
 AN => AN,
 SEG7 => SEG7);
end a_main;