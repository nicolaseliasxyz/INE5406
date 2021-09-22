LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux2para1_8 IS
  generic(N: integer := 16);
  PORT ( a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
         sel: IN STD_LOGIC;
         y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
  END mux2para1_8;

ARCHITECTURE comportamento OF mux2para1_8 IS
BEGIN
     WITH sel SELECT
         y <= a WHEN '0',
              b WHEN OTHERS;
END comportamento;