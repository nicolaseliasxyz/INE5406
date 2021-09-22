library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity comparador is
    generic(n: integer := 32);
    port( A,B: in std_logic_vector(n-1 downto 0);
          saida: out std_logic_vector(1 downto 0)
          );
end comparador;

architecture comportamento of comparador is

begin

   saida <= "01" when A = B else "10" when A > B else "11" when A < B else "00";

end comportamento;