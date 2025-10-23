library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CPU is
    Port (
        clk   : in  std_logic;
        reset : in  std_logic
    );
end CPU;

architecture Behavioral of CPU is

    component ProgramCounter
        Port ( clk : in std_logic; reset : in std_logic; pc_out : out std_logic_vector(5 downto 0) );
    end component;

    component InstructionMemory
        Port ( address : in std_logic_vector(5 downto 0); instruction : out std_logic_vector(31 downto 0) );
    end component;

    component ControlUnit
        Port (
            opcode    : in std_logic_vector(6 downto 0);
            funct3    : in std_logic_vector(2 downto 0);
            funct7    : in std_logic_vector(6 downto 0);
            ALUSel    : out std_logic_vector(2 downto 0);
            BSel      : out std_logic;
            RegWEn    : out std_logic;
            MemRW     : out std_logic;
            MemtoReg  : out std_logic
        );
    end component;

    component RegisterFile
        Port (
            clk     : in  std_logic;
            RegWEn  : in  std_logic;
            A_addr  : in  std_logic_vector(4 downto 0);
            B_addr  : in  std_logic_vector(4 downto 0);
            D_addr  : in  std_logic_vector(4 downto 0);
            D_data  : in  std_logic_vector(31 downto 0);
            A_data  : out std_logic_vector(31 downto 0);
            B_data  : out std_logic_vector(31 downto 0)
        );
    end component;

    component ImmediateGenerator
        Port (
            Imm_in  : in  std_logic_vector(11 downto 0);
            Imm_out : out std_logic_vector(31 downto 0)
        );
    end component;

    component ALU
        Port (
            A       : in  std_logic_vector(31 downto 0);
            B       : in  std_logic_vector(31 downto 0);
            ALU_Sel : in  std_logic_vector(2 downto 0);
            Result  : out std_logic_vector(31 downto 0)
        );
    end component;

    component DataMemory
        Port (
            clk        : in  std_logic;
            MemRW      : in  std_logic;
            address    : in  std_logic_vector(31 downto 0);
            write_data : in  std_logic_vector(31 downto 0);
            read_data  : out std_logic_vector(31 downto 0)
        );
    end component;

    signal pc_out        : std_logic_vector(5 downto 0);
    signal instruction   : std_logic_vector(31 downto 0);

    signal opcode        : std_logic_vector(6 downto 0);
    signal funct3 : std_logic_vector(2 downto 0);
    signal funct7        : std_logic_vector(6 downto 0);
    signal rs1, rs2, rd  : std_logic_vector(4 downto 0);
    signal imm12         : std_logic_vector(11 downto 0);

    signal ALUSel        : std_logic_vector(2 downto 0);
    signal BSel          : std_logic;
    signal RegWEn        : std_logic;
    signal MemRW         : std_logic;
    signal MemtoReg      : std_logic;

    signal A_data, B_data : std_logic_vector(31 downto 0);
    signal imm32          : std_logic_vector(31 downto 0);
    signal B_mux_out      : std_logic_vector(31 downto 0);
    signal ALU_result     : std_logic_vector(31 downto 0);
    signal mem_data_out   : std_logic_vector(31 downto 0);
    signal write_data     : std_logic_vector(31 downto 0);
    signal writeback_data : std_logic_vector(31 downto 0);

begin


    PC: ProgramCounter
        port map ( clk => clk, reset => reset, pc_out => pc_out );

    IMEM: InstructionMemory
        port map ( address => pc_out, instruction => instruction );

    CU: ControlUnit
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

    RF: RegisterFile
        port map (
            clk     => clk,
            RegWEn  => RegWEn,
            A_addr  => rs1,
            B_addr  => rs2,
            D_addr  => rd,
            D_data  => writeback_data,
            A_data  => A_data,
            B_data  => B_data
        );

    IMM: ImmediateGenerator
        port map (
            Imm_in  => imm12,
            Imm_out => imm32
        );

    ALU1: ALU
        port map (
            A        => A_data,
            B        => B_mux_out,
            ALU_Sel  => ALUSel,
            Result   => ALU_result
        );

    DMEM: DataMemory
        port map (
            clk        => clk,
            MemRW      => MemRW,
            address    => ALU_result,
            write_data => B_data,
            read_data  => mem_data_out
        );


    opcode  <= instruction(6 downto 0);
    rd      <= instruction(11 downto 7);
    funct3  <= instruction(14 downto 12);
    rs1     <= instruction(19 downto 15);
    rs2     <= instruction(24 downto 20);
    funct7  <= instruction(31 downto 25);
    imm12   <= instruction(31 downto 20);


    B_mux_out <= imm32 when BSel = '1' else B_data;
    writeback_data <= mem_data_out when MemtoReg = '1' else ALU_result;

end Behavioral;
