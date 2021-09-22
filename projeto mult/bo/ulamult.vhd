LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.NUMERIC_STD.all;

ENTITY ulamult IS
PORT (Reset, clk, inicio : in std_logic;
      dado: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
      pronto: out std_logic;
      flagZ: OUT std_logic_vector(3 downto 0);
      saida: out std_logic_vector(7 downto 0));
END ulamult;

ARCHITECTURE estrutura OF ulamult IS
signal enA, enB, enOp, enOut, multOn, multPronto: STD_LOGIC;

component bo is
    PORT(clk: in std_logic;
        dado: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        mult_pronto, mult_on: out std_logic;
        saida: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        flagZ: OUT STD_LOGIC_VECTOR(3 downto 0);
        enA, enB, enOp, enOut: in STD_LOGIC);
END COMPONENT;

component bc is
  PORT (Reset, clk, inicio, mult_on, mult_pronto: IN STD_LOGIC;
        pronto: OUT STD_LOGIC;
        enA, enB, enOp, enOut: OUT STD_LOGIC);
END COMPONENT;

BEGIN

    BO1: bo port map(clk => clk,
                     dado => dado,
                     enA => enA,
                     enB => enB,
                     enOp => enOp,
                     enOut => enOut,
                     mult_pronto => multPronto,
                     mult_on => multOn,
                     saida => saida,
                     flagZ => flagZ);

    BC1: bc port map(Reset => Reset,
							       clk => clk,
                     inicio => inicio,
                     pronto => pronto,
                     enA => enA,
                     enB => enB,
                     mult_on => multOn,
                     mult_pronto => multPronto,
                     enOut => enOut,
                     enOp => enOp);

END estrutura;