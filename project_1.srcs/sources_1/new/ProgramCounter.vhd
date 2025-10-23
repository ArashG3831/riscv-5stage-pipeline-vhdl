library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ProgramCounter is
    Port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        pc_out  : out std_logic_vector(5 downto 0)
    );
end ProgramCounter;

architecture Behavioral of ProgramCounter is
    signal pc : unsigned(5 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                pc <= (others => '0');
            else
                pc <= pc + 1;
            end if;
        end if;
    end process;

    pc_out <= std_logic_vector(pc);
end Behavioral;
