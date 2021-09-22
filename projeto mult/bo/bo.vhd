LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY bo IS
  PORT (clk: in std_logic;
        dado: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        mult_pronto, mult_on: out std_logic;
        saida: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        flagZ: OUT STD_LOGIC_VECTOR(3 downto 0);
        enA, enB, enOp, enOut: in STD_LOGIC);
  END bo;
 
ARCHITECTURE comportamento OF bo IS

    component registrador4 is
    PORT (clk, carga : IN STD_LOGIC;
	  d : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	  q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END component;

    component registrador3 is
        PORT (clk, carga : IN STD_LOGIC;
	          d : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	          q : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
        END component;

    component registrador8 is
        PORT (clk, carga : IN STD_LOGIC;
              d : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
              q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    END component;

    component ula is
        PORT (a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
         ula_sel: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
         mult_pronto, mult_on: out std_logic;
         y : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
         z: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END component;


signal regOp, outregOp: std_logic_vector(2 downto 0);
signal regA, regB, outregA, outregB, outUlaz: std_logic_vector(3 downto 0);
signal outUla: std_logic_vector(7 downto 0);

begin
    regOp <= dado(10 downto 8);
    regA <= dado(7 downto 4);
    regB <= dado(3 downto 0);

    REG1: registrador4 port map(clk => clk,
						        d => regA,
                                q => outregA,
                                carga => enA);

    REG2: registrador4 port map(clk => clk,
										  d => regB,
                                q => outregB,
                                carga => enB);

    REG3: registrador3 port map(clk => clk,
								d => regOp,
                                q => outregOp,
                                carga => enOp);

    ULA1: ula port map(a => outregA,
                      b => outregB,
                      ula_sel => outregOp,
                      mult_pronto => mult_pronto,
                      mult_on => mult_on,
                      y => outUla,
                      z => outUlaz);

    REG4: registrador8 port map(clk => clk,
								d => outUla,
                                q => saida,
                                carga => enOut);

    REG5: registrador4 port map(clk => clk,
								d => outUlaz,
                                q => flagZ,
                                carga => enOut);

END comportamento;