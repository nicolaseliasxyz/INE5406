LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity raiz is
    port (entrada: in std_logic_vector(7 downto 0);
          inicio, reset, clk: in std_logic;
          saida: out std_logic_vector(7 downto 0);
          pronto: out std_logic);
end raiz;

architecture toplevel of raiz is

    signal regstart, regend, regmid, regmult, regd, regsaida, sela, selb, selop: std_logic;
    signal comparador: std_logic_vector(1 downto 0);

    component bcraiz IS
    PORT (Reset, clk, INICIAL: IN STD_LOGIC;
          ent_comp: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
          pronto: OUT STD_LOGIC;
          regstart, regend, regmid, regmult, regd, regsaida, sela, selb, selop: OUT STD_LOGIC
          );
    END component;

    component boraiz is
        port(
            entrada_x: in std_logic_vector(7 downto 0);
            regstart, regend, regmid, regmult, regd, regsaida, sela, selb, selop: in std_logic;
            clk: in std_logic;
            saidacomparador: out std_logic_vector(1 downto 0);
            saida: out std_logic_vector(7 downto 0)
        );
    end component;

begin

    BORAIZ1: boraiz port map ( entrada_x => entrada,
                      regstart => regstart,
                      regend => regend,
                      regmid => regmid,
                      regmult => regmult,
                      regd => regd,
                      regsaida => regsaida,
                      sela => sela,
                      selb => selb,
                      selop => selop,
                      clk => clk,
                      saidacomparador => comparador,
                      saida => saida);

    bcraiz1: bcraiz port map ( Reset => reset,
                      clk => clk,
                      INICIAL => inicio,
                      ent_comp => comparador,
                      pronto => pronto,
                      regstart => regstart,
                      regend => regend,
                      regmid => regmid,
                      regmult => regmult,
                      regd => regd,
                      regsaida => regsaida,
                      sela => sela,
                      selb => selb,
                      selop => selop);

end toplevel;