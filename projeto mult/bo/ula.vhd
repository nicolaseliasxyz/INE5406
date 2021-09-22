LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

ENTITY ula IS
  generic(N: integer := 4);
  PORT (a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
         ula_sel: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		Reset: in std_logic;
		clk: in std_logic;
         mult_pronto, mult_on: out std_logic;
         y : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
         z: OUT STD_LOGIC_VECTOR(3 downto 0));
  END ula;
 
ARCHITECTURE comportamento OF ula IS

COMPONENT multiplicador IS
    port (Reset, clk, inicio : in std_logic;
            entA, entB : in std_logic_vector(N-1 downto 0);
            pronto : out std_logic;
		    saida: out std_logic_vector(7 downto 0));
END COMPONENT;

signal ula_result, ula_mult_result: std_logic_vector(7 downto 0);
signal ula_inicio_mult, ula_inicio: std_logic;
signal ula_result_flag: std_logic_vector(3 downto 0);

BEGIN
    mult: multiplicador port map (Reset => Reset,
									clk => clk,
									inicio => ula_inicio,
									entA => a,
                                    entB => b,
                                    pronto => mult_pronto,
                                    saida => ula_mult_result);
    process(ula_sel)
        begin
			ula_inicio <= '0';
        case(ula_sel) is
            when "000" =>
                ula_result <= ("0000" & a) + ("0000" & b);
                mult_on <= '0';
            when "001" =>
                ula_result <= ("0000" & a) - ("0000" & b);
                mult_on <= '0';
            when "010" =>
                ula_result <= "0000" & (a and b);
                mult_on <= '0';
            when "011" =>
                ula_result <= "0000" & (a or b);
                mult_on <= '0';
            when "100" =>
                ula_result <= ula_mult_result;
                ula_inicio <= '1';
                mult_on <= '1';
            when others => Null;
               
                
					
		end case;
    end process;


y <= ula_result;
z <= "000" & not(((ula_result(7) NOR ula_result(6)) NOR (ula_result(5) NOR ula_result(4))) NOR ((ula_result(3) NOR ula_result(2)) NOR (ula_result(1) NOR ula_result(0))));
     

END comportamento;