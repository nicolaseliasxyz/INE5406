LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY bomult IS
generic(N: integer := 8);
PORT (clk : IN STD_LOGIC;
      sel1, CPB, CA : IN STD_LOGIC;
      entA, entB : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
      Bz : OUT STD_LOGIC;
      conteudoA, conteudoB : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		saida: out std_logic_vector(15 downto 0));
END bomult;

ARCHITECTURE estrutura OF bomult IS
	
	COMPONENT registrador IS
	PORT (clk, carga : IN STD_LOGIC;
		  d : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		  q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT;

	COMPONENT registrador8 IS
	PORT (clk, carga : IN STD_LOGIC;
		  d : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	  	  q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT mux2para1mult IS
	PORT ( a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		   sel: IN STD_LOGIC;
		   y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT;

	component mux2para1_8 IS
    PORT ( a, b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         sel: IN STD_LOGIC;
         y : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
   END component;
	
	COMPONENT somador IS
	PORT (a, b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		  s : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT subtrator IS
	PORT (a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		  s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT;

    COMPONENT igualazero IS
	PORT (a : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          igual : OUT STD_LOGIC);
	END COMPONENT;
		
	SIGNAL saimux2, sairegA, sairegB, saisub: STD_LOGIC_VECTOR (N-1 DOWNTO 0);
	SIGNAL saimux1, sairegP, saisoma, concatena: STD_LOGIC_VECTOR (15 DOWNTO 0);

BEGIN
	mux1: mux2para1_8 PORT MAP (a => saisoma,
							  b => "0000000000000000",
							  sel => sel1,
							  y => saimux1);
	mux2: mux2para1mult PORT MAP (a => saisub,
							  b => entB,
							  sel => sel1,
							  y => saimux2);
	regP: registrador8 PORT MAP (clk => clk,
								  carga => CPB,
								   d => saimux1,
								   q => sairegP);
	regA: registrador PORT MAP (clk => clk,
								carga => CA,
								d => entA,
								q => sairegA);
	regB: registrador PORT MAP (clk => clk,
								carga => CPB,
								d => saimux2,
								q => sairegB);
	geraBz: igualazero PORT MAP (a => sairegB,
								 igual => Bz); 
	sub: subtrator PORT MAP (a => sairegB,
							 b => "00000001",
							 s => saisub);
							 
	concatena <= "00000000" & sairegA;
	
	som: somador PORT MAP (a => sairegP,
						   b => concatena,
					 	   s => saisoma);
	
	saida <= sairegP;
	conteudoA <= sairegA;
	conteudoB <= sairegB;

END estrutura;