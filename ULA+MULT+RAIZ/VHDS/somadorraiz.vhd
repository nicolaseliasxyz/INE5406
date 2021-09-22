LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY somadorraiz IS
PORT (a, b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      s : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END somadorraiz;

ARCHITECTURE estrutura OF somadorraiz IS
BEGIN
    s <= a + b;
END estrutura;