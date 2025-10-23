library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit_tb is
end ControlUnit_tb;

architecture behavior of ControlUnit_tb is

    component ControlUnit
        Port (
            opcode    : in  std_logic_vector(6 downto 0);
            funct3    : in  std_logic_vector(2 downto 0);
            funct7    : in  std_logic_vector(6 downto 0);
            ALUSel    : out std_logic_vector(2 downto 0);
            BSel      : out std_logic;
            RegWEn    : out std_logic;
            MemRW     : out std_logic;
            MemtoReg  : out std_logic
        );
    end component;

    signal opcode    : std_logic_vector(6 downto 0) := (others => '0');
    signal funct3    : std_logic_vector(2 downto 0) := (others => '0');
    signal funct7    : std_logic_vector(6 downto 0) := (others => '0');
    signal ALUSel    : std_logic_vector(2 downto 0);
    signal BSel      : std_logic;
    signal RegWEn    : std_logic;
    signal MemRW     : std_logic;
    signal MemtoReg  : std_logic;

begin

    uut: ControlUnit
        port map (
            opcode    => opcode,
            funct3    => funct3,
            funct7    => funct7,
            ALUSel    => ALUSel,
            BSel      => BSel,
            RegWEn    => RegWEn,
            MemRW     => MemRW,
            MemtoReg  => MemtoReg
        );

    stim_proc: process
    begin
        opcode <= "0110011"; funct3 <= "000"; funct7 <= "0000000"; wait for 10 ns;
        opcode <= "0110011"; funct3 <= "000"; funct7 <= "0100000"; wait for 10 ns;
        opcode <= "0110011"; funct3 <= "111"; funct7 <= "0000000"; wait for 10 ns;
        opcode <= "0110011"; funct3 <= "110"; funct7 <= "0000000"; wait for 10 ns;

        opcode <= "0010011"; funct3 <= "000"; funct7 <= "XXXXXXX"; wait for 10 ns;
        opcode <= "0010011"; funct3 <= "111"; funct7 <= "XXXXXXX"; wait for 10 ns;
        opcode <= "0010011"; funct3 <= "110"; funct7 <= "XXXXXXX"; wait for 10 ns;

        opcode <= "0000011"; funct3 <= "010"; funct7 <= "XXXXXXX"; wait for 10 ns;

        opcode <= "0100011"; funct3 <= "010"; funct7 <= "XXXXXXX"; wait for 10 ns;

        wait;
    end process;

end behavior;
