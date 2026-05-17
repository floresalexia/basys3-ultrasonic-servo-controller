-----------------------------------
-- Create Date: 04.05.2026 13:10:56
-- Module Name: servo_pwm - Behavioral
-----------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity servo_pwm is
    Port (
        clk              : in  STD_LOGIC;
        reset            : in  STD_LOGIC;
        seleccion_angulo : in  STD_LOGIC_VECTOR(2 downto 0);
        pwm_out          : out STD_LOGIC
    );
end servo_pwm;

architecture Behavioral of servo_pwm is

    constant CICLOS_PERIODO_PWM : integer := 2000000; -- 20 ms

    constant PULSO_0_GRADOS    : integer := 100_000;   -- 1.00 ms
    constant PULSO_45_GRADOS   : integer := 150_000;   -- 1.50 ms
    constant PULSO_90_GRADOS   : integer := 200_000;   -- 2.00 ms
    constant PULSO_135_GRADOS  : integer := 250_000;   -- 2.50 ms
    constant PULSO_180_GRADOS  : integer := 263_000;   -- 2.63 ms

    signal contador_pwm : integer range 0 to CICLOS_PERIODO_PWM - 1 := 0;
    signal ancho_pulso  : integer range 0 to PULSO_180_GRADOS := PULSO_0_GRADOS;

begin

    process(seleccion_angulo)
    begin
        case seleccion_angulo is
            when "000" =>
                ancho_pulso <= PULSO_0_GRADOS;

            when "001" =>
                ancho_pulso <= PULSO_45_GRADOS;

            when "010" =>
                ancho_pulso <= PULSO_90_GRADOS;

            when "011" =>
                ancho_pulso <= PULSO_135_GRADOS;

            when "100" =>
                ancho_pulso <= PULSO_180_GRADOS;

            when others =>
                ancho_pulso <= PULSO_0_GRADOS;
        end case;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                contador_pwm <= 0;
            else
                if contador_pwm = CICLOS_PERIODO_PWM - 1 then
                    contador_pwm <= 0;
                else
                    contador_pwm <= contador_pwm + 1;
                end if;
            end if;
        end if;
    end process;

    process(contador_pwm, ancho_pulso)
    begin
        if contador_pwm < ancho_pulso then
            pwm_out <= '1';
        else
            pwm_out <= '0';
        end if;
    end process;

end Behavioral;