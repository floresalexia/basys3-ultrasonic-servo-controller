-----------------------------------
-- Create Date: 04.05.2026 14:32:25
-- Module Name: tb_angle_value_converter - Behavioral
-----------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_angle_value_converter is
end tb_angle_value_converter;

architecture Behavioral of tb_angle_value_converter is

    signal seleccion_angulo : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal valor_angulo     : STD_LOGIC_VECTOR(9 downto 0);

begin

    uut: entity work.angle_value_converter
        port map (
            seleccion_angulo => seleccion_angulo,
            valor_angulo     => valor_angulo
        );

    process
    begin
        seleccion_angulo <= "000";
        wait for 20 ns;

        seleccion_angulo <= "001";
        wait for 20 ns;

        seleccion_angulo <= "010";
        wait for 20 ns;

        seleccion_angulo <= "011";
        wait for 20 ns;

        seleccion_angulo <= "100";
        wait for 20 ns;

        
        -- Caso inválido, debe regresar 0
        seleccion_angulo <= "111";
        wait for 20 ns;

        wait;
    end process;

end Behavioral;