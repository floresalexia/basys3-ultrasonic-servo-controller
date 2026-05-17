-----------------------------------
-- Create Date: 04.05.2026 20:19:48 
-- Module Name: tb_top - Behavioral
-----------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top is
end tb_top;

architecture Behavioral of tb_top is

    signal clk           : STD_LOGIC := '0';
    signal reset         : STD_LOGIC := '0';

    signal echo          : STD_LOGIC := '0';
    signal sw_display    : STD_LOGIC := '0';

    signal trigger       : STD_LOGIC;
    signal servo_pwm_out : STD_LOGIC;

    signal an            : STD_LOGIC_VECTOR(3 downto 0);
    signal seg           : STD_LOGIC_VECTOR(6 downto 0);

    signal led_medicion  : STD_LOGIC;
    signal led_done      : STD_LOGIC;

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: entity work.top
        port map (
            clk           => clk,
            reset         => reset,
            echo          => echo,
            sw_display    => sw_display,
            trigger       => trigger,
            servo_pwm_out => servo_pwm_out,
            an            => an,
            seg           => seg,
            led_medicion  => led_medicion,
            led_done      => led_done
        );


    clk <= not clk after CLK_PERIOD / 2;

    process
    begin
        
        -- Reset inicial
        reset <= '1';
        sw_display <= '0'; -- Mostrar distancia
        wait for 100 ns;
        reset <= '0';

        
        -- Caso 1: distancia simulada de 10 cm
        -- Con CICLOS_POR_CM = 5831:
        -- 10 cm ≈ 583.1 us de echo
        wait until trigger = '1';
        wait until trigger = '0';

        wait for 200 us;

        echo <= '1';
        wait for 583.1 us;
        echo <= '0';

        wait for 5 ms;

        -- Mostrar ángulo
        sw_display <= '1';
        wait for 5 ms;

        
        -- Caso 2: distancia simulada de 45 cm
        -- 45 cm ≈ 2623.95 us de echo
        sw_display <= '0';

        wait until trigger = '1';
        wait until trigger = '0';

        wait for 200 us;

        echo <= '1';
        wait for 2623.95 us;
        echo <= '0';

        wait for 5 ms;

        sw_display <= '1';
        wait for 5 ms;
        
        
        -- Caso 3: distancia simulada de 100 cm
        -- 100 cm ≈ 5831 us de echo
        sw_display <= '0';

        wait until trigger = '1';
        wait until trigger = '0';

        wait for 200 us;

        echo <= '1';
        wait for 5831 us;
        echo <= '0';

        wait for 5 ms;

        sw_display <= '1';
        wait for 10 ms;

        wait;
    end process;

end Behavioral;
