library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity BO is
    port(
        entrada_x: in std_logic_vector(3 downto 0);
        regstart, regend, regmid, regmult, regd, regsaida, sela, selb, selop: in std_logic;
        clk: in std_logic;
        saidacomparador: out std_logic_vector(1 downto 0);
        saida: out std_logic_vector(3 downto 0);
        compdebug: out std_logic_vector(1 downto 0));
end BO;

architecture raiz of BO IS

    signal saimuxa, saimuxb, sairegstart, sairegend, saisoma, sairegmid, saisomasub, shift: std_logic_vector(3 downto 0);
    signal saimult, sairegmult, entrada_comparador_end: std_logic_vector(7 downto 0);
    signal saicomp: std_logic_vector(1 downto 0);

    component comparador is
        port( A,B: in std_logic_vector(7 downto 0);
              saida: out std_logic_vector(1 downto 0)
              );
    end component;

    component multiplicador IS
    PORT (mid : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          s : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    END component;

    component mux2para1 IS
    PORT ( a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
           sel: IN STD_LOGIC;
           y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END component;

    component registrador2 IS
    PORT (clk, carga : IN STD_LOGIC;
          d : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
          q : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
    END component;

    component registrador4 IS
    PORT (clk, carga : IN STD_LOGIC;
          d : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END component;

    component registrador8 IS
    PORT (clk, carga : IN STD_LOGIC;
          d : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
          q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    END component;

    component somador IS
    PORT (a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          s : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END component;

    component somadorsubtrator IS
    PORT (a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          op: IN STD_LOGIC;
          s : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END component;

begin

    MUXA: mux2para1 port map( a => saisomasub,
                              b => "0000",
                              sel => sela,
                              y => saimuxa);
    
    MUXB: mux2para1 port map( a => entrada_x,
                              b => saisomasub,
                              sel => selb,
                              y => saimuxb);

    REGS: registrador4 port map( clk => clk,
                                 carga => regstart,
                                 d => saimuxa,
                                 q => sairegstart);
    
    REGE: registrador4 port map( clk => clk,
                                 carga => regend,
                                 d => saimuxb,
                                 q => sairegend);
    
    SOMA: somador port map( a => sairegstart,
                            b => sairegend,
                            s => saisoma);
									 
	 shift <= '0' & saisoma(3 downto 1);

    REGM: registrador4 port map( clk => clk,
                                 carga => regmid,
                                 d => shift,
                                 q => sairegmid);

    MULT: multiplicador port map( mid => sairegmid,
                                  s => saimult);

    RMULT: registrador8 port map( clk => clk,
                                    carga => regmult,
                                    d => saimult,
                                    q => sairegmult);
	
      entrada_comparador_end <= "0000" & entrada_x;

    COMP: comparador port map( A => entrada_comparador_end,
                               B => sairegmult,
                               saida => saicomp);
                            

    RD: registrador2 port map( clk => clk,
                                 carga => regd,
                                 d => saicomp,
                                 q => saidacomparador);

    RSAIDA: registrador4 port map( clk => clk,
                                     carga => regsaida,
                                     d => sairegmid,
                                     q => saida);

    SOMASUB: somadorsubtrator port map( a => sairegmid,
                                       b => "0001",
                                       op => selop,
                                       s => saisomasub);

end raiz;