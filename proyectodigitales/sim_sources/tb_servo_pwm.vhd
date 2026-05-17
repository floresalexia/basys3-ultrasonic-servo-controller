-----------------------------------
-- Create Date: 04.05.2026 13:16:33
-- Module Name: tb_servo_pwm - Behavioral
-----------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_servo_pwm is
end tb_servo_pwm;

architecture Behavioral of tb_servo_pwm is

    signal clk              : STD_LOGIC := '0';
    signal reset            : STD_LOGIC := '0';
    signal seleccion_angulo : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal pwm_out          : STD_LOGIC;

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: entity work.servo_pwm
        port map (
            clk              => clk,
            reset            => reset,
            seleccion_angulo => seleccion_angulo,
            pwm_out          => pwm_out
        );

    clk <= not clk after CLK_PERIOD / 2;

    process
    begin
        reset <= '1';
        wait for 100 ns;
        reset <= '0';

        
        -- 0 grados, pulso de 1.00 ms
        seleccion_angulo <= "000";
        wait for 25 ms;

        
        -- 45 grados, pulso de 1.25 ms
        seleccion_angulo <= "001";
        wait for 25 ms;

        
        -- 90 grados, pulso de 1.50 ms
        seleccion_angulo <= "010";
        wait for 25 ms;

        
        -- 135 grados, pulso de 1.75 ms
        seleccion_angulo <= "011";
        wait for 25 ms;

        
        -- 180 grados, pulso de 2.00 ms
        seleccion_angulo <= "100";
        wait for 25 ms;

        wait;
    end process;

end Behavioral;