----------------------------------------------------------------------------------
-- REGISTRO DESPLAZAMIENTO 
-- 
-- Este modulo desplaza las senales
-- eliminando la mas antigua y andiendo
-- la nueva senal cada vez que EN vale '1'
-- que es cuando ha llegado un simbolo nuevo
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
		RESET0 : in STD_LOGIC;
		SELECTOR : in STD_LOGIC; --Selecciona entre el mensaje y el numero de palabras
		CENTENAS : in STD_LOGIC_VECTOR(7 downto 0);
		DECENAS : in STD_LOGIC_VECTOR(7 downto 0);
		UNIDADES : in STD_LOGIC_VECTOR(7 downto 0);
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
process(CLK_1ms,RESET0) -- Reset asincrono
begin
 if(RESET0='1') then -- Cuando el reset esta a '1'
  QS0<="01110100";   -- ponemos un simbolo cuya sepresentacion sean 
  QS1<="01110100";   -- todos los displays apagados.
  QS2<="01110100";
  QS3<="01110100";
 elsif (CLK_1ms'event and CLK_1ms='1') then
	if(EN='1') then -- Cuando llega un nuevo simbolo
		QS0<=QS1;    -- se hace el desplazamiento
		QS1<=QS2; 
		QS2<=QS3; 
		QS3<=E;   --Introduce el nuevo simbolo
	end if;
 end if; 
end process;
-- MUX con SELECTOR como bit de control
Q0<= QS0 when (SELECTOR='1') else "01110100"; -- Si no esta mostrando el mensaje esta apagado
Q1<= QS1 when (SELECTOR='1') else CENTENAS;
Q2<= QS2 when (SELECTOR='1') else DECENAS;
Q3<= QS3 when (SELECTOR='1') else UNIDADES;
end rdesp_disp;
