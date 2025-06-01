----------------------------------------------------------------------------------
-- Engineer: Ibrahim Mezzah
-- Create Date: 23.03.2016 08:09:24
-- Project Name: VHDL Labs
-- Module Name: tb_Seven_seg_date_display
-- Description: Testbench of Seven_seg_date_display
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_Seven_seg_date_display is
end tb_Seven_seg_date_display;

architecture Behavioral of tb_Seven_seg_date_display is

    signal enable         : STD_LOGIC := '0';
    signal clock_100MHz   : STD_LOGIC := '1';
           
    signal AN_7_0         : STD_LOGIC_VECTOR (7 downto 0);
    signal Seven_seg_data : STD_LOGIC_VECTOR (0 to 6);
    signal DP             : STD_LOGIC;

begin

uut: entity work.Seven_seg_date_disp 
Port map ( enable         => enable,
           clock_100MHz   => clock_100MHz,
           AN_7_0         => AN_7_0,
           Seven_seg_data => Seven_seg_data,
           DP             => DP);
           
clock_process: process
begin
    wait for 5 ns;
    clock_100MHz <= '0';
    wait for 5 ns;
    clock_100MHz <= '1';
end process;
           
stimulus_pros: process
begin
    wait for 100 ns;
    enable <= '1';
    
    wait for 1000 ms;
    enable <= '0';
    
    wait;
end process;



end Behavioral;
