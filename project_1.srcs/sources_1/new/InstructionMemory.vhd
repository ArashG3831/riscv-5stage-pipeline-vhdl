library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory is
    Port (
        address     : in  std_logic_vector(5 downto 0);
        instruction : out std_logic_vector(31 downto 0)
    );
end InstructionMemory;

architecture Behavioral of InstructionMemory is
    type memory_array is array (0 to 63) of std_logic_vector(31 downto 0);
    
--    signal ROM : memory_array := (
--        0 => x"00500093",   -- addi x1,x0,5
--        1 => x"00A00113",   -- addi x2,x0,10
--        2 => x"00700193",   -- addi x3,x0,7
--        3 => x"00208233",   -- add  x4,x1,x2
--        4 => x"003202B3",   -- add  x5,x4,x3
--        others => (others => '0')
--    );
    
--    signal ROM : memory_array := (
--        0 => x"00C00093",   -- addi x1,x0,12
--        1 => x"00A00113",   -- addi x2,x0,10
--        2 => x"0020F1B3",   -- and  x3,x1,x2
--        3 => x"0020E233",   -- or   x4,x1,x2
--        others => (others => '0')
--    );

--    signal ROM : memory_array := (
--        0 => x"01400093",   -- addi x1,x0,20
--        1 => x"FFB08113",   -- addi x2,x1,-5
--        2 => x"00F0F193",   -- andi x3,x1,0x0F
--        3 => x"00116213",   -- ori  x4,x2,0x01
--        others => (others => '0')
--    );

    signal ROM : memory_array := (
        0 => x"00800093",   -- addi x1,x0,8
        1 => x"02A00113",   -- addi x2,x0,42
        2 => x"0020A023",   -- sw   x2,0(x1)
        3 => x"FFD08093",   -- addi x1,x1,-3
        4 => x"0030A183",   -- lw   x3,3(x1)
        others => (others => '0')
    );


begin
    instruction <= ROM(to_integer(unsigned(address)));
end Behavioral;
