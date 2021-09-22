LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux11X1 IS
  PORT (soma, sub, amais, amenos, nota, aandb, aorb, axorb, mult, raiz, halt : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         sel: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
         y : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
  END mux11X1;

ARCHITECTURE comportamento OF mux11X1 IS
BEGIN
     WITH sel SELECT
         y <= soma WHEN "0001",
              sub WHEN "0010",
              amais WHEN "0011",
              amenos WHEN "0100",
              nota WHEN "0101",
              aandb WHEN "0110",
              aorb WHEN "0111",
              axorb WHEN "1000",
              mult WHEN "1001",
              raiz WHEN "1010",
              halt when others;
END comportamento;
