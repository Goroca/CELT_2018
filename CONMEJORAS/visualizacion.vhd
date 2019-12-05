----------------------------------------------------------------------------------
-- VISUALIZACION
--
-- Tiene como entradas los simbolos
-- en morse y como salidas la activacion 
-- del display y el segmento correspondiente a estos.
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity visualizacion is
Port( E0 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada sig. carcter
		EN : in STD_LOGIC; -- Activacin para desplazamiento
		CLK_1ms : in STD_LOGIC; -- Entrada de reloj
		RESET0 : in STD_LOGIC;
		SELECTOR: in STD_LOGIC;
		CENTENAS: in STD_LOGIC_VECTOR(7 downto 0);
		DECENAS: in STD_LOGIC_VECTOR(7 downto 0);
		UNIDADES: in STD_LOGIC_VECTOR(7 downto 0);
		SEG7 : out STD_LOGIC_VECTOR (0 to 6); -- Segmentos displays
		AN : out STD_LOGIC_VECTOR (3 downto 0)); -- Activacion displays
end visualizacion;

architecture a_visualizacion of visualizacion is
component MUX4x8
 Port ( E0 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada 0
 E1 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada 1
 E2 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada 2
 E3 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada 3
 S : in STD_LOGIC_VECTOR (1 downto 0); -- Seal de control
 Y : out STD_LOGIC_VECTOR (7 downto 0)); -- Salida
end component;

component decodmorsea7s
 Port ( SIMBOLO : in STD_LOGIC_VECTOR (7 downto 0);
 SEGMENTOS : out STD_LOGIC_VECTOR (0 to 6));
end component
;
component refresco
 Port ( CLK_1ms : in STD_LOGIC; -- reloj
 S : out STD_LOGIC_VECTOR (1 downto 0); -- Control para el mux
 AN : out STD_LOGIC_VECTOR (3 downto 0)); -- Control displays
end component;

component rdesp_disp
 Port ( CLK_1ms : in STD_LOGIC; -- entrada de reloj
 EN : in STD_LOGIC; -- enable
 E : in STD_LOGIC_VECTOR (7 downto 0); -- entrada de datos
 RESET0 : in STD_LOGIC;
 SELECTOR: in STD_LOGIC;
 CENTENAS: in STD_LOGIC_VECTOR(7 downto 0);
 DECENAS: in STD_LOGIC_VECTOR(7 downto 0);
 UNIDADES: in STD_LOGIC_VECTOR(7 downto 0);
 Q0 : out STD_LOGIC_VECTOR (7 downto 0); -- salida Q0
 Q1 : out STD_LOGIC_VECTOR (7 downto 0); -- salida Q1
 Q2 : out STD_LOGIC_VECTOR (7 downto 0); -- salida Q2
 Q3 : out STD_LOGIC_VECTOR (7 downto 0)); -- salida Q3
end component;

SIGNAL Q0: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL Q1: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL Q2: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL Q3: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL S0: STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL Y: STD_LOGIC_VECTOR (7 DOWNTO 0);

begin

H1: rdesp_disp port map (CLK_1ms,EN,E0,RESET0,SELECTOR,CENTENAS,DECENAS,UNIDADES,Q0,Q1,Q2,Q3);
H2: refresco port map(CLK_1ms, S0,AN);
H3: MUX4x8 port map(Q0,Q1,Q2,Q3,S0,Y);
H4: decodmorsea7s port map(Y,SEG7);

end a_visualizacion;

