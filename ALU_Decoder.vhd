
--ALU Decoder for Control Unit

--Library Declaration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

--Begin Entity
entity ALU_Decoder is
port
(

  Funct : in std_logic_vector(16 downto 0) := (others => '0');
  ALUOp : in std_logic_vector(2 downto 0) := (others => 'X');
  ALUControl : out std_logic_vector(2 downto 0) := (others => 'X')
);
end ALU_Decoder;

--Begin Architecture
architecture ALU_Decoder_Arch of ALU_Decoder is

begin
  process(Funct, ALUOp)
    begin

    case ALUOp is
      when "000" => ALUControl <= "010"; 
      when "001" => ALUControl <= "110"; 
      when "011" => ALUControl <= "000"; 
      when "111" => ALUControl <= "001"; 

      when others => case Funct is --For R-Type Instructions
        when "00000000000100100" =>  ALUControl <= "000"; --AND
        when "00000000000100010" =>  ALUControl <= "110"; --SUB
        when "00000000000100110" =>  ALUControl <= "001"; --XOR
        when "00000000000100000" =>  ALUControl <= "010"; --ADD
        when "00000000000001000" =>  ALUControl <= "010"; --JR
        when others => ALUControl <= "XXX";
    end case;
    end case;
  end process;

end ALU_Decoder_Arch;
