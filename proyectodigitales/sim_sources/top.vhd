-----------------------------------
-- Create Date: 04.05.2026 14:37:26
-- Module Name: top - Behavioral
-----------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port (
        clk           : in  STD_LOGIC;
        reset         : in  STD_LOGIC;

        echo          : in  STD_LOGIC;
        sw_display    : in  STD_LOGIC;

        trigger       : out STD_LOGIC;
        servo_pwm_out : out STD_LOGIC;

        an            : out STD_LOGIC_VECTOR(3 downto 0);
        seg           : out STD_LOGIC_VECTOR(6 downto 0);

        led_medicion  : out STD_LOGIC;
        led_done      : out STD_LOGIC
    );
end top;

architecture Structural of top is

    signal conteo_echo_signal       : STD_LOGIC_VECTOR(21 downto 0);
    signal medicion_lista_signal    : STD_LOGIC;

    signal distancia_cm_signal      : STD_LOGIC_VECTOR(9 downto 0);
    signal seleccion_angulo_signal  : STD_LOGIC_VECTOR(2 downto 0);
    signal valor_angulo_signal      : STD_LOGIC_VECTOR(9 downto 0);

    signal valor_display_signal     : STD_LOGIC_VECTOR(9 downto 0);

    signal millares_signal          : STD_LOGIC_VECTOR(3 downto 0);
    signal centenas_signal          : STD_LOGIC_VECTOR(3 downto 0);
    signal decenas_signal           : STD_LOGIC_VECTOR(3 downto 0);
    signal unidades_signal          : STD_LOGIC_VECTOR(3 downto 0);

begin


    -- Controlador del sensor ultrasónico
    ultrasonic_inst: entity work.ultrasonic_controller
        port map (
            clk            => clk,
            reset          => reset,
            echo           => echo,

            trigger        => trigger,
            conteo_echo    => conteo_echo_signal,
            led_medicion   => led_medicion,
            medicion_lista => medicion_lista_signal
        );


    -- Conversión del tiempo de echo a distancia en centímetros
    distance_inst: entity work.distance_calculator
        port map (
            clk            => clk,
            reset          => reset,
            medicion_lista => medicion_lista_signal,
            conteo_echo    => conteo_echo_signal,
            distancia_cm   => distancia_cm_signal
        );


    -- Conversión de distancia a código de ángulo
    angle_mapper_inst: entity work.angle_mapper
        port map (
            distancia_cm      => distancia_cm_signal,
            seleccion_angulo => seleccion_angulo_signal
        );


    -- Generación de la señal pwm para el servomotor
    servo_pwm_inst: entity work.servo_pwm
        port map (
            clk              => clk,
            reset            => reset,
            seleccion_angulo => seleccion_angulo_signal,
            pwm_out          => servo_pwm_out
        );


    -- Conversión del código de ángulo a valor visible en grados
    angle_value_inst: entity work.angle_value_converter
        port map (
            seleccion_angulo => seleccion_angulo_signal,
            valor_angulo     => valor_angulo_signal
        );


    -- Selección del valor que se mostrará en el display
    -- sw_display = 0: distancia en cm
    -- sw_display = 1: ángulo en grados
    process(sw_display, distancia_cm_signal, valor_angulo_signal)
    begin
        if sw_display = '0' then
            valor_display_signal <= distancia_cm_signal;
        else
            valor_display_signal <= valor_angulo_signal;
        end if;
    end process;


    -- Conversión del valor seleccionado a dígitos BCD
    bcd_inst: entity work.bin_to_bcd
        port map (
            entrada_binaria => valor_display_signal,
            millares        => millares_signal,
            centenas        => centenas_signal,
            decenas         => decenas_signal,
            unidades        => unidades_signal
        );

 
    -- Multiplexación del display de 7 segmentos
    display_inst: entity work.display_mux
        port map (
            clk       => clk,
            reset     => reset,

            millares  => millares_signal,
            centenas  => centenas_signal,
            decenas   => decenas_signal,
            unidades  => unidades_signal,

            an        => an,
            seg       => seg
        );

    -- LED de finalización de medición
    led_done <= medicion_lista_signal;

end Structural;