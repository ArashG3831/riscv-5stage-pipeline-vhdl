library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile_tb is
end RegisterFile_tb;

architecture behavior of RegisterFile_tb is

    component RegisterFile
        Port (
            clk      : in  std_logic;
            RegWEn   : in  std_logic;
            A_addr   : in  std_logic_vector(4 downto 0);
            B_addr   : in  std_logic_vector(4 downto 0);
            D_addr   : in  std_logic_vector(4 downto 0);
            D_data   : in  std_logic_vector(31 downto 0);
            A_data   : out std_logic_vector(31 downto 0);
            B_data   : out std_logic_vector(31 downto 0)
        );
    end component;

    signal clk     : std_logic := '0';
    signal RegWEn  : std_logic := '0';
    signal A_addr  : std_logic_vector(4 downto 0) := (others => '0');
    signal B_addr  : std_logic_vector(4 downto 0) := (others => '0');
    signal D_addr  : std_logic_vector(4 downto 0) := (others => '0');
    signal D_data  : std_logic_vector(31 downto 0) := (others => '0');
    signal A_data  : std_logic_vector(31 downto 0);
    signal B_data  : std_logic_vector(31 downto 0);

begin

    uut: RegisterFile
        port map (
            clk     => clk,
            RegWEn  => RegWEn,
            A_addr  => A_addr,
            B_addr  => B_addr,
            D_addr  => D_addr,
            D_data  => D_data,
            A_data  => A_data,
            B_data  => B_data
        );

    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    stim_proc: process
    begin
        RegWEn <= '1';
        D_addr <= "00001";  -- R1
        D_data <= x"AAAA0001";
        wait for 10 ns;

        D_addr <= "00010";  -- R2
        D_data <= x"BBBB0002";
        wait for 10 ns;

        RegWEn <= '0';
        wait for 10 ns;

        A_addr <= "00001";
        B_addr <= "00010";
        wait for 10 ns;

        A_addr <= "00000";
        B_addr <= "00000";
        wait for 10 ns;

        wait;
    end process;

end behavior;
