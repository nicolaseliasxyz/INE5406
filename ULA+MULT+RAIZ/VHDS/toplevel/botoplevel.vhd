LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY botoplevel IS
generic(N: integer := 8);
PORT (clk : IN STD_LOGIC;
      COP, CB, CA, CSAIDA, CM, CPC: IN STD_LOGIC;
      clk, clk_raiz, clk_mult, Reset, inicio_mult, inicio_raiz: in std_logic;
      prontoraiz, prontomult: out std_logic;
	  saida_mult: out std_logic_vector(15 downto 0);
      saida: out std_logic_vector(7 downto 0);
      conteudoA,conteudoB: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END botoplevel;

ARCHITECTURE estrutura OF botoplevel IS

signal entradaA, entradaB, data: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ULA_Selecao: STD_LOGIC-vector(4 downto 0);
signal Saida_ULA_MULT: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal Saida_ULA: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal entrada_pc, saida_pc1: std_logic_vector(4 downto 0);

component registradortoplevel8 IS
PORT (clk, carga : IN STD_LOGIC;
	  d : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END component;

component registradortoplevel16 IS
PORT (clk, carga : IN STD_LOGIC;
	  d : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	  q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END component;

component registradortoplevel4 IS
generic(N: integer := 4);
PORT (clk, carga : IN STD_LOGIC;
	  d : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	  q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END component;

component Rom is
    generic(
        addr_width : integer := 32; -- store 16 elements
        addr_bits  : integer := 5; -- required bits to store 16 elements
        data_width : integer := 8 -- each element has 7-bits
        );
port(
    addr : in std_logic_vector(addr_bits-1 downto 0);
    data : out std_logic_vector(data_width-1 downto 0)
);
end component;

component ULA is
    Port (
    A, B     : in  STD_LOGIC_VECTOR(7 downto 0);
    ULA_Sel  : in  STD_LOGIC_VECTOR(3 downto 0);
    clk, clk_raiz, clk_mult, Reset, inicio_mult, inicio_raiz: in STD_LOGIC;
    prontoraiz, prontomult   : out STD_LOGIC;
    ULA_Out_Mult   : out  STD_LOGIC_VECTOR(15 downto 0);
    ULA_Out_Result   : out  STD_LOGIC_VECTOR(7 downto 0);
    conteudoA,conteudoB: out STD_LOGIC_VECTOR(7 DOWNTO 0));
end component;

component pc IS
PORT (clk, carga, reset: IN STD_LOGIC;
      pc_counter: in std_logic_vector(4 DOWNTO 0);
	  saida_pc : OUT STD_LOGIC_VECTOR(4 DOWNTO 0));
END component;


begin

    REGOP: registradortoplevel4 port map(clk => clk,
                                         carga => COP,
                                         d => data
                                         q => ULA_Selecao);

    REGA: registradortoplevel8 port map(clk => clk,
                                         carga => CA,
                                         d => data
                                         q => entradaA);

    REGB: registradortoplevel8 port map(clk => clk,
                                         carga => CB,
                                         d => data
                                         q => entradaB);

    REGS: registradortoplevel8 port map(clk => clk,
                                         carga => CSAIDA,
                                         d => Saida_ULA,
                                         q => saida);

    REGM: registradortoplevel16 port map(clk => clk,
                                         carga => CM,
                                         d => Saida_ULA_MULT,
                                         q => saida_mult);

    ULA1: ULA port map(A => entradaA,
                        B => entradaB,
                        clk = > clk,
                        clk_raiz => clk_raiz,
                        clk_mult => clk_mult,
                        inicio_mult => inicio_mult,
                        inicio_mult => inicio_raiz
                        prontoraiz => prontoraiz,
                        prontomult => prontomult,
                        ULA_Out_Result => Saida_ULA,
                        ULA_Out_Mult => Saida_ULA_MULT,
                        conteudoA => conteudoA,
                        conteudob => conteudob);

    ROM1: Rom port map(addr => saida_pc1,
                       data => data);


    entrada_pc <= "00000";

    PC1: PC port map(clk => clk,
                    carga => CPC,
                    pc_counter => entrada_pc,
                    saida_pc => saida_pc1);

END estrutura;