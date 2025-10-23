library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FetchStage_tb is
end FetchStage_tb;

architecture behavior of FetchStage_tb is

    component ProgramCounter
        Port (
            clk     : in  std_logic;
            reset   : in  std_logic;
            pc_out  : out std_logic_vector(5 downto 0)
        );
    end component;

    component InstructionMemory
        Port (
            address     : in  std_logic_vector(5 downto 0);
            instruction : out std_logic_vector(31 downto 0)
        );
    end component;

    signal clk        : std_logic := '0';
    signal reset      : std_logic := '0';
    signal pc_out     : std_logic_vector(5 downto 0);
    signal instruction: std_logic_vector(31 downto 0);

begin

    PC_inst: ProgramCounter
        port map (
            clk    => clk,
            reset  => reset,
            pc_out => pc_out
        );

    IMEM_inst: InstructionMemory
        port map (
            address     => pc_out,
            instruction => instruction
        );

    clk_process: process
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
        reset <= '1';
        wait for 10 ns;
        reset <= '0';

        wait for 100 ns;
        wait;
    end process;

end behavior;
