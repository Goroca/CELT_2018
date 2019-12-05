----------------------------------------------------------------------------------
-- RECEPTOR
-- Contiene diferentes modulos
-- que transforman la seal binaria
-- en simbolos morse y un modulo de
-- visualizacion que transforma cada simblolo
-- en un digito del display
-- 
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity receptor is
Port ( CLK : in  STD_LOGIC; --Reloj con periodo de 20 ns
       LIN : in  STD_LOGIC; --Entrada de Datos
		 RESET0 : in STD_LOGIC; --Reset asincrono
		 PULSADOR : in STD_LOGIC; -- Pone de nuevo el display en funcionamiento
		 SELECTOR: in STD_LOGIC; --Mostrar mensaje o numero de palabras
       AN : out  STD_LOGIC_VECTOR (3 downto 0); -- Activacion individual displays
       SEG7 : out  STD_LOGIC_VECTOR (0 to 6); -- Salida para los displays
		 LED : out STD_LOGIC); --Indica el fin del mensaje
end receptor;

architecture Behavioral of receptor is
constant UMBRAL0 : STD_LOGIC_VECTOR (15 downto 0) := "0000000011001000"; -- 200 umbral ceros
constant UMBRAL1 : STD_LOGIC_VECTOR (15 downto 0) := "0000000011001000"; -- 200 umbral unos
constant UMBRALS : STD_LOGIC_VECTOR (15 downto 0) := "0000000111110100"; -- 500 umbral ceros (SEPARADOR)
	SIGNAL CLK_1ms : STD_LOGIC;
	SIGNAL LIN2 : STD_LOGIC;
	SIGNAL VALID : STD_LOGIC;
	SIGNAL DATO : STD_LOGIC;
	SIGNAL DURACION : STD_LOGIC_VECTOR (15 downto 0);
	SIGNAL C0 : STD_LOGIC;
	SIGNAL C1 : STD_LOGIC;
	SIGNAL CS : STD_LOGIC;
	SIGNAL CODIGO : STD_LOGIC_VECTOR (7 downto 0);
	SIGNAL VALID_DISP : STD_LOGIC;
	SIGNAL FINAL : STD_LOGIC;
	SIGNAL CONTADOR : STD_LOGIC_VECTOR (8 downto 0);
	SIGNAL CENTENAS : STD_LOGIC_VECTOR (7 downto 0);
	SIGNAL DECENAS : STD_LOGIC_VECTOR (7 downto 0);
	SIGNAL UNIDADES : STD_LOGIC_VECTOR (7 downto 0);
	 
component div_reloj is
Port ( CLK : in  STD_LOGIC;
       CLK_1ms : out  STD_LOGIC);
end component;

component detector_flanco is
Port ( CLK_1ms : in STD_LOGIC; -- reloj
		 LIN : in STD_LOGIC; -- Lnea de datos
		 VALOR : out STD_LOGIC); -- Valor detectado en el flanco
end component;

component aut_duracion is
Port ( CLK_1ms : in  STD_LOGIC;
       ENTRADA : in  STD_LOGIC;
       VALID : out  STD_LOGIC;
       DATO : out  STD_LOGIC;
       DURACION : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component comp_16 is
Port ( P : in  STD_LOGIC_VECTOR (15 downto 0);
       Q : in  STD_LOGIC_VECTOR (15 downto 0);
       P_GT_Q : out  STD_LOGIC);
end component;

component aut_control is
Port( CLK_1ms : in STD_LOGIC; -- reloj
		VALID : in STD_LOGIC; -- entrada de dato vlido
		DATO : in STD_LOGIC; -- dato (0 o 1)
		C0 : in STD_LOGIC; -- resultado comparador de ceros
		C1 : in STD_LOGIC; -- resultado comparador de unos
		CS : in STD_LOGIC; -- resultado comparador de espacios
		RESET0 : in STD_LOGIC;
		PULSADOR : in STD_LOGIc;
		FINAL : in STD_LOGIc;
		CODIGO : out STD_LOGIC_VECTOR (7 downto 0); -- cdigo morse obtenido
		VALID_DISP : out STD_LOGIC;-- validacin del display
		LED : out STD_LOGIC;
		CONTADOR: out STD_LOGIC_VECTOR(8 downto 0));
end component;

component visualizacion is
 Port( E0 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada sig. carcter
		 EN : in STD_LOGIC; -- Activacin para desplazamiento
  		 CLK_1ms : in STD_LOGIC; -- Entrada de reloj
		 RESET0 : in STD_LOGIC;
		 SELECTOR: in STD_LOGIC;
		 CENTENAS: in STD_LOGIC_VECTOR(7 downto 0);
		 DECENAS: in STD_LOGIC_VECTOR(7 downto 0);
		 UNIDADES: in STD_LOGIC_VECTOR(7 downto 0);
 		 SEG7 : out STD_LOGIC_VECTOR (0 to 6); -- Segmentos displays
	 	 AN : out STD_LOGIC_VECTOR (3 downto 0)); -- Activacin displays
end component;

component Deteccionfin is
 Port( CLK_1ms : in STD_LOGIC;
		 CODIGO : in STD_LOGIC_VECTOR (7 downto 0); -- cdigo morse obtenido
		 VALID_DISP : in STD_LOGIC;
		 FINAL : out STD_LOGIC );
end component;

component bintobcd is
 Port( num_bin: in  STD_LOGIC_VECTOR(8 downto 0);
		 centenas: out STD_LOGIC_VECTOR(7 downto 0);
		 decenas: out STD_LOGIC_VECTOR(7 downto 0);
		 unidades: out STD_LOGIC_VECTOR(7 downto 0));
end component;

begin
H1: div_reloj port map (CLK,CLK_1ms);
H2: detector_flanco port map (CLK_1ms, LIN,LIN2);
H3: aut_duracion port map (CLK_1ms, LIN2, VALID, DATO, DURACION);
H4: comp_16 port map (DURACION,UMBRAL0,C0);
H5: comp_16 port map (DURACION,UMBRAL1,C1);
HS: comp_16 port map (DURACION,UMBRALS,CS);
H6: aut_control port map (CLK_1ms,VALID,DATO,C0,C1,CS,RESET0,PULSADOR,FINAL,CODIGO,VALID_DISP,LED,CONTADOR);
M4: bintobcd port map (CONTADOR,CENTENAS,DECENAS,UNIDADES);
HF: Deteccionfin port map (CLK_1ms, CODIGO, VALID_DISP,FINAL);
H7: visualizacion port map(CODIGO,VALID_DISP,CLK_1ms,RESET0,SELECTOR,CENTENAS,DECENAS,UNIDADES,SEG7,AN);
end Behavioral;

