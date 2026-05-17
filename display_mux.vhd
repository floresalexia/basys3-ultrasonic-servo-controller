-----------------------------------
-- Create Date: 04.05.2026 14:05:49
-- Module Name: display_mux - Behavioral
-----------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity display_mux is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;

        millares  : in  STD_LOGIC_VECTOR(3 downto 0);
        centenas  : in  STD_LOGIC_VECTOR(3 downto 0);
        decenas   : in  STD_LOGIC_VECTOR(3 downto 0);
        unidades  : in  STD_LOGIC_VECTOR(3 downto 0);

        an        : out STD_LOGIC_VECTOR(3 downto 0);
        seg       : out STD_LOGIC_VECTOR(6 downto 0)
    );
end display_mux;

architecture Behavioral of display_mux is

    signal contador_reinicio : unsigned(15 downto 0) := (others => '0');
    signal seleccion_digito  : STD_LOGIC_VECTOR(1 downto 0);
    signal digito_actual     : STD_LOGIC_VECTOR(3 downto 0);

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                contador_reinicio <= (others => '0');
            else
                contador_reinicio <= contador_reinicio + 1;
            end if;
        end if;
    end process;

    seleccion_digito <= std_logic_vector(contador_reinicio(15 downto 14));

    process(seleccion_digito, millares, centenas, decenas, unidades)
    begin
        case seleccion_digito is

            when "00" =>
                an <= "1110";
                digito_actual <= unidades;

            when "01" =>
                an <= "1101";
                digito_actual <= decenas;

            when "10" =>
                an <= "1011";
                digito_actual <= centenas;

            when others =>
                an <= "0111";
                digito_actual <= millares;

        end case;
    end process;

    process(digito_actual)
    begin
        case digito_actual is
            when "0000" => seg <= "1000000"; -- 0
            when "0001" => seg <= "1111001"; -- 1
            when "0010" => seg <= "0100100"; -- 2
            when "0011" => seg <= "0110000"; -- 3
            when "0100" => seg <= "0011001"; -- 4
            when "0101" => seg <= "0010010"; -- 5
            when "0110" => seg <= "0000010"; -- 6
            when "0111" => seg <= "1111000"; -- 7
            when "1000" => seg <= "0000000"; -- 8
            when "1001" => seg <= "0010000"; -- 9
            when others => seg <= "1111111"; -- Apagado
        end case;
    end process;

end Behavioral;
