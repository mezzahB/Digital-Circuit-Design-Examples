----------------------------------------------------------------------------------
-- Engineer: Ibrahim Mezzah
-- Create Date: 16.03.2016 14:39:26
-- Project Name: VHDL Labs
-- Design Name: Seven segment display (One digit) - Design 1
-- Module Name: Seven_seg_dec
-- Description: Seven segment decoder
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity Seven_seg_dec is
    Port ( enable         : in  STD_LOGIC;
           Data_in        : in  STD_LOGIC_VECTOR (3 downto 0);
           AN0            : out STD_LOGIC;
           Seven_seg_data : out STD_LOGIC_VECTOR (0 to 6);
           DP             : out STD_LOGIC);
end Seven_seg_dec;

architecture Behavioral of Seven_seg_dec is
--    signal Seven_seg_data_sig : STD_LOGIC_VECTOR (6 downto 0);
begin

    AN0 <= not enable;
    DP <= '1';
--    Seven_seg_data <= Seven_seg_data_sig xor "1111111";
    
    -- using "with select"
--    with Data_in select
--      Seven_seg_data_sig <= "1111110" when "0000",
--                            "0110000" when "0001",
--                            "1101101" when "0010",
--                            "1111001" when "0011",
--                            "0110011" when "0100",
--                            "1011011" when "0101",
--                            "1011111" when "0110",
--                            "1110000" when "0111",
--                            "1111111" when "1000",
--                            "1111011" when "1001",
--                            "1110111" when "1010",
--                            "0011111" when "1011",
--                            "1001110" when "1100",
--                            "0111101" when "1101",
--                            "1001111" when "1110",
--                            "1000111" when others;

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

--    -- using "when"
--    Seven_seg_data_sig <= "1111110" when Data_in = "0000" else
--                          "0110000" when Data_in = "0001" else
--                          "1101101" when Data_in = "0010" else
--                          "1111001" when Data_in = "0011" else
--                          "0110011" when Data_in = "0100" else
--                          "1011011" when Data_in = "0101" else
--                          "1011111" when Data_in = "0110" else
--                          "1110000" when Data_in = "0111" else
--                          "1111111" when Data_in = "1000" else
--                          "1111011" when Data_in = "1001" else
--                          "1110111" when Data_in = "1010" else
--                          "0011111" when Data_in = "1011" else
--                          "1001110" when Data_in = "1100" else
--                          "0111101" when Data_in = "1101" else
--                          "1001111" when Data_in = "1110" else
--                          "1000111";

----    other possibility to use "when"
--    Seven_seg_data_sig(6) <= '0' when Data_in = "0001" or
--                                      Data_in = "0100" or
--                                      Data_in = "1011" or
--                                      Data_in = "1101" else
--                         '1';
--    Seven_seg_data_sig(5) <= '0' when Data_in = "0101" or
--                                      Data_in = "0110" or
--                                      Data_in = "1011" or
--                                      Data_in = "1100" or
--                                      Data_in = "1110" or
--                                      Data_in = "1111" else
--                         '1';
--                    .
--                    .
--                    .
--                    .
--                    .
                    

end Behavioral;