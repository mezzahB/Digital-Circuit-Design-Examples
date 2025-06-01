----------------------------------------------------------------------------------
-- Engineer: Ibrahim Mezzah
-- Create Date: 06.04.2016 14:17:16
-- Project Name: VHDL Labs
-- Module Name: tb_Adder_1bit - Behavioral
-- Description: Adder_1bit testbench
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_Adder_1bit is
--  Port ( );
end tb_Adder_1bit;

architecture Behavioral of tb_Adder_1bit is

component Adder_1bit is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Carry_in : in STD_LOGIC;
           S : out STD_LOGIC;
           Carry_out : out STD_LOGIC);
end component;

    signal A1 : STD_LOGIC := '0';
    signal B : STD_LOGIC := '0';
    signal Carry_in : STD_LOGIC := '0';
    
    signal S : STD_LOGIC;
    signal Carry_out : STD_LOGIC;

 signal sig : std_logic_vector (2 downto 0) := "000";
begin

uut1 : Adder_1bit
Port map ( A => A1,
           B => B,
           Carry_in => Carry_in,
           S => S,
           Carry_out => Carry_out);

--sig <= A1 & B & Carry_in;
    A1 <= sig(2);
    B <= sig(1);
    Carry_in <= sig(0);

process
begin

wait for 100 ns;
sig <= sig + "1";

end process;




end Behavioral;
