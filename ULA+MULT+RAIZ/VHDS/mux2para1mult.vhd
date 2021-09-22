LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux2para1mult IS
  generic(N: integer := 8);
  PORT ( a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
         sel: IN STD_LOGIC;
         y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
  END mux2para1mult ;

ARCHITECTURE comportamento OF mux2para1mult IS
BEGIN
     WITH sel SELECT
         y <= a WHEN '0',
              b WHEN OTHERS;
END comportamento;