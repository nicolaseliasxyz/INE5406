LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (Reset, clk, inicio, mult_on, mult_pronto: IN STD_LOGIC;
      pronto: OUT STD_LOGIC;
      enA, enB, enOp, enOut: OUT STD_LOGIC);
END bc;

ARCHITECTURE estrutura OF bc IS
    TYPE STATES IS (S0, S1, S2, S3);
    SIGNAL EAtual, PEstado: STATES;
BEGIN
    PROCESS (clk, Reset)
    BEGIN
        if(Reset = '1') THEN
            EAtual <= S0;
        elsif (clk'EVENT AND clk = '1') then
            EAtual <= PEstado;
        end if;
    end process;
    
    process(EAtual, PEstado, inicio)
    begin
            CASE EAtual IS
                WHEN S0 =>
                    enA <= '0';
                    enB <= '0';
                    enOp <= '0';
                    enOut <= '0';
                    pronto <= '0';
                    if (inicio = '0') then
                        PEstado <= S0;
                    else
                        PEstado <= S1;
                    end if;

                WHEN S1 => 
                    enA <= '1';
                    enB <= '1';
                    enOp <= '1';
                    enOut <= '0';
                    pronto <= '0';

                    PEstado <= S2;

                WHEN S2 =>
                    enA <= '0';
                    enB <= '0';
                    enOp <= '0';
                    enOut <= '0';
                    pronto <= '0';
                    
                    if (mult_on = '0') then
                        PEstado <= S3;
                    elsif (mult_pronto = '0') then
                        PEstado <= S2;
                    else
                        PEstado <= S3;
                    end if;

                WHEN S3 =>
                    enA <= '0';
                    enB <= '0';
                    enOp <= '0';
                    enOut <= '1';
                    pronto <= '1';

                    PEstado <= S0;
            END CASE;        
    END PROCESS;
END estrutura;