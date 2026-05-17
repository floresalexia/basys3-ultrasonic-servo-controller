-----------------------------------
-- Create Date: 04.05.2026 13:54:47
-- Module Name: bin_to_bcd - Behavioral
-----------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bin_to_bcd is
    Port (
        entrada_binaria : in  STD_LOGIC_VECTOR(9 downto 0);
        millares        : out STD_LOGIC_VECTOR(3 downto 0);
        centenas        : out STD_LOGIC_VECTOR(3 downto 0);
        decenas         : out STD_LOGIC_VECTOR(3 downto 0);
        unidades        : out STD_LOGIC_VECTOR(3 downto 0)
    );
end bin_to_bcd;

architecture Behavioral of bin_to_bcd is
begin

    process(entrada_binaria)
        variable valor_int : integer range 0 to 1023;
        variable temporal  : integer range 0 to 1023;
    begin
        valor_int := to_integer(unsigned(entrada_binaria));
        temporal := valor_int;

        millares <= std_logic_vector(to_unsigned(temporal / 1000, 4));
        temporal := temporal mod 1000;

        centenas <= std_logic_vector(to_unsigned(temporal / 100, 4));
        temporal := temporal mod 100;

        decenas <= std_logic_vector(to_unsigned(temporal / 10, 4));
        temporal := temporal mod 10;

        unidades <= std_logic_vector(to_unsigned(temporal, 4));
    end process;

end Behavioral;

