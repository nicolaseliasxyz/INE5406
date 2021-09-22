LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity toplevel is
    port (reset, clk, clk_mult, clk_raiz, inicio_mult, inicio_raiz, inicio: in std_Logic;
            prontoraiz, prontomult: out std_logic;
            Multip: out std_Logic_vector(15 downto 0);
            Result: out std_logic_vector(7 downto 0);
            conteudoA,conteudoB: out STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
end toplevel;

architecture comportamento of toplevel is

    signal S_COP, S_CB, S_CA, S_CSAIDA, S_CM, S_CPC: STD_LOGIC;

    component bctoplevel IS
        PORT (Reset, clk, inicio : IN STD_LOGIC;
        pronto : OUT STD_LOGIC;
        CA, CB, COP, PC, CSAIDA: OUT STD_LOGIC;
        OPCODE: IN STD_LOGIC_VECTOR(3 DOWNTO 0));
    END component;

    component botoplevel IS
    PORT (clk : IN STD_LOGIC;
          COP, CB, CA, CSAIDA, CM, CPC: IN STD_LOGIC;
          clk, clk_raiz, clk_mult, Reset, inicio_mult, inicio_raiz: in std_logic;
          prontoraiz, prontomult: out std_logic;
          saida_mult: out std_logic_vector(15 downto 0);
          saida: out std_logic_vector(7 downto 0);
          conteudoA,conteudoB: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    END component;

begin

    BOTOP1: botoplevel port map (Reset => reset,
                                clk => clk,
                                clk_raiz => clk_raiz,
                                clk_mult => clk_mult,
                                inicio_mult => inicio_mult,
                                inicio_raiz => inicio_raiz,
                                prontoraiz => prontoraiz,
                                prontomult => prontomult,
                                saida_mult => Multip,
                                saida => Result,
                                conteudoA => conteudoA,
                                conteudoB => conteudoB,
                                CM => S_CM,
                                CA => S_CA,
                                CB=> S_CB,
                                COP=> S_COP,
                                PC=> S_CPC,
                                CSAIDA=> S_CSAIDA);

    BCTOP1: bctoplevel port map (Reset => reset,
                                 clk => clk,
                                 inicio => inicio,
                                 CM => S_CM,
                                 CA => S_CA,
                                 CB=> S_CB,
                                 COP=> S_COP,
                                 PC=> S_CPC,
                                 CSAIDA=> S_CSAIDA);

end comportamento;