----------------------------------------------------------------------------------
-- AUTOMATA DURACION
--
-- Este automata consigue mediante la entrada ('0' o '1') y el tiempo que esta dura 
-- distinguir entre las cuatro posibles senales (RAYA, PUNTO, PAUSA O ESPACIO).
-- Si DATO vale 1 se trata de PUNTO o RAYA y si vale 0 se trata de PAUSA o ESPACIO
-- Si DURACION es mayor que un umbral estarmos mandando RAYA O ESPACIO
-- y si es menor estaremos mandando PAUSA O PUNTO.
-- Las salidas solo se usaran cuando se valide: VALID='1'.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity aut_duracion is
  Port ( CLK_1ms : in  STD_LOGIC;
         ENTRADA : in  STD_LOGIC;
         VALID : out  STD_LOGIC;
         DATO : out  STD_LOGIC;
         DURACION : out  STD_LOGIC_VECTOR (15 downto 0));
end aut_duracion;

architecture a_aut_duracion of aut_duracion is
type STATE_TYPE is (CERO,ALM_CERO,VALID_CERO,UNO,ALM_UNO,VALID_UNO,VALID_FIN);
signal ST : STATE_TYPE := CERO;
signal cont : STD_LOGIC_VECTOR (15 downto 0):="0000000000000000";
signal reg : STD_LOGIC_VECTOR (15 downto 0) :="0000000000000000";

begin
process (CLK_1ms)
 begin
 if (CLK_1ms'event and CLK_1ms='1') then --Cada milisegundo
 case ST is
	when CERO =>
		cont<=cont+1; -- Almacena el tiempo en ms que lleva recibiendo '0'
		if (cont>1400) then --Si la cuenta sobrepasa este tiempo es que no se esta recibiendo nada
			ST<=VALID_FIN;
		elsif (ENTRADA='0') then
			ST<=CERO;
		else
			ST<=ALM_CERO; -- Cuando se recibe un '1' estado recibiendo '0'
		end if;			  -- el automata cambia de estado 

	when ALM_CERO =>
		reg<=cont; --Guarda el tiempo que ha estado en '0'
		cont<=(others=>'0');
		ST<= VALID_CERO;

	when VALID_CERO =>
		ST<= UNO; -- Valida el '0'
	
	when UNO=>
		cont<=cont+1; -- Almacena el tiempo en ms que lleva recibiendo '0'
		if (ENTRADA='0') then
			ST<=ALM_UNO; -- Cuando se recibe un '0' estado recibiendo '1'
		else				 -- el automata cambia de estado 
			ST<=UNO;
		end if;

	when ALM_UNO =>
		reg<=cont; --Actualiza el contador
		cont<=(others=>'0');
		ST<= VALID_UNO;

	when VALID_UNO =>
		ST<= CERO; --Valida el dato
	
	when VALID_FIN =>
		reg<=cont;
		cont<=(others=>'0'); --Resetea el contador
		ST<= CERO;
  end case;
 end if;
 end process;
 
 -- PARTE COMBINACIONAL
 VALID<='1' when (ST=VALID_CERO or ST=VALID_UNO or ST=VALID_FIN) else '0';
 DATO <='1' when (ST=UNO or ST=VALID_UNO or ST=ALM_UNO) else '0';
 DURACION<= reg;

end a_aut_duracion;

