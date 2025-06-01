----------------------------------------------------------------------------------
-- Engineer: Ibrahim Mezzah
-- Create Date: 23.03.2016 07:25:56
-- Project Name: VHDL Labs
-- Module Name: Seven_seg_date_disp - Design 3
-- Description: Seven segment decoder for 8 digits, displaying a date as an example
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.NUMERIC_STD.ALL;


entity Seven_seg_date_disp is
    Port ( enable         : in STD_LOGIC;
           clock_100MHz   : in STD_LOGIC;
           AN_7_0         : out STD_LOGIC_VECTOR (7 downto 0);
           Seven_seg_data : out STD_LOGIC_VECTOR (0 to 6);
           DP             : out STD_LOGIC);
end Seven_seg_date_disp;

architecture Behavioral of Seven_seg_date_disp is

    signal Clock_counter : STD_LOGIC_VECTOR (16 downto 0);
    signal Digit_counter : STD_LOGIC_VECTOR (2 downto 0);
    signal Data_in       : STD_LOGIC_VECTOR (3 downto 0);
    signal DP_in         : STD_LOGIC;
    alias  Digit_select  : STD_LOGIC_VECTOR (2 downto 0) is Digit_counter;
    
    constant Day_1       : STD_LOGIC_VECTOR (3 downto 0) := X"1";
    constant Day_0       : STD_LOGIC_VECTOR (3 downto 0) := x"6";
    constant Month_1     : STD_LOGIC_VECTOR (3 downto 0) := X"0";
    constant Month_0     : STD_LOGIC_VECTOR (3 downto 0) := X"3";
    constant Year_3      : STD_LOGIC_VECTOR (3 downto 0) := X"2";
    constant Year_2      : STD_LOGIC_VECTOR (3 downto 0) := X"0";
    constant Year_1      : STD_LOGIC_VECTOR (3 downto 0) := X"1";
    constant Year_0      : STD_LOGIC_VECTOR (3 downto 0) := X"6";
    
component Seven_seg_dec_8d is
    Port ( enable         : in  STD_LOGIC;
           Data_in        : in  STD_LOGIC_VECTOR (3 downto 0);
           Digit_select   : in  STD_LOGIC_VECTOR (2 downto 0);
           DP_in          : in  STD_LOGIC;
           AN_7_0         : out STD_LOGIC_VECTOR (7 downto 0);
           Seven_seg_data : out STD_LOGIC_VECTOR (0 to 6);
           DP             : out STD_LOGIC);
    end component;
begin

Seven_seg_dec: Seven_seg_dec_8d
Port map( enable      => enable,
       Data_in        => Data_in,
       Digit_select   => Digit_select,
       DP_in          => DP_in,
       AN_7_0         => AN_7_0,
       Seven_seg_data => Seven_seg_data,
       DP             => DP);

clock_divider_process: process(enable, clock_100MHz)
begin
    if enable = '0' then
        Clock_counter <= (others => '0');
    elsif clock_100MHz'event and clock_100MHz = '1' then
        Clock_counter <= Clock_counter + "1";
    end if;
end process;

digit_counter_process: process(enable, Clock_counter(16))
begin
    if enable = '0' then
        Digit_counter <= (others => '0');
    elsif Clock_counter(16)'event and Clock_counter(16) = '1' then
        Digit_counter <= Digit_counter - "1";
    end if;
end process;

with Digit_select select
    Data_in <= Day_1    when "111",
               Day_0    when "110",
               Month_1  when "101",
               Month_0  when "100",
               Year_3   when "011",
               Year_2   when "010",
               Year_1   when "001",
               Year_0   when others;

    DP_in <= '0'  when Digit_select = "110" or Digit_select = "100" else
             '1';
          
end Behavioral;
