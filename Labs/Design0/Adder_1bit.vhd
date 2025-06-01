----------------------------------------------------------------------------------
-- Engineer: Ibrahim Mezzah
-- Create Date: 06.04.2016 13:59:06
-- Project Name: VHDL Labs
-- Module Name: Adder_1bit - Design 0
-- Description: Adder 1 bit
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder_1bit is
    Port ( A        : in STD_LOGIC;
           B        : in STD_LOGIC;
           Carry_in : in STD_LOGIC;
           S        : out STD_LOGIC;
           Carry_out : out STD_LOGIC);
end Adder_1bit;

architecture Data_flow of Adder_1bit is

    signal sig : std_logic_vector (2 downto 0);
begin

    sig <= A & B & Carry_in;
    
    with sig select
        Carry_out <= '1' when "110"|"011"|"101"|"111",
                     '0' when others;
    
    S <= A xor B xor Carry_in;
    
--    with sig select
--        S <= '1' when "100"|"010"|"001"|"111",
--                     '0' when others;
                     
end Data_flow;
