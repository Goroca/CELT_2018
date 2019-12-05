----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:30:12 10/07/2018 
-- Design Name: 
-- Module Name:    receptor - Behavioral 
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


entity receptor is
    Port ( CLK : in  STD_LOGIC;
           LIN : in  STD_LOGIC;
           AN : out  STD_LOGIC_VECTOR (3 downto 0);
           SEG7 : out  STD_LOGIC_VECTOR (0 to 6));
end receptor;
architecture Behavioral of receptor is
constant UMBRAL0 : STD_LOGIC_VECTOR (15 downto 0) := "0000000011001000"; -- 200 umbral ceros
constant UMBRAL1 : STD_LOGIC_VECTOR (15 downto 0) := "0000000011001000"; -- 200 umbral unos
    SIGNAL CLK_1ms : STD_LOGIC;
    SIGNAL LIN2 : STD_LOGIC;
    SIGNAL VALID : STD_LOGIC;
    SIGNAL DATO : STD_LOGIC;
    SIGNAL DURACION : STD_LOGIC_VECTOR (15 downto 0);
    SIGNAL C0 : STD_LOGIC;
    SIGNAL C1 : STD_LOGIC;
    SIGNAL CODIGO : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL VALID_DISP : STD_LOGIC;

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
 Port ( CLK_1ms : in STD_LOGIC; -- reloj
 VALID : in STD_LOGIC; -- entrada de dato vlido
 DATO : in STD_LOGIC; -- dato (0 o 1)
 C0 : in STD_LOGIC; -- resultado comparador de ceros
 C1 : in STD_LOGIC; -- resultado comparador de unos
 CODIGO : out STD_LOGIC_VECTOR (7 downto 0); -- cdigo morse obtenido
 VALID_DISP : out STD_LOGIC); -- validacin del display
end component;

component visualizacion is
 Port ( E0 : in STD_LOGIC_VECTOR (7 downto 0); -- Entrada sig. carcter
 EN : in STD_LOGIC; -- Activacin para desplazamiento
 CLK_1ms : in STD_LOGIC; -- Entrada de reloj
 SEG7 : out STD_LOGIC_VECTOR (0 to 6); -- Segmentos displays
 AN : out STD_LOGIC_VECTOR (3 downto 0)); -- Activacin displays
end component;

begin
H1: div_reloj port map (CLK,CLK_1ms);
H2: detector_flanco port map (CLK_1ms, LIN,LIN2);
H3: aut_duracion port map (CLK_1ms, LIN2, VALID, DATO, DURACION);
H4: comp_16 port map (DURACION,UMBRAL0,C0);
H5: comp_16 port map (DURACION,UMBRAL1,C1);
H6: aut_control port map (CLK_1ms,VALID,DATO,C0,C1,CODIGO,VALID_DISP);
H7: visualizacion port map(CODIGO,VALID_DISP,CLK_1ms, SEG7,AN);
end Behavioral;

