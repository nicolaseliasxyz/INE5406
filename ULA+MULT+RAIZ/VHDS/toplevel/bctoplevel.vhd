LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bctoplevel IS
PORT (Reset, clk, inicio : IN STD_LOGIC;
      pronto : OUT STD_LOGIC;
      CA, CB, COP, PC, CSAIDA, CM: OUT STD_LOGIC;
      OPCODE: IN STD_LOGIC_VECTOR(3 DOWNTO 0));

END bctoplevel;

ARCHITECTURE estrutura OF bctoplevel IS
    TYPE STATES IS (INICIO, ENDERECO, BUSCA, OPCODE, VALORA, VALORB, ULA, SAIDAS);
    SIGNAL EAtual, PEstado: STATES;
BEGIN
    PROCESS (clk, Reset)
    BEGIN
        if(Reset = '1') THEN
            EAtual <= INICIO;
        elsif (clk'EVENT AND clk = '1') then
            EAtual <= PEstado;
        end if;
    end process;
    
    process(EAtual, PEstado, inicio, proximo, OPCODE)
    begin
            CASE EAtual IS
                WHEN INICIO =>
                    CM <= '0';
                    CA <= '0';
                    CB <= '0';
                    COP <= '0';
                    CSAIDA <= '0';
                    PC <= '0';
                    pronto <= '0';
                    proximo <= "00";
                    if (inicio = '0') then
                        PEstado <= INICIO;
                    else
                        PEstado <= ENDERECO;
                    end if;

                WHEN PC =>
                    CM <= '0';
                    CA <= '0';
                    CB <= '0';
                    COP <= '0';
                    CSAIDA <= '0';
                    PC <= '1';
                    pronto <= '0';
                    proximo <= "00";

                    PEstado <= ENDERECO;
  
                WHEN ENDERECO =>
                    CM <= '0'; 
                    CA <= '0';
                    CB <= '0';
                    COP <= '0';
                    CSAIDA <= '0';
                    PC <= '0';
                    pronto <= '0';

                    PEstado <= BUSCA;
                    

                WHEN BUSCA =>
                    CM <= '0';
                    CA <= '0';
                    CB <= '0';
                    COP <= '0';
                    CSAIDA <= '0';
                    PC <= '0';
                    pronto <= '0';
                    if (proxima = "00") then
                         PEstado <= OPCODE;
                    elsif (proxima = "01") then
                         PEstado <= VALORA;
                    elsif (proxima = "10") then
                         PEstado <= VALORB;
                    else
                        PEstado <= BUSCA;
                    end if;

                WHEN OPCODE =>
                    CM <= '0';
                    CA <= '0';
                    CB <= '0';
                    COP <= '1';
                    CSAIDA <= '0';
                    PC <= '0';
                    pronto <= '0';
                    proximo <= "01";
            
                    PEstado <= PC;

                WHEN VALORA =>
                    CM <= '0';
                    CA <= '1';
                    CB <= '0';
                    COP <= '0';
                    CSAIDA <= '0';
                    PC <= '0';
                    pronto <= '0';
                    proximo <= "10";
                    if (OPCODE = "0011" OR OPCODE = "0100" OR OPCODE = "0101" OR OPCODE = "1010") then
                        PEstado <= ULA;
                    else
                        PEstado <= PC;
                    end if;

                WHEN VALORB =>
                    CM <= '0';
                    CA <= '0';
                    CB <= '1';
                    COP <= '0';
                    CSAIDA <= '0';
                    PC <= '0';
                    pronto <= '0';
                    proxima <= "10";
            
                    PEstado <= ULA;

                WHEN ULA =>
                    CM <= '0';
                    CA <= '0';
                    CB <= '0';
                    COP <= '0';
                    CSAIDA <= '0';
                    PC <= '0';
                    pronto <= '0';
            
                    PEstado <= SAIDAS;

                WHEN SAIDAS =>
                    CM <= '1';
                    CA <= '0';
                    CB <= '0';
                    COP <= '0';
                    CSAIDA <= '1';
                    PC <= '0';
                    pronto <= '1';
            
                    PEstado <= INICIO;

            END CASE;        
    END PROCESS;
END estrutura;