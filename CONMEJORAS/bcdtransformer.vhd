-----------------------------------------------
-- BCD TRANSFORMER
-- Transforma de 0 a 511 de binario a bcd
-- 
-----------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity bintobcd is
  PORT( num_bin: in  STD_LOGIC_VECTOR(8 downto 0);
		  centenas: out STD_LOGIC_VECTOR(7 downto 0);
		  decenas: out STD_LOGIC_VECTOR(7 downto 0);
		  unidades: out STD_LOGIC_VECTOR(7 downto 0));
end bintobcd;
 
architecture Behavioral of bintobcd is
SIGNAL num_bcd: STD_LOGIC_VECTOR(10 downto 0);
begin
   proceso_bcd: process(num_bin)
   variable z: STD_LOGIC_VECTOR(19 downto 0);
    begin
        -- Inicializacin de datos en cero.
        z := (others => '0');
        -- Se realizan los primeros tres corrimientos.
        z(11 downto 3) := num_bin;
        for i in 0 to 5 loop
            -- Unidades (4 bits).
            if z(12 downto 9) > 4 then
                z(12 downto 9) := z(12 downto 9) + 3;
            end if;
            -- Decenas (4 bits).
            if z(16 downto 13) > 4 then
                z(16 downto 13) := z(16 downto 13) + 3;
            end if;
            -- Centenas (3 bits).
            if z(19 downto 17) > 4 then
                z(19 downto 17) := z(19 downto 17) + 3;
            end if;
            -- Corrimiento a la izquierda.
            z(19 downto 1) := z(18 downto 0);
        end loop;
        -- Pasando datos de variable Z, correspondiente a BCD.
        num_bcd <= z(19 downto 9);
    end process;

 -- Parte combinacional
 centenas(7 downto 3)<="00000";
 decenas(7 downto 4)<="0000";
 unidades(7 downto 4)<="0000";
 centenas(2 downto 0)<=num_bcd(10 downto 8);
 decenas(3 downto 0)<=num_bcd(7 downto 4);
 unidades(3 downto 0)<=num_bcd(3 downto 0); 
end Behavioral;