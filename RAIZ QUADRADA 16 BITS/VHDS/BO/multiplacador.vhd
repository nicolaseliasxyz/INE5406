LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY multiplicador IS
PORT (mid : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      s : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END multiplicador;

ARCHITECTURE estrutura OF multiplicador IS
BEGIN
    s <= mid * mid;
END estrutura;