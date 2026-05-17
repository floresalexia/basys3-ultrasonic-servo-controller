-----------------------------------
-- Create Date: 04.05.2026 13:38:31
-- Module Name: tb_angle_mapper - Behavioral
-----------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_angle_mapper is
end tb_angle_mapper;

architecture Behavioral of tb_angle_mapper is

    signal distancia_cm      : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    signal seleccion_angulo  : STD_LOGIC_VECTOR(2 downto 0);

begin

    uut: entity work.angle_mapper
        port map (
            distancia_cm      => distancia_cm,
            seleccion_angulo => seleccion_angulo
        );

    process
    begin
        distancia_cm <= std_logic_vector(to_unsigned(5, 10));
        wait for 20 ns;

        distancia_cm <= std_logic_vector(to_unsigned(15, 10));
        wait for 20 ns;

        distancia_cm <= std_logic_vector(to_unsigned(45, 10));
        wait for 20 ns;

        distancia_cm <= std_logic_vector(to_unsigned(75, 10));
        wait for 20 ns;

        distancia_cm <= std_logic_vector(to_unsigned(120, 10));
        wait for 20 ns;

        
        -- Casos frontera
        distancia_cm <= std_logic_vector(to_unsigned(10, 10));
        wait for 20 ns;

        distancia_cm <= std_logic_vector(to_unsigned(30, 10));
        wait for 20 ns;

        distancia_cm <= std_logic_vector(to_unsigned(60, 10));
        wait for 20 ns;

        distancia_cm <= std_logic_vector(to_unsigned(100, 10));
        wait for 20 ns;

        wait;
    end process;

end Behavioral;