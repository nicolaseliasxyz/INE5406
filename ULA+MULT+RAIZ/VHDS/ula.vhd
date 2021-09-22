library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity ULA is
    Port (
    A, B     : in  STD_LOGIC_VECTOR(7 downto 0);
    ULA_Sel  : in  STD_LOGIC_VECTOR(3 downto 0);
    clk, clk_raiz, clk_mult, Reset, inicio_mult, inicio_raiz: in STD_LOGIC;
    prontoraiz, prontomult   : out STD_LOGIC;
    ULA_Out_Mult   : out  STD_LOGIC_VECTOR(15 downto 0);
    ULA_Out_Result   : out  STD_LOGIC_VECTOR(7 downto 0);
    conteudoA,conteudoB: out STD_LOGIC_VECTOR(7 DOWNTO 0));
end ULA; 
architecture Behavioral of ULA is

    component multiplicador is
        port ( Reset, clk, inicio : in std_logic;
                entA, entB : in std_logic_vector(7 downto 0);
                pronto : out std_logic;
                conteudoA, conteudoB: out std_logic_vector(7 downto 0);
                saida: out std_logic_vector(15 downto 0));
    end component;

    component raiz is
        port (entrada: in std_logic_vector(7 downto 0);
          inicio, reset, clk: in std_logic;
          saida: out std_logic_vector(7 downto 0);
          pronto: out std_logic);
    end component;

    component mux11X1 is
        PORT (soma, sub, amais, amenos, nota, aandb, aorb, axorb, mult, raiz, halt : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            sel: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            y : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
  END component;

signal ULA_Result, Result_Raiz  : std_logic_vector (7 downto 0);
signal ULA_Result_Mult, Result_Mult : std_logic_vector (15 downto 0);
signal ula_soma, ula_sub, ula_amais, ula_amenos, ula_nota, ula_aandb, ula_aorb, ula_axorb, ula_mult, ula_raiz, ula_halt: std_logic_vector (7 downto 0);
begin

    MULT1: multiplicador port map (entA => A,
                                   entB => B,
                                   clk => clk_mult,
                                   inicio => inicio_mult,
                                   reset => Reset,
                                   conteudoA => conteudoA,
                                   conteudoB => conteudoB,
                                   saida => Result_Mult,
                                   pronto => prontomult);

    RAIZ1: raiz port map(entrada => A,
                        inicio => inicio_raiz,
                        reset => Reset,
                        clk => clk_raiz,
                        pronto => prontoraiz,
                        saida => Result_Raiz);

    MUX11P1: mux11X1 port map(sel => ULA_Sel,
										  soma => ula_soma,
                                sub => ula_sub,
                                amais => ula_amais,
                                amenos => ula_amenos,
                                nota => ula_nota,
                                aandb => ula_aandb,
                                aorb => ula_aorb,
                                axorb => ula_axorb,
                                mult => ula_mult,
                                raiz => ula_raiz,
                                halt => ula_halt,
                                y => ULA_Result);

    ula_soma <= A + B;
    ula_sub <= A - B;
    ula_amais <= A + "00000001";
    ula_amenos <= A - "00000001";
    ula_nota <= NOT(A);
    ula_aandb <= A AND B;
    ula_aorb <= A OR B;
    ula_axorb <= A XOR B;
    ula_mult <= Result_Mult(7 downto 0);
    ula_raiz <= Result_Raiz;
    ula_halt <= "00000000";

    --//Processo do monociclo para atualização da saida caso ULA_Sel seja uma multiplicacao ou uma raiz
    PROCESS (clk)
    BEGIN
    if (clk'EVENT AND clk = '1') then
        ULA_Out_Mult <= Result_Mult;
        ULA_Out_Result <= ULA_Result;
    end if;
    end process;
end Behavioral;