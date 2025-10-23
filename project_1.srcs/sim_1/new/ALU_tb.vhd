library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_tb is
end ALU_tb;

architecture behavior of ALU_tb is

    component ALU
        Port (
            A       : in  std_logic_vector(31 downto 0);
            B       : in  std_logic_vector(31 downto 0);
            ALU_Sel : in  std_logic_vector(1 downto 0);
            Result  : out std_logic_vector(31 downto 0)
        );
    end component;

    signal A       : std_logic_vector(31 downto 0) := (others => '0');
    signal B       : std_logic_vector(31 downto 0) := (others => '0');
    signal ALU_Sel : std_logic_vector(1 downto 0) := (others => '0');
    signal Result  : std_logic_vector(31 downto 0);

begin

    uut: ALU
        port map (
            A => A,
            B => B,
            ALU_Sel => ALU_Sel,
            Result => Result
        );

    stim_proc: process
    begin
        A <= std_logic_vector(to_signed(5, 32));
        B <= std_logic_vector(to_signed(10, 32));
        ALU_Sel <= "00";
        wait for 10 ns;

        A <= std_logic_vector(to_signed(20, 32));
        B <= std_logic_vector(to_signed(8, 32));
        ALU_Sel <= "01";
        wait for 10 ns;

        A <= x"FFFF0000";
        B <= x"0F0F0F0F";
        ALU_Sel <= "10";
        wait for 10 ns;

        A <= x"0000FFFF";
        B <= x"F0F0F0F0";
        ALU_Sel <= "11";
        wait for 10 ns;

        wait;
    end process;

end behavior;
