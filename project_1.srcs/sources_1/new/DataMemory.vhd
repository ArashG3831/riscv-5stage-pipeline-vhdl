library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMemory is
    Port (
        clk        : in  std_logic;
        MemRW      : in  std_logic;
        address    : in  std_logic_vector(31 downto 0);
        write_data : in  std_logic_vector(31 downto 0);
        read_data  : out std_logic_vector(31 downto 0)
    );
end DataMemory;

architecture Behavioral of DataMemory is
    type memory_array is array (0 to 63) of std_logic_vector(31 downto 0);
    signal RAM : memory_array := (
        8 => x"DEADBEEF",  -- variable
        others => (others => '0')
    );
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if MemRW = '1' then
                RAM(to_integer(unsigned(address(7 downto 2)))) <= write_data;
            end if;
        end if;
    end process;

    read_data <= RAM(to_integer(unsigned(address(7 downto 2))));

end Behavioral;
