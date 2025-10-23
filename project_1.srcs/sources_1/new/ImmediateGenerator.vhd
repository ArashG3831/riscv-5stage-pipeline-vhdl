library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ImmediateGenerator is
    Port (
        Imm_in  : in  std_logic_vector(11 downto 0);
        Imm_out : out std_logic_vector(31 downto 0)
    );
end ImmediateGenerator;

architecture Behavioral of ImmediateGenerator is
begin
    process(Imm_in)
    begin
        if Imm_in(11) = '1' then
            Imm_out <= (19 downto 0 => '1') & Imm_in;
        else
            Imm_out <= (19 downto 0 => '0') & Imm_in;
        end if;
    end process;
end Behavioral;
