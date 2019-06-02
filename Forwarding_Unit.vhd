

--Forwarding Unit for Data & Control Hazards

--Library Declaration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

--Begin Entity
entity forward_unit is
port
(
    --Clock : in std_logic := '0';
    WriteRegW, WriteRegM, WriteRegE: IN STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
    RegWriteM, RegWriteW, RegWriteE : IN STD_LOGIC := '0';
    MemtoRegM, MemtoRegE : IN STD_LOGIC := '0';
    
    RsE, RtE: IN STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
    RsD, RtD: IN STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
    BranchD: IN STD_LOGIC := '0';

      
    ForwardAE: OUT STD_LOGIC_VECTOR (1 downto 0) := (others=>'0');	 --mux1 selectexecution stage
    ForwardBE: OUT STD_LOGIC_VECTOR (1 downto 0) := (others=>'0');	 ----mux2 select execution stage 
        
    ForwardBD: OUT STD_LOGIC := '0';	 --mux1 select decode stage 
    ForwardAD: OUT STD_LOGIC := '0'	 ----mux2 select for decode stage   
    
);
end forward_unit;

--Begin Architecture
architecture forward_unit_Arch of forward_unit is
  
begin
    process(WriteRegW, WriteRegM, WriteRegE, RegWriteM, RegWriteW, RegWriteE, MemtoRegM, MemtoRegE, RsE, RtE, RsD, RtD, BranchD)
      begin
        --For Forwarding
        if ((RsE /= "0000") AND (RsE = WriteRegM) AND RegWriteM = '1') then
             ForwardAE <= "10";
        
        elsif ((RsE /= "0000") AND (RsE = WriteRegW) AND RegWriteW= '1') then
             ForwardAE <= "01";
        
        else ForwardAE <= "00";
    
        end if;
    
        if ((RtE /= "0000") AND (RtE = WriteRegM) AND RegWriteM= '1') then
             ForwardBE <= "10";
    
        elsif ((RtE /= "0000") AND (RtE = WriteRegW) AND RegWriteW= '1') then
             ForwardBE <= "01";
    
        else ForwardBE <= "00";

    end if;
    

    --Branch Hazard
    --Branch Forwarding
    if ((RsD /= "0000") AND (RsD = WriteRegM) AND RegWriteM = '1') then
      ForwardAD <= '1';
    
    else ForwardAD <= '0';
    end if;
    
    if ((RtD /= "0000") AND (RtD = WriteRegM) AND RegWriteM = '1') then
      ForwardBD <= '1';
    
    else ForwardBD <= '0';
    end if;
    
    
    end process;
    
end forward_unit_Arch;