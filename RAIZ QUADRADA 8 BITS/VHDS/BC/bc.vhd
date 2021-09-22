LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (Reset, clk, INICIAL: IN STD_LOGIC;
      ent_comp: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	  pronto: OUT STD_LOGIC;
      regstart, regend, regmid, regmult, regd, regsaida, sela, selb, selop: OUT STD_LOGIC);
	  --estado_atual: out std_logic_vector(7 downto 0)
END bc;

ARCHITECTURE estrutura OF bc IS
	TYPE STATES IS (INICIO, SOMASHIFT, MULT, COMPARA, DESTINO, FINAL, SOMA, SOMA2, SUB, SUB2);
	SIGNAL EAtual, PEstado: STATES;
BEGIN
	PROCESS (clk, Reset)
	BEGIN
		if(Reset = '1') THEN
			EAtual <= INICIO ;
		ELSIF (clk'EVENT AND clk = '1') THEN
			EAtual <= PEstado;
		end if;
	end process;
	
	process(EAtual, PEstado, INICIAL, ent_comp)
	begin
			CASE EAtual IS
				WHEN INICIO =>
					sela <= '1';
				   selb <= '0';
					regstart <= '1';
					regend <= '1';
					regmid <= '0';
					regmult <= '0';
					regd <= '0';
				   selop <= '0';
				   regsaida <= '0';
					pronto <= '0';
				    
					 
					if (INICIAL = '1') then
                  PEstado <= SOMASHIFT;
               else
                  PEstado <= INICIO;
               end if;

				WHEN SOMASHIFT => 
               sela <= '0';
				   selb <= '0';
					regstart <= '0';
					regend <= '0';
					regmid <= '1';
					regmult <= '0';
					regd <= '0';
				   selop <= '0';
				   regsaida <= '0';
					pronto <= '0';

               PEstado <= MULT;
					

				WHEN MULT =>
               sela <= '0';
				   selb <= '0';
					regstart <= '0';
					regend <= '0';
					regmid <= '0';
					regmult <= '1';
					regd <= '0';
				   selop <= '0';
				   regsaida <= '0';
					pronto <= '0';

					PEstado <= COMPARA;

				WHEN COMPARA =>
					sela <= '0';
					selb <= '0';
					regstart <= '0';
					regend <= '0';
					regmid <= '0';
					regmult <= '0';
					regd <= '1';
					selop <= '0';
					regsaida <= '0';
					pronto <= '0';
            
					PEstado <= DESTINO;

				WHEN DESTINO =>
					sela <= '0';
					selb <= '0';
					regstart <= '0';
					regend <= '0';
					regmid <= '0';
					regmult <= '0';
					regd <= '0';
					selop <= '0';
					regsaida <= '0';
					pronto <= '0';

               if (ent_comp = "10") then
                  PEstado <= SOMA;
					elsif (ent_comp = "11") then
						PEstado <= SUB;
					else
						PEstado <= FINAL;
               end if;

				WHEN FINAL =>
               sela <= '0';
					selb <= '0';
					regstart <= '0';
					regend <= '0';
					regmid <= '0';
					regmult <= '0';
					regd <= '0';
					selop <= '0';
					regsaida <= '1';
					pronto <= '1';
					
					PEstado <= INICIO;

				WHEN SOMA =>
               sela <= '0';
					selb <= '0';
					regstart <= '0';
					regend <= '0';
					regmid <= '0';
					regmult <= '0';
					regd <= '0';
					selop <= '0';
					regsaida <= '0';
					pronto <= '0';

               PEstado <= SOMA2;

				WHEN SOMA2 =>
               sela <= '0';
					selb <= '0';
					regstart <= '1';
					regend <= '0';
					regmid <= '0';
					regmult <= '0';
					regd <= '0';
					selop <= '0';
					regsaida <= '0';
					pronto <= '0';

               PEstado <= SOMASHIFT;

				WHEN SUB =>
               sela <= '0';
					selb <= '0';
					regstart <= '0';
					regend <= '0';
					regmid <= '0';
					regmult <= '0';
					regd <= '0';
					selop <= '1';
					regsaida <= '0';
					pronto <= '0';

               PEstado <= SUB2;

				WHEN SUB2 =>
               sela <= '0';
					selb <= '1';
					regstart <= '0';
					regend <= '1';
					regmid <= '0';
					regmult <= '0';
					regd <= '0';
					selop <= '1';
					regsaida <= '0';
					pronto <= '0';

               PEstado <= SOMASHIFT;
			END CASE;		
	END PROCESS;
END estrutura;