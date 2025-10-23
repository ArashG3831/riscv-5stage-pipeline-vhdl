library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        A       : in  std_logic_vector(31 downto 0);
        B       : in  std_logic_vector(31 downto 0);
        ALU_Sel : in  std_logic_vector(2 downto 0);
        Result  : out std_logic_vector(31 downto 0)
    );
end ALU;

architecture Behavioral of ALU is
begin
    process(A, B, ALU_Sel)
        variable A_int : signed(31 downto 0);
        variable B_int : signed(31 downto 0);
        variable R_int : signed(31 downto 0);
    begin
        A_int := signed(A);
        B_int := signed(B);

        case ALU_Sel is
            when "000" =>  -- ADD
                R_int := A_int + B_int;
            when "001" =>  -- SUB
                R_int := A_int - B_int;
            when "010" =>  -- AND
                R_int := A_int and B_int;
            when "011" =>  -- OR
                R_int := A_int or B_int;
            when others =>
                R_int := (others => '0');
        end case;

        Result <= std_logic_vector(R_int);
    end process;
end Behavioral;
