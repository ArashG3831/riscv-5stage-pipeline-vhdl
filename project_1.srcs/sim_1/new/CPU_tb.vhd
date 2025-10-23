library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CPU_tb is
end CPU_tb;

architecture behavior of CPU_tb is

    component CPU
        Port (
            clk   : in  std_logic;
            reset : in  std_logic
        );
    end component;

    signal clk   : std_logic := '0';
    signal reset : std_logic := '1';

begin

    uut: CPU
        port map (
            clk   => clk,
            reset => reset
        );

    clk_process: process
    begin
        wait for 0 ns;
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    stim_proc: process
    begin
        wait for 10 ns;
        reset <= '0';

        wait for 100 ns;

        wait;
    end process;

end behavior;
