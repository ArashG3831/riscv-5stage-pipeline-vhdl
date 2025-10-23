library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
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
end RegisterFile;

architecture Behavioral of RegisterFile is
    type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal regs : reg_array := (others => (others => '0'));
begin

    A_data <= regs(to_integer(unsigned(A_addr)));
    B_data <= regs(to_integer(unsigned(B_addr)));

    process(clk)
    begin
        if rising_edge(clk) then
            if RegWEn = '1' then
                regs(to_integer(unsigned(D_addr))) <= D_data;
            end if;
        end if;
    end process;

end Behavioral;
