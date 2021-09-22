--ROM_sevenSegment.vhd

-- created by   :   Meher Krishna Patel
-- date                 :   25-Dec-16

-- Functionality:
  -- seven-segment display format for Hexadecimal values (i.e. 0-F) are stored in ROM 

-- ports:
    -- addr             : input port for getting address
    -- data             : ouput data at location 'addr'
    -- addr_width : total number of elements to store (put exact number)
    -- addr_bits  : bits requires to store elements specified by addr_width
    -- data_width : number of bits in each elements
    
    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    
    entity Rom is
        generic(
            addr_width : integer := 32; -- store 16 elements
            addr_bits  : integer := 5; -- required bits to store 16 elements
            data_width : integer := 8 -- each element has 7-bits
            );
    port(
        addr : in std_logic_vector(addr_bits-1 downto 0);
        data : out std_logic_vector(data_width-1 downto 0)
    );
    end Rom;
    
    architecture arch of Rom is
    
        type rom_type is array (0 to addr_width-1) of std_logic_vector(data_width-1 downto 0);
        
        signal sevenSegment_ROM : rom_type := (00000001;
                                                00001001;
                                                00000100;
                                                00000010;
                                                00001001;
                                                00000100;
                                                00000011;
                                                00001001;
                                                00000100;
                                                00001001;
                                                00000101;
                                                00001001;
                                                00000110;
                                                00001001;
                                                00000100;
                                                00000111;
                                                00001001;
                                                00000100;
                                                00001000;
                                                00001001;
                                                00000100;
                                                00001001;
                                                00001001;
                                                00000100;
                                                00001010;
                                                00001001;
                                                00001011;
                                                00001001;
                                                00000100;
                                                00001010;
                                                10010000;
                                                00001111);
    begin
        data <= sevenSegment_ROM(to_integer(unsigned(addr)));
    end arch; 