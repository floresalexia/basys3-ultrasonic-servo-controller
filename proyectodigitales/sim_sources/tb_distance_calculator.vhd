-----------------------------------
-- Create Date: 04.05.2026 14:27:32
-- Module Name: tb_distance_calculator - Behavioral
-----------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_distance_calculator is
end tb_distance_calculator;

architecture Behavioral of tb_distance_calculator is

    signal clk            : STD_LOGIC := '0';
    signal reset          : STD_LOGIC := '0';
    signal medicion_lista : STD_LOGIC := '0';
    signal conteo_echo    : STD_LOGIC_VECTOR(21 downto 0) := (others => '0');
    signal distancia_cm   : STD_LOGIC_VECTOR(9 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: entity work.distance_calculator
        port map (
            clk            => clk,
            reset          => reset,
            medicion_lista => medicion_lista,
            conteo_echo    => conteo_echo,
            distancia_cm   => distancia_cm
        );

    clk <= not clk after CLK_PERIOD / 2;

    process
    begin
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 50 ns;

        
        -- Caso 1: 10 cm
        -- 10 * 5831 = 58310 ciclos
        conteo_echo <= std_logic_vector(to_unsigned(58310, 22));
        medicion_lista <= '1';
        wait for CLK_PERIOD;
        medicion_lista <= '0';
        wait for 100 ns;

        
        -- Caso 2: 45 cm
        -- 45 * 5831 = 262395 ciclos
        conteo_echo <= std_logic_vector(to_unsigned(262395, 22));
        medicion_lista <= '1';
        wait for CLK_PERIOD;
        medicion_lista <= '0';
        wait for 100 ns;

        
        -- Caso 3: 100 cm
        -- 100 * 5831 = 583100 ciclos
        conteo_echo <= std_logic_vector(to_unsigned(583100, 22));
        medicion_lista <= '1';
        wait for CLK_PERIOD;
        medicion_lista <= '0';
        wait for 100 ns;

        
        -- Caso 4: 180 cm
        -- 180 * 5831 = 1049580 ciclos
        conteo_echo <= std_logic_vector(to_unsigned(1049580, 22));
        medicion_lista <= '1';
        wait for CLK_PERIOD;
        medicion_lista <= '0';
        wait for 100 ns;

        wait;
    end process;

end Behavioral;
