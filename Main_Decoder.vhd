
--Main decoder for Control Unit

--Library Declaration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

--Begin Entity
entity Main_Decoder is
port
(
  OpCode : in std_logic_vector(2 downto 0);
  RegDst, RegWrite, ALUSrc, MemWrite, MemtoReg, Branch, Jump: out std_logic := '0';
  ALUOp : out std_logic_vector(2 downto 0) := (others => '0')
);
end Main_Decoder;

--Begin Architecture
architecture Main_Decoder_Arch of Main_Decoder is
  Signal op: std_logic_vector (2 downto 0);

begin
  op <= opcode;
  process(op)
    begin

    --Decode the op to determine instruction type and set the correct control signals
    case op is
      when "000" =>  --If instruction is R-type
        ALUOp <= "010";
        ALUSrc <= '0';
        RegDst <= '1';
        RegWrite <= '1';
        MemtoReg <= '0';
        MemWrite <= '0';
        Branch <= '0';
        Jump <= '0';

      when "001" =>  --If instruction is I-type...ANDI
        ALUOp <= "011";
        ALUSrc <= '1';
        RegDst <= '0';
        RegWrite <= '1';
        MemtoReg <= '0';
        MemWrite <= '0';
        Branch <= '0';
        Jump <= '0';

      when "010" =>  --If instruction is I-type...SUBI. This Opcode is for ADDI in MIPS standard but here we are using it as SUBI which does not exist in MIPS architecture.
        ALUop <= "001";
        ALUSrc <= '1';
        RegDst <= '0';
        RegWrite <= '1';
        MemtoReg <= '0';
        MemWrite <= '0';
        Branch <= '0';
        Jump <= '0';

      when "011"=>  --If instruction is a load
        ALUop <= "000";
        ALUSrc <= '1';
        RegDst <= '0';
        RegWrite <= '1';
        MemtoReg <= '1';
        MemWrite <= '0';
        Branch <= '0';
        Jump <= '0';

      when "100" =>  --If instruction is a store
        ALUop <= "000";
        MemWrite <= '1';
        ALUSrc <= '1';
        RegDst <= 'X';
        Branch <= '0';
        MemtoReg <= 'X';
        RegWrite <= '0';
        Jump <= '0';

      when "101" => --If instruction is a branch
        ALUop <= "001";
        Branch <= '1';
        MemWrite <= '0';
        ALUSrc <= '0';
        RegDst <= 'X';
        MemtoReg <= 'X';
        RegWrite <= '0';
        Jump <= '0';

      when "110" => --If instruction is a jump
        ALUop <= "000";
        Branch <= '0';
        MemWrite <= '0';
        ALUSrc <= 'X';
        RegDst <= 'X';
        MemtoReg <= 'X';
        RegWrite <= '0';
        Jump <= '1';

      when others =>		--signals are don't cares
        RegWrite <= 'X';
        MemtoReg <= 'X';
        MemWrite <= 'X';
        ALUSrc <= 'X';
        RegDst <= 'X';
        Branch <= 'X';
	      ALUop <= "XXX";
  end case;

end process;

end Main_Decoder_Arch;
