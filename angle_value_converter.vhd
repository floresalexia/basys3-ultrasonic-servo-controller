-----------------------------------
-- Create Date: 04.05.2026 14:30:57
-- Module Name: angle_value_converter - Behavioral
-----------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity angle_value_converter is
    Port (
        seleccion_angulo : in  STD_LOGIC_VECTOR(2 downto 0);
        valor_angulo     : out STD_LOGIC_VECTOR(9 downto 0)
    );
end angle_value_converter;

architecture Behavioral of angle_value_converter is
begin

    process(seleccion_angulo)
    begin
        case seleccion_angulo is

            when "000" =>
                valor_angulo <= std_logic_vector(to_unsigned(0, 10));

            when "001" =>
                valor_angulo <= std_logic_vector(to_unsigned(45, 10));

            when "010" =>
                valor_angulo <= std_logic_vector(to_unsigned(90, 10));

            when "011" =>
                valor_angulo <= std_logic_vector(to_unsigned(135, 10));

            when "100" =>
                valor_angulo <= std_logic_vector(to_unsigned(180, 10));

            when others =>
                valor_angulo <= std_logic_vector(to_unsigned(0, 10));

        end case;
    end process;

end Behavioral;