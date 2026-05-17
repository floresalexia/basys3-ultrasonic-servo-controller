-----------------------------------
-- Create Date: 04.05.2026 14:18:46
-- Module Name: tb_ultrasonic_controller - Behavioral
-----------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ultrasonic_controller is
end tb_ultrasonic_controller;

architecture Behavioral of tb_ultrasonic_controller is

    signal clk            : STD_LOGIC := '0';
    signal reset          : STD_LOGIC := '0';
    signal echo           : STD_LOGIC := '0';

    signal trigger        : STD_LOGIC;
    signal conteo_echo    : STD_LOGIC_VECTOR(21 downto 0);
    signal led_medicion   : STD_LOGIC;
    signal medicion_lista : STD_LOGIC;

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: entity work.ultrasonic_controller
        port map (
            clk            => clk,
            reset          => reset,
            echo           => echo,
            trigger        => trigger,
            conteo_echo    => conteo_echo,
            led_medicion   => led_medicion,
            medicion_lista => medicion_lista
        );

    clk <= not clk after CLK_PERIOD / 2;

    process
    begin
        reset <= '1';
        wait for 100 ns;
        reset <= '0';

        
        -- Caso 1: distancia simulada de 10 cm
        -- Con 5831 ciclos/cm, echo dura 583.1 us
        wait until trigger = '1';
        wait until trigger = '0';

        wait for 200 us;

        echo <= '1';
        wait for 580 us;
        echo <= '0';

        wait until medicion_lista = '1';


        -- Caso 2: distancia simulada de 45 cm
        -- echo dura 2623.95 us
        wait until trigger = '1';
        wait until trigger = '0';

        wait for 200 us;

        echo <= '1';
        wait for 2610 us;
        echo <= '0';

        wait until medicion_lista = '1';

        
        -- Caso 3: distancia simulada de 100 cm
        -- echo dura 5831 us
        wait until trigger = '1';
        wait until trigger = '0';

        wait for 200 us;

        echo <= '1';
        wait for 5800 us;
        echo <= '0';

        wait until medicion_lista = '1';

        wait;
    end process;

end Behavioral;