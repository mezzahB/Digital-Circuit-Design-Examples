----------------------------------------------------------------------------------
-- Engineer: Ibrahim Mezzah
-- Create Date: 22.03.2016 22:23:36
-- Project Name: VHDL Labs
-- Module Name: Seven_seg_dec_8d - Design 2
-- Description: Seven segment decoder for 8 digits
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Seven_seg_dec_8d is
Port ( enable         : in  STD_LOGIC;
       Data_in        : in  STD_LOGIC_VECTOR (3 downto 0);
       DP_in          : in  STD_LOGIC;
       Digit_select   : in  STD_LOGIC_VECTOR (2 downto 0);
       AN_7_0         : out STD_LOGIC_VECTOR (7 downto 0);
       Seven_seg_data : out STD_LOGIC_VECTOR (0 to 6);
       DP             : out STD_LOGIC);
end Seven_seg_dec_8d;

architecture Behavioral of Seven_seg_dec_8d is

begin

    with Data_in SELect
                           Seven_seg_data<= "1111001" when "0001",   --1
                                 "0100100" when "0010",   --2
                                 "0110000" when "0011",   --3
                                 "0011001" when "0100",   --4
                                 "0010010" when "0101",   --5
                                 "0000010" when "0110",   --6
                                 "1111000" when "0111",   --7
                                 "0000000" when "1000",   --8
                                 "0010000" when "1001",   --9
                                 "0001000" when "1010",   --A
                                 "0000011" when "1011",   --b
                                 "1000110" when "1100",   --C
                                 "0100001" when "1101",   --d
                                 "0000110" when "1110",   --E
                                 "0001110" when "1111",   --F
                                 "1000000" when others;   --0
                                 
    AN_7_0(7) <= '0'    when Digit_select = "111" and enable = '1' else
                 '1';
    AN_7_0(6) <= '0'    when Digit_select = "110" and enable = '1' else
                 '1';
    AN_7_0(5) <= '0'    when Digit_select = "101" and enable = '1' else
                 '1';
    AN_7_0(4) <= '0'    when Digit_select = "100" and enable = '1' else
                 '1';
    AN_7_0(3) <= '0'    when Digit_select = "011" and enable = '1' else
                 '1';
    AN_7_0(2) <= '0'    when Digit_select = "010" and enable = '1' else
                 '1';
    AN_7_0(1) <= '0'    when Digit_select = "001" and enable = '1' else
                 '1';
    AN_7_0(0) <= '0'    when Digit_select = "000" and enable = '1' else
                 '1';
                 
    DP <= DP_in;


end Behavioral;
