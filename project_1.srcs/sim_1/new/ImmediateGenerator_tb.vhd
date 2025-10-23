library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ImmediateGenerator_tb is
end ImmediateGenerator_tb;

architecture behavior of ImmediateGenerator_tb is

    component ImmediateGenerator
        Port (
            Imm_in  : in  std_logic_vector(11 downto 0);
            Imm_out : out std_logic_vector(31 downto 0)
        );
    end component;

    signal Imm_in  : std_logic_vector(11 downto 0) := (others => '0');
    signal Imm_out : std_logic_vector(31 downto 0);

begin

    uut: ImmediateGenerator
        port map (
            Imm_in  => Imm_in,
            Imm_out => Imm_out
        );

    stim_proc: process
    begin
        Imm_in <= "000000001111";
        wait for 10 ns;

        Imm_in <= "111110000000";
        wait for 10 ns;

        Imm_in <= "111111111111";
        wait for 10 ns;

        Imm_in <= "000000000000";
        wait for 10 ns;

        wait;
    end process;

end behavior;
