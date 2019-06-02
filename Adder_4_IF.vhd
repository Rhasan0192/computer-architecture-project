
--3 Bit Adder for IF Stage

--Library Declarations
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

--Begin Entity
entity Adder_4bits is
  port (
      Input_adder : in std_logic_vector(31 downto 0) := (others => '0');
      Output_adder : out std_logic_vector(31 downto 0) := (others => '0')
        );
end Adder_4bits;

--Begin Architecture
architecture Adder_4bits_arch of Adder_4bits is
begin
  Output_adder <= (Input_adder + X"4");
end Adder_4bits_arch;
