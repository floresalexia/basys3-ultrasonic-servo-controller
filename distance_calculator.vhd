-----------------------------------
-- Create Date: 04.05.2026 14:26:54
-- Module Name: distance_calculator - Behavioral
-----------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity distance_calculator is
    Port (
        clk            : in  STD_LOGIC;
        reset          : in  STD_LOGIC;
        medicion_lista : in  STD_LOGIC;
        conteo_echo    : in  STD_LOGIC_VECTOR(21 downto 0);
        distancia_cm   : out STD_LOGIC_VECTOR(9 downto 0)
    );
end distance_calculator;

architecture Behavioral of distance_calculator is

    -- Cantidad aproximada de ciclos de reloj por centímetro
    constant CICLOS_POR_CM : integer := 5831;

    constant CICLOS_POR_CM_U : unsigned(22 downto 0) :=
        to_unsigned(CICLOS_POR_CM, 23);

    constant MEDIO_CM_U : unsigned(22 downto 0) :=
        to_unsigned(CICLOS_POR_CM / 2, 23);

    signal distancia_reg : unsigned(9 downto 0) := (others => '0');

    signal restante      : unsigned(22 downto 0) := (others => '0');
    signal distancia_tmp : unsigned(9 downto 0) := (others => '0');
    signal calculando    : STD_LOGIC := '0';

begin

    distancia_cm <= std_logic_vector(distancia_reg);

    process(clk)
    begin
        if rising_edge(clk) then

            if reset = '1' then
                distancia_reg <= (others => '0');
                restante      <= (others => '0');
                distancia_tmp <= (others => '0');
                calculando    <= '0';

            else

                if medicion_lista = '1' then

                    restante <= resize(unsigned(conteo_echo), 23) + MEDIO_CM_U;
                    distancia_tmp <= (others => '0');
                    calculando <= '1';

                elsif calculando = '1' then

                    if distancia_tmp = to_unsigned(1023, 10) then
                        distancia_reg <= distancia_tmp;
                        calculando <= '0';

                    elsif restante >= CICLOS_POR_CM_U then
                        restante <= restante - CICLOS_POR_CM_U;
                        distancia_tmp <= distancia_tmp + 1;

                    else
                        distancia_reg <= distancia_tmp;
                        calculando <= '0';

                    end if;

                end if;

            end if;

        end if;
    end process;

end Behavioral;