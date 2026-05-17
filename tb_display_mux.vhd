-----------------------------------
-- Create Date: 04.05.2026 14:07:03
-- Module Name: tb_display_mux - Behavioral
-----------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_display_mux is
end tb_display_mux;

architecture Behavioral of tb_display_mux is

    signal clk       : STD_LOGIC := '0';
    signal reset     : STD_LOGIC := '0';

    signal millares  : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal centenas  : STD_LOGIC_VECTOR(3 downto 0) := "0001";
    signal decenas   : STD_LOGIC_VECTOR(3 downto 0) := "0011";
    signal unidades  : STD_LOGIC_VECTOR(3 downto 0) := "0101";

    signal an        : STD_LOGIC_VECTOR(3 downto 0);
    signal seg       : STD_LOGIC_VECTOR(6 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: entity work.display_mux
        port map (
            clk       => clk,
            reset     => reset,
            millares  => millares,
            centenas  => centenas,
            decenas   => decenas,
            unidades  => unidades,
            an        => an,
            seg       => seg
        );

    clk <= not clk after CLK_PERIOD / 2;

    process
    begin
        reset <= '1';
        wait for 100 ns;
        reset <= '0';

        -- Mostrar 0135
        millares <= "0000";
        centenas <= "0001";
        decenas  <= "0011";
        unidades <= "0101";
        wait for 3 ms;


        -- Mostrar 0180
        millares <= "0000";
        centenas <= "0001";
        decenas  <= "1000";
        unidades <= "0000";
        wait for 3 ms;

        -- Mostrar 0045
        millares <= "0000";
        centenas <= "0000";
        decenas  <= "0100";
        unidades <= "0101";
        wait for 3 ms;

        wait;
    end process;

end Behavioral;