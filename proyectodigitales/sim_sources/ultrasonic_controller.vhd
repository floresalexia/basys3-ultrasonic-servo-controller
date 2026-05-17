-----------------------------------
-- Create Date: 04.05.2026 14:17:03
-- Module Name: ultrasonic_controller - Behavioral
-----------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ultrasonic_controller is
    Port (
        clk              : in  STD_LOGIC;
        reset            : in  STD_LOGIC;
        echo             : in  STD_LOGIC;
        trigger          : out STD_LOGIC;
        conteo_echo      : out STD_LOGIC_VECTOR(21 downto 0);
        led_medicion     : out STD_LOGIC;
        medicion_lista   : out STD_LOGIC
    );
end ultrasonic_controller;

architecture Behavioral of ultrasonic_controller is

    constant CICLOS_TRIGGER          : integer := 1000;     -- 10 us
    constant CICLOS_ENTRE_MEDIDAS    : integer := 6000000;  -- 60 ms
    constant CICLOS_TIMEOUT_ECHO     : integer := 3000000;  -- 30 ms 

    type tipo_estado is (
        ESTADO_TRIGGER,
        ESPERAR_ECHO_ALTO,
        MEDIR_ECHO,
        ESTADO_LISTO,
        ESPERAR_SIGUIENTE_MEDIDA
    );

    signal estado_actual  : tipo_estado := ESTADO_TRIGGER;

    signal contador_trigger  : integer range 0 to CICLOS_TRIGGER := 0;
    signal contador_periodo  : integer range 0 to CICLOS_ENTRE_MEDIDAS := 0;
    signal contador_echo     : integer range 0 to CICLOS_TIMEOUT_ECHO := 0;

    signal trigger_reg      : STD_LOGIC := '0';
    signal conteo_echo_reg  : unsigned(21 downto 0) := (others => '0');

begin

    trigger <= trigger_reg;
    conteo_echo <= std_logic_vector(conteo_echo_reg);

    process(clk)
    begin
        if rising_edge(clk) then

            if reset = '1' then
                estado_actual <= ESTADO_TRIGGER;

                contador_trigger <= 0;
                contador_periodo <= 0;
                contador_echo    <= 0;

                trigger_reg <= '0';
                conteo_echo_reg <= (others => '0');

                led_medicion <= '0';
                medicion_lista <= '0';

            else
                medicion_lista <= '0';

                case estado_actual is

                    when ESTADO_TRIGGER =>
                        led_medicion <= '1';
                        trigger_reg <= '1';

                        if contador_trigger = CICLOS_TRIGGER - 1 then
                            contador_trigger <= 0;
                            trigger_reg <= '0';
                            contador_echo <= 0;
                            estado_actual <= ESPERAR_ECHO_ALTO;
                        else
                            contador_trigger <= contador_trigger + 1;
                        end if;

                    when ESPERAR_ECHO_ALTO =>
                        led_medicion <= '1';
                        trigger_reg <= '0';

                        if echo = '1' then
                            contador_echo <= 0;
                            estado_actual <= MEDIR_ECHO;

                        elsif contador_echo = CICLOS_TIMEOUT_ECHO - 1 then
                            contador_echo <= 0;
                            conteo_echo_reg <= (others => '0');
                            medicion_lista <= '1';
                            estado_actual <= ESTADO_LISTO;

                        else
                            contador_echo <= contador_echo + 1;
                        end if;

                    when MEDIR_ECHO =>
                        led_medicion <= '1';
                        trigger_reg <= '0';

                        if echo = '1' then

                            if contador_echo = CICLOS_TIMEOUT_ECHO - 1 then
                                conteo_echo_reg <= to_unsigned(CICLOS_TIMEOUT_ECHO, 22);
                                contador_echo <= 0;
                                medicion_lista <= '1';
                                estado_actual <= ESTADO_LISTO;
                            else
                                contador_echo <= contador_echo + 1;
                            end if;

                        else
                            conteo_echo_reg <= to_unsigned(contador_echo, 22);
                            contador_echo <= 0;
                            medicion_lista <= '1';
                            estado_actual <= ESTADO_LISTO;
                        end if;

                    when ESTADO_LISTO =>
                        led_medicion <= '0';
                        trigger_reg <= '0';
                        contador_periodo <= 0;
                        estado_actual <= ESPERAR_SIGUIENTE_MEDIDA;

                    when ESPERAR_SIGUIENTE_MEDIDA =>
                        led_medicion <= '0';
                        trigger_reg <= '0';

                        if contador_periodo = CICLOS_ENTRE_MEDIDAS - 1 then
                            contador_periodo <= 0;
                            estado_actual <= ESTADO_TRIGGER;
                        else
                            contador_periodo <= contador_periodo + 1;
                        end if;

                end case;
            end if;
        end if;
    end process;

end Behavioral;