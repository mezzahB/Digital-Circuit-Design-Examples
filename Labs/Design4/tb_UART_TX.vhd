----------------------------------------------------------------------------------
-- Engineer: Ibrahim Mezzah
-- Create Date: 11.04.2016 23:16:46
-- Project Name: VHDL Labs
-- Module Name: tb_UART_TX
-- Description: UART_TX testbench
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

entity tb_UART_TX is
--  Port ( );
end tb_UART_TX;

architecture Behavioral of tb_UART_TX is

                
    signal nreset       : STD_LOGIC := '0';                    
    signal clock_100MHz : STD_LOGIC := '0';                    
    signal enable       : STD_LOGIC := '0';                    
    signal Data         : STD_LOGIC_VECTOR (7 downto 0) := X"3A";
    signal TX           : STD_LOGIC;                   
    signal TX_interrupt : STD_LOGIC;                  
                                             

begin

uut : entity work.UART_TX                                         
Generic map(10416)
   Port map( nreset,                   
           clock_100MHz,
           enable,
           Data,
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
    wait for 105 ns;
    nreset <= '1';
    
    wait for 210 us;
    enable <= '1';

    wait for 10 us;
    enable <= '0';

    wait for 3 ms;
    enable <= '1';


    wait;
end process;



end Behavioral;
