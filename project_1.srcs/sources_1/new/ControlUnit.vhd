library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
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
end ControlUnit;

architecture Behavioral of ControlUnit is
begin
    process(opcode, funct3, funct7)
    begin
        ALUSel   <= "000";
        BSel     <= '0';
        RegWEn   <= '0';
        MemRW    <= '0';
        MemtoReg <= '0';

        case opcode is

            when "0110011" =>
                BSel    <= '0';
                RegWEn  <= '1';
                MemtoReg <= '0';
                case funct3 is
                    when "000" =>
                        if funct7 = "0000000" then
                            ALUSel <= "000";
                        elsif funct7 = "0100000" then
                            ALUSel <= "001";
                        end if;
                    when "111" => ALUSel <= "010";
                    when "110" => ALUSel <= "011";
                    when others => null;
                end case;

            when "0010011" =>
                BSel    <= '1';
                RegWEn  <= '1';
                MemtoReg <= '0';
                case funct3 is
                    when "000" => ALUSel <= "000";
                    when "111" => ALUSel <= "010";
                    when "110" => ALUSel <= "011";
                    when others => null;
                end case;

            -- LW
            when "0000011" =>
                BSel    <= '1';
                RegWEn  <= '1';
                MemtoReg <= '1';
                ALUSel <= "000";

            -- SW
            when "0100011" =>
                BSel    <= '1';
                RegWEn  <= '0';
                MemRW   <= '1';
                ALUSel <= "000";

            when others => null;

        end case;
    end process;
end Behavioral;
