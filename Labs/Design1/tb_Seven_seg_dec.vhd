----------------------------------------------------------------------------------
-- Engineer: Ibrahim Mezzah
-- Create Date: 16.03.2016 15:24:17
-- Project Name: VHDL Labs
-- Design Name: Seven segment display (One digit)
-- Module Name: tb_Seven_seg_dec
-- Description: Seven_seg_dec testbench
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity tb_Seven_seg_dec is
end tb_Seven_seg_dec;

architecture Behavioral of tb_Seven_seg_dec is

component Seven_seg_dec is
    Port ( enable         : in  STD_LOGIC;
           Data_in        : in  STD_LOGIC_VECTOR (3 downto 0);
           AN0            : out STD_LOGIC;
           Seven_seg_data : out STD_LOGIC_VECTOR (6 downto 0);
           DP             : out STD_LOGIC);
end component;

-- signals for input ports
signal enable : STD_LOGIC := '0';
signal Data   : STD_LOGIC_VECTOR (3 downto 0) := "0000";

-- signals for output ports
signal Seven_seg_data : STD_LOGIC_VECTOR (6 downto 0);
signal DP     : STD_LOGIC;
signal AN0    : STD_LOGIC;

begin

uut1: Seven_seg_dec
Port map( enable         => enable,
          Data_in        => Data,
          Seven_seg_data => Seven_seg_data,
          DP             => DP,
          AN0            => AN0);

stimulus: process
begin

wait for 200 ns;
enable <= '1';

wait for 200 ns;
Data <= "0001";
wait for 200 ns;
Data <= "0010";
wait for 200 ns;
Data <= "0011";

wait for 200 ns;
Data <= "0100";
wait for 200 ns;
Data <= "0101";
wait for 200 ns;
Data <= "0110";
wait for 200 ns;
Data <= "0111";

wait for 200 ns;
Data <= "1000";
wait for 200 ns;
Data <= "1001";
wait for 200 ns;
Data <= "1010";
wait for 200 ns;
Data <= "1011";

wait for 200 ns;
Data <= "1100";
wait for 200 ns;
Data <= "1101";
wait for 200 ns;
Data <= "1110";
wait for 200 ns;
Data <= "1111";

wait;
end process;

end Behavioral;
