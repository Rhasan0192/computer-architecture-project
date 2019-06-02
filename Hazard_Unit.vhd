
--Hazard Unit for Data, Load & Control Hazards

--Library Declaration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

--Begin Entity
entity hazard_unit is
port
(
    --Clock : in std_logic := '0';
    WriteRegW, WriteRegM, WriteRegE: IN STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
    RegWriteM, RegWriteW, RegWriteE : IN STD_LOGIC := '0';
    MemtoRegM, MemtoRegE : IN STD_LOGIC := '0';
    
    RsE, RtE: IN STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
    RsD, RtD: IN STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
    BranchD: IN STD_LOGIC := '0';

    Stall_ID: OUT STD_LOGIC := '1'; 
    Stall_IF: OUT STD_LOGIC := '1'; 
    FlushE: OUT STD_LOGIC := '0';
      
    ForwardAE: OUT STD_LOGIC_VECTOR (1 downto 0) := (others=>'0');	 --mux1 selectexecution stage
    ForwardBE: OUT STD_LOGIC_VECTOR (1 downto 0) := (others=>'0');	 ----mux2 select execution stage 
        
    ForwardBD: OUT STD_LOGIC := '0';	 --mux1 select decode stage 
    ForwardAD: OUT STD_LOGIC := '0'	 ----mux2 select for decode stage   
    
);
end hazard_unit;

--Begin Architecture
architecture hazard_unit_Arch of hazard_unit is

component stall_unit
port
(
    
    WriteRegW, WriteRegM, WriteRegE: IN STD_LOGIC_VECTOR (3 downto 0);
    RegWriteM, RegWriteW, RegWriteE : IN STD_LOGIC;
    MemtoRegM, MemtoRegE : IN STD_LOGIC;
    
    RsE, RtE: IN STD_LOGIC_VECTOR (3 downto 0);
    RsD, RtD: IN STD_LOGIC_VECTOR (3 downto 0);
    BranchD: IN STD_LOGIC;

    Stall_ID: OUT STD_LOGIC; 
    Stall_IF: OUT STD_LOGIC; 
    FlushE: OUT STD_LOGIC
    
);
end component;

component forward_unit
port
(
    
    WriteRegW, WriteRegM, WriteRegE: IN STD_LOGIC_VECTOR (3 downto 0);
    RegWriteM, RegWriteW, RegWriteE : IN STD_LOGIC;
    MemtoRegM, MemtoRegE : IN STD_LOGIC;
    
    RsE, RtE: IN STD_LOGIC_VECTOR (3 downto 0);
    RsD, RtD: IN STD_LOGIC_VECTOR (3 downto 0);
    BranchD: IN STD_LOGIC;

      
    ForwardAE: OUT STD_LOGIC_VECTOR (1 downto 0);	 --mux1 selectexecution stage
    ForwardBE: OUT STD_LOGIC_VECTOR (1 downto 0);	 ----mux2 select execution stage 
        
    ForwardBD: OUT STD_LOGIC;	 --mux1 select decode stage 
    ForwardAD: OUT STD_LOGIC	 ----mux2 select for decode stage   
    
);
end component;    
      
begin
  
  SU: stall_unit port map(WriteRegW, WriteRegM, WriteRegE, RegWriteM, RegWriteW, RegWriteE, MemtoRegM, MemtoRegE, RsE, RtE, RsD, RtD, BranchD, Stall_ID, Stall_IF, FlushE);
  FU: forward_unit port map(WriteRegW, WriteRegM, WriteRegE, RegWriteM, RegWriteW, RegWriteE, MemtoRegM, MemtoRegE, RsE, RtE, RsD, RtD, BranchD, ForwardAE, ForwardBE, ForwardBD, ForwardAD);
  
end hazard_unit_Arch;