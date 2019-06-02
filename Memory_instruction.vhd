--This is the Instruction Memory block of the MIPS processor.
--This memory block can hold a  program size of 2048 bytes
--Each instruction is 4 bytes(32 bits) implying that we can have up to 
--512 instructions (512*4=1024) 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Im_Mem is 

port
(
pc: in std_logic_vector(31 downto 0); --program counter output and input to IM
Im_output: out std_logic_vector(31 downto 0) --Output the 32-bit instruction
); 
end Im_Mem;


architecture  IM_Arch of Im_Mem is 
type Im_Block is array (0 to 2047) of std_logic_vector (7 downto 0);
signal I: Im_Block := (others=>(others=>'0'));

begin



I(0) <= X"04"; I(1) <= X"62"; I(2) <= X"00"; I(3) <= X"20"; -- ADD R2, R3, R1 (R1=R2 + R3) 
I(4) <= X"4E"; I(5) <= X"C0"; I(6) <= X"00"; I(7) <= X"32"; -- subi r6=r7-h32 
I(8) <= X"0E"; I(9) <= X"2C"; I(10) <= X"00"; I(11) <= X"26"; -- XOR R7 R1 R6 (R6= R7 XOR R1) 
I(12) <= X"0D"; I(13) <= X"AC"; I(14) <= X"00"; I(15) <= X"22"; -- SUB r6 = r6 - r13 
I(16) <= X"33"; I(17) <= X"00"; I(18) <= X"00"; I(19) <= X"2B"; -- ANDI R9 R8 IMM (R8= R9 & IMM)
I(20) <= X"19"; I(21) <= X"A8"; I(22) <= X"00"; I(23) <= X"24"; --AND r4 = r12& r13   
I(24) <= X"6B"; I(25) <= X"80"; I(26) <= X"00"; I(27) <= X"00"; -- storing r5 value to r12 
--I(28) <= X"79"; I(29) <= X"60"; I(30) <= X"00"; I(31) <= X"00"; -- loading  r12 value to r11
I(28) <= X"1A"; I(29) <= X"00"; I(30) <= X"00"; I(31) <= X"08"; -- jump to reg 13
I(32) <= X"63"; I(33) <= X"60"; I(34) <= X"00"; I(35) <= X"00"; -- loading  r1 value to r11
I(36) <= X"A7"; I(37) <= X"A0"; I(38) <= X"00"; I(39) <= X"07"; -- BEQ R3 R13 jump  	
I(40) <= X"4E"; I(41) <= X"C0"; I(42) <= X"00"; I(43) <= X"32"; -- SUBi 

I(44) <= X"04"; I(45) <= X"62"; I(46) <= X"00"; I(47) <= X"20"; -- ADD R2, R3, R1 (R1=R2 + R3) 
I(48) <= X"1A"; I(49) <= X"00"; I(50) <= X"00"; I(51) <= X"08"; -- jump to reg 13
I(68) <= X"4E"; I(69) <= X"C0"; I(70) <= X"00"; I(71) <= X"32"; -- subi r6=r7-h32 
I(72) <= X"0E"; I(73) <= X"2C"; I(74) <= X"00"; I(75) <= X"26"; -- XOR R7 R1 R6 (R6= R7 XOR R1) 
I(76) <= X"0D"; I(77) <= X"AC"; I(78) <= X"00"; I(79) <= X"22"; -- SUB r6 = r6 - r13 
I(80) <= X"33"; I(81) <= X"00"; I(82) <= X"00"; I(83) <= X"2B"; -- ANDI R9 R8 IMM (R8= R9 & IMM)
I(84) <= X"19"; I(85) <= X"A8"; I(86) <= X"00"; I(87) <= X"24"; --AND r4 = r12& r13  

--I(0) <= X"04"; I(1) <= X"62"; I(2) <= X"00"; I(3) <= X"20"; -- ADD R2, R3, R1 (R1=R2 + R3) 
--I(4) <= X"4E"; I(5) <= X"C0"; I(6) <= X"00"; I(7) <= X"32"; -- subi r6=r7-h32 
--I(8) <= X"0E"; I(9) <= X"2C"; I(10) <= X"00"; I(11) <= X"26"; -- XOR R7 R1 R6 (R6= R7 XOR R1) 
--I(12) <= X"0D"; I(13) <= X"AC"; I(14) <= X"00"; I(15) <= X"22"; -- SUB r12 = r6 - r13 
--I(16) <= X"33"; I(17) <= X"00"; I(18) <= X"00"; I(19) <= X"2B"; -- ANDI R9 R8 IMM (R8= R9 & IMM)
--I(20) <= X"19"; I(21) <= X"A8"; I(22) <= X"00"; I(23) <= X"24"; --AND r4 = r12& r13  
  Im_output <= I(to_integer(unsigned(pc))) & I(to_integer(unsigned(pc))+1) & I(to_integer(unsigned(pc)) +  2) & I(to_integer(unsigned(pc)) +3);

end IM_Arch;
