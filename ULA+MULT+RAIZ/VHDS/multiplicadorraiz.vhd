LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY multiplicadorraiz IS
PORT (mid : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      s : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END multiplicadorraiz;

ARCHITECTURE estrutura OF multiplicadorraiz IS
BEGIN
    s <= mid * mid;
END estrutura;