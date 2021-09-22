LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY tb IS
END tb;

ARCHITECTURE estrutura OF tb IS
signal Reset, clk, inicio, pronto: std_logic;
signal dado: std_logic_vector(10 downto 0);
signal flagZ: std_logic_vector(3 downto 0);
signal saida: std_logic_vector(7 downto 0);

constant clkp: time:= 5 ns;

COMPONENT ulamult IS
PORT (Reset, clk, inicio : in std_logic;
      dado: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
      pronto: out std_logic;
      flagZ: OUT std_logic_vector(3 downto 0);
      saida: out std_logic_vector(7 downto 0));
END COMPONENT;

BEGIN
    UUT: entity work.ulamult port map(Reset => Reset,
                                      clk => clk,
                                      inicio => inicio,
                                      dado => dado,
                                      pronto => pronto,
                                      flagZ => flagZ,
                                      saida => saida);

    clock_simulate: process
    begin
        clk <= '0'; wait for clkp/2;
        clk <= '1'; wait for clkp/2;
    end process;

    estimulo: process
    begin
        Reset <= '1'; wait for clkp;
        Reset <= '0'; wait for clkp;
        dado <= "10000100010"; wait for clkp;
        inicio <= '1'; wait for clkp;
        inicio <= '0'; wait for clkp*50;
    end process;

END estrutura;