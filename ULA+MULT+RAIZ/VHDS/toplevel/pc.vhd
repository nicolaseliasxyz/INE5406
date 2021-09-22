LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY pc IS
generic(N: integer := 5);
PORT (clk, carga, reset: IN STD_LOGIC;
      pc_counter: in std_logic_vector(N-1 DOWNTO 0));
	  saida_pc : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END pc;

ARCHITECTURE estrutura OF pc IS
BEGIN
	PROCESS(clk)
	BEGIN
        IF (reset = '1') then
            pc_counter <= "00000"; 
		ELSIF (clk'EVENT AND clk = '1') AND carga = '1' AND reset = '0' THEN
            pc_counter <= pc_counter + "00001";
		END IF;
	END PROCESS;
END estrutura;