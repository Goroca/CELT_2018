----------------------------------------------------------------------------------
-- AUTOMATA DE CONTROL
--
-- Genera una seal con 8 bits
-- Los primeros 3 bits numeran la cantidad de PUNTOS y RAYAS de cada palabra  
-- Los ultimos 5 bits representan de izquierda a derecha cada simbolo,
-- un '0' sera un PUNTO y un '1' sera una RAYA.
-- Cada palabra acaba cuando el automata alcanza el estado ESPACIO,
-- que es cuando se valida.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity aut_control is
Port( CLK_1ms : in STD_LOGIC; -- reloj
		VALID : in STD_LOGIC; -- entrada de dato vlido
		DATO : in STD_LOGIC; -- dato (0 o 1)
		C0 : in STD_LOGIC; -- resultado comparador de ceros
		C1 : in STD_LOGIC; -- resultado comparador de unos
		CS : in STD_LOGIC; -- resultado comparador de espacios
		RESET0 : in STD_LOGIC;
		PULSADOR : in STD_LOGIC;
		FINAL : in STD_LOGIc;
		CODIGO : out STD_LOGIC_VECTOR (7 downto 0); -- codigo morse obtenido
		VALID_DISP : out STD_LOGIC;
		LED : out STD_LOGIC;
		CONTADOR : out STD_LOGIC_VECTOR(8 downto 0)); 
end aut_control;

architecture a_aut_control of aut_control is
type STATE_TYPE is (ESPACIO,RESET,SIMBOLO,ESPERA, SEPARADOR,SEPARADOR_VALID,FIN);
signal ST : STATE_TYPE := RESET;
signal s_ncod : STD_LOGIC_VECTOR (2 downto 0):= "000";
signal s_cod : STD_LOGIC_VECTOR (4 downto 0):= "00000";
signal contador0: STD_LOGIC_VECTOR(8 downto 0) := "000000000";
signal n : INTEGER range 0 to 4;

begin
process (CLK_1ms, RESET0)
 begin
 if (RESET0 = '1') then --RESET asincrono
	contador0<= "000000000"; --Resetea el contador de palabras
	ST<=RESET; -- Pone el automata listo para recibir un nuevo simbolo
 
 elsif (CLK_1ms'event and CLK_1ms='1') then
 case ST is
 when SIMBOLO => --Se ha recibido un punto o una raya
	s_ncod<=s_ncod+1; --Suma 1 al numero de datos recibidos dentro de la mismo simbolo
	s_cod(n)<=C1; -- El resultado del comparador indica si el simbolo punto o raya
	n<=n-1; --Todo simbolo no puede tener mas de 5 datos
	ST<=ESPERA;
 
 when ESPERA => -- Esperando un nuevo simbolo
	if (valid='1' and dato='1') then -- Si se ha recibido un dato
		ST<=SIMBOLO;
	elsif(valid='1' and dato='0' and C0='0') then -- Si no se ha recibido nada
		ST<=ESPERA;
	elsif(valid='1' and dato='0' and C0='1') then -- Si el simbolo ha terminado
		ST<=ESPACIO;
	end if;
	
 when ESPACIO => -- VALIDA EL SIMBOLO
	-- Detector de FIN de mensaje basico
	-- if(s_ncod="011" and s_cod="10100") then
	--	ST<=FIN;
	if (CS='1') then -- Si el espacio que ha acabado el dato es de 700ms
		ST<=SEPARADOR;
	else
		ST<=RESET; -- Preparacion para recibir un nuevo simbolo
	end if;
 
 when SEPARADOR => -- Se ha acabado la palabra
	s_ncod<="010"; -- Letra M (Display apagado)
	s_cod<="11000";
	contador0<= contador0 + 1; -- Suma 1 al numero de palabras
	ST<= SEPARADOR_VALID;

 when SEPARADOR_VALID=> -- Valida el simbolo de SEPARADOR
	ST<= RESET;

 when RESET => --Prepara el automata para recibir un nuevo simbolo
	n <= 4;
	s_ncod<="000";
	s_cod<="00000";
 
	if(FINAL='1') then -- Si el mensaje ha terminado
		ST<= FIN;
	elsif (VALID='1' and dato='1') then ---Si se ha recibido un simbolo
		ST<=SIMBOLO;
	else
		ST<=RESET;
 end if;
 
 when FIN =>
 	n <= 4;
	s_ncod<="000";
	s_cod<="00000";
	if (PULSADOR='1') then --Cuando el punsador valga '1'
		ST<=ESPERA; 		  -- se reactiva el automata.
	else
		ST <= FIN;
	end if;
 end case;
 end if;
end process;

-- PARTE COMBINACIONAL
LED <='1' when (ST=FIN) else '0';
VALID_DISP<='1' when (ST=ESPACIO or ST=SEPARADOR_VALID)  else '0';
CODIGO(4 downto 0)<= s_cod;
CODIGO(7 downto 5)<= s_ncod;
CONTADOR <= contador0;
end a_aut_control;