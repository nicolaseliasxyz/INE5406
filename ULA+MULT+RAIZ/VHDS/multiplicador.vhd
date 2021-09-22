LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity multiplicador is
    generic(N: integer := 8);
    port ( Reset, clk, inicio : in std_logic;
           entA, entB : in std_logic_vector(N-1 downto 0);
           pronto : out std_logic;
           conteudoA, conteudoB: out std_logic_vector(N-1 downto 0);
			  saida: out std_logic_vector(15 downto 0));
end multiplicador;

architecture teste of multiplicador is
    signal BZ, SEL1, cpb, ca: std_logic;

    component bomult is
        PORT (clk : IN STD_LOGIC;
            sel1, CPB, CA : IN STD_LOGIC;
            entA, entB : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
            Bz : OUT STD_LOGIC;
            conteudoA, conteudoB : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				saida: out std_logic_vector(15 downto 0));
    end component;

    component bcmult is
        PORT (Reset, clk, inicio : IN STD_LOGIC;
            Bz : IN STD_LOGIC;
            pronto : OUT STD_LOGIC;
            sel1, CPB, CA : OUT STD_LOGIC );
    END component;

begin

    BCMULT1: bcmult port map(Reset => Reset,
										clk => clk,
										inicio => inicio,
										Bz => BZ,
										pronto => pronto,
										sel1 => SEL1,
										CPB => cpb,
										CA => ca);
    BOMULT1: bomult port map(clk => clk,
										sel1 => SEL1,
										CPB => Cpb,
										CA => ca,
										entA => entA,
										entB => entB,
										Bz => BZ,
										saida => saida,
										conteudoA => conteudoA,
										conteudoB => conteudoB);

end teste;