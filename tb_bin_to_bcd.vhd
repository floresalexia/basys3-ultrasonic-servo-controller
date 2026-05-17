-----------------------------------
-- Create Date: 04.05.2026 13:56:42
-- Module Name: tb_bin_to_bcd - Behavioral
-----------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_bin_to_bcd is
end tb_bin_to_bcd;

architecture Behavioral of tb_bin_to_bcd is

    signal entrada_binaria : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    signal millares        : STD_LOGIC_VECTOR(3 downto 0);
    signal centenas        : STD_LOGIC_VECTOR(3 downto 0);
    signal decenas         : STD_LOGIC_VECTOR(3 downto 0);
    signal unidades        : STD_LOGIC_VECTOR(3 downto 0);

begin

    uut: entity work.bin_to_bcd
        port map (
            entrada_binaria => entrada_binaria,
            millares        => millares,
            centenas        => centenas,
            decenas         => decenas,
            unidades        => unidades
        );

    process
    begin
        entrada_binaria <= std_logic_vector(to_unsigned(0, 10));
        wait for 20 ns;

        entrada_binaria <= std_logic_vector(to_unsigned(5, 10));
        wait for 20 ns;

        entrada_binaria <= std_logic_vector(to_unsigned(45, 10));
        wait for 20 ns;

        entrada_binaria <= std_logic_vector(to_unsigned(90, 10));
        wait for 20 ns;

        entrada_binaria <= std_logic_vector(to_unsigned(135, 10));
        wait for 20 ns;

        entrada_binaria <= std_logic_vector(to_unsigned(180, 10));
        wait for 20 ns;

        entrada_binaria <= std_logic_vector(to_unsigned(999, 10));
        wait for 20 ns;

        entrada_binaria <= std_logic_vector(to_unsigned(1023, 10));
        wait for 20 ns;

        wait;
    end process;

end Behavioral;