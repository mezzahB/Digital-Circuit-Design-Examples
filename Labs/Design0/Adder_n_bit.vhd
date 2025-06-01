----------------------------------------------------------------------------------
-- Engineer: Ibrahim Mezzah
-- Create Date: 12.04.2016 11:32:44
-- Project Name: VHDL Labs
-- Module Name: Adder_n_bit - Design 0
-- Description: Generic adder
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder_n_bit is
 Generic ( operator_length : integer := 8);
    Port ( A : in STD_LOGIC_VECTOR (operator_length-1 downto 0);
           B : in STD_LOGIC_VECTOR (operator_length-1 downto 0);
           S : out STD_LOGIC_VECTOR (operator_length-1 downto 0);
           Carry_out : out STD_LOGIC);
end Adder_n_bit;

architecture Behavioral of Adder_n_bit is
    signal Carry_sig : STD_LOGIC_VECTOR (operator_length downto 0);
begin
Adder_nbit:
for i in 0 to operator_length-1 generate
Add_1bit : entity work.Adder_1bit
Port map( A => A(i),
          B => B(i),
          Carry_in => Carry_sig(i),
          S => S(i),
          Carry_out => Carry_sig(i+1));
end generate;

    Carry_sig(0) <= '0';
    Carry_out    <= Carry_sig(operator_length);

end Behavioral;


