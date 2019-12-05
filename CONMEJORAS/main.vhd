----------------------------------------------------------------------------------
-- MAIN
--
-- Modulo principal que contiene como modulos 
-- secundarios el Generador de senal y el receptor.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main is
Port( CLK : in STD_LOGIC;
		BTN_START : in STD_LOGIC; -- Acciona la reproduccin del mensaje automtico.
		BTN_STOP : in STD_LOGIC; -- Para la reproduccin del mensaje automtico
		RESET0 : in STD_LOGIC; --Resetea los displays
		PULSADOR : in STD_LOGIC;--Reactiva la recepcion de un mensaje
		SELECTOR: in STD_LOGIC; --Mostrar mensaje o numero de palabras
		SPI_CLK : out STD_LOGIC;
	   SPI_DIN : out STD_LOGIC;
		SPI_CS1 : out STD_LOGIC;
		LIN : in STD_LOGIC; -- Lnea de entrada de datos
		AN : out STD_LOGIC_VECTOR (3 downto 0); -- Activacion individual displays
		SEG7 : out STD_LOGIC_VECTOR (0 to 6); -- Salida para los displays
		LED : out STD_LOGIC); --Indica el fin del mensaje
end main;

architecture a_main of main is
component GEN_SENAL is
 Port( CLK : in  STD_LOGIC;
		 BTN0 : in  STD_LOGIC;-- acciona la reproduccin del mensaje automtico.
		 BTN1 : in  STD_LOGIC;-- para la reproduccin del mensaje automtico.
       SPI_CLK : out STD_LOGIC;
       SPI_DIN : out STD_LOGIC;     -- DATA_IN
		 SPI_CS1 : out STD_LOGIC);    -- CHIP_SELECT

end component;

component receptor
 Port( CLK : in STD_LOGIC; -- reloj de la FPGA
		 LIN : in STD_LOGIC; -- Lnea de entrada de datos
		 RESET0 : in STD_LOGIC;
		 PULSADOR: in STD_LOGIC;
		 SELECTOR: in STD_LOGIC;
		 AN : out STD_LOGIC_VECTOR (3 downto 0); -- Activacin individual
		 SEG7 : out STD_LOGIC_VECTOR (0 to 6); -- Salida para los displays
		 LED :out STD_LOGIC);
end component;

begin
U1 : gen_senal port map
 (CLK => CLK,
  BTN0 => BTN_START,
  BTN1 => BTN_STOP,
  SPI_CLK => SPI_CLK,
  SPI_DIN => SPI_DIN,
  SPI_CS1 => SPI_CS1);
 
U2 : receptor port map
 (CLK => CLK,
  LIN => LIN,
  RESET0 => RESET0,
  PULSADOR => PULSADOR,
  SELECTOR=> SELECTOR,
  AN => AN,
  SEG7 => SEG7,
  LED => LED);
end a_main;