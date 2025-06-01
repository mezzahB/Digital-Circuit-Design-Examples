----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2016 11:22:17
-- Design Name: 
-- Module Name: tb_UART_TX_withParity - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
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

entity tb_UART_TX_withParity is
--  Port ( );
end tb_UART_TX_withParity;

architecture Behavioral of tb_UART_TX_withParity is
    signal nreset       : STD_LOGIC := '0';                    
signal clock_100MHz : STD_LOGIC := '0';                    
signal enable       : STD_LOGIC := '0';                    
signal Data         : STD_LOGIC_VECTOR (7 downto 0) := X"3A";
signal parity_en    : STD_LOGIC := '0';
signal parity_type  : STD_LOGIC := '0';

signal TX           : STD_LOGIC;                   
signal TX_interrupt : STD_LOGIC;                  
                                         

begin

uut : entity work.UART_TX_withParity                                         
Generic map(10416)
Port map( nreset,                   
       clock_100MHz,
       enable,
       Data,
       parity_en,
       parity_type,
       TX,
       TX_interrupt);                  
                                         

clock_process: process
begin
wait for 5 ns;
clock_100MHz <= '0';
wait for 5 ns;
clock_100MHz <= '1';
end process;

stimulus_pros: process
begin
wait for 5 ns;
wait for 100 us;
nreset <= '1';

wait for 1000 us;
enable <= '1';

wait for 100 us;
enable <= '0';

wait for 1500 us;
Data <= X"25";
wait for 100 us;
enable <= '1';

wait for 100 us;
Data <= X"F4";
wait for 1500 us;
enable <= '0';


wait for 2000 us;
Data <= X"F4";
parity_en <= '1';   -- enable parity bit
parity_type <= '0'; -- even parity
wait for 100 us;
enable <= '1';

wait for 100 us;
enable <= '0';

wait for 1500 us;
Data <= X"38";
parity_en <= '1';   -- enable parity bit
parity_type <= '1'; -- odd parity
wait for 100 us;
enable <= '1';

wait for 100 us;
enable <= '0';


wait;
end process;



end Behavioral;
