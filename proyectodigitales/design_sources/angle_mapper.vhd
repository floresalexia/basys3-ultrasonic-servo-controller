-----------------------------------
-- Create Date: 04.05.2026 13:37:02
-- Module Name: angle_mapper - Behavioral
-----------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity angle_mapper is
    Port (
        distancia_cm : in  STD_LOGIC_VECTOR(9 downto 0);
        seleccion_angulo : out STD_LOGIC_VECTOR(2 downto 0)
    );
end angle_mapper;

architecture Behavioral of angle_mapper is

    signal distancia_int : integer range 0 to 1023;

begin

    distancia_int <= to_integer(unsigned(distancia_cm));

    process(distancia_int)
    begin
        if distancia_int < 10 then
            seleccion_angulo <= "000";   -- 0 grados

        elsif distancia_int < 30 then
            seleccion_angulo <= "001";   -- 45 grados

        elsif distancia_int < 60 then
            seleccion_angulo <= "010";   -- 90 grados

        elsif distancia_int < 100 then
            seleccion_angulo <= "011";   -- 135 grados

        else
            seleccion_angulo <= "100";   -- 180 grados

        end if;
    end process;

end Behavioral;


