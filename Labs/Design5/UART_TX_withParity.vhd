----------------------------------------------------------------------------------
-- Engineer: Ibrahim Mezzah
-- Create Date: 19.04.2016 09:39:40
-- Project Name: VHDL Labs
-- Module Name: UART_TX_withParity - Design 5
-- Description: UART transmission module with parity
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity UART_TX_withParity is                                   --110 baud          --> UART_Baud = 909090
Generic ( UART_Baud : integer := 10416);                       --300 baud          --> UART_Baud = 333332
    Port ( nreset       : in STD_LOGIC;                        --1 200 baud        --> UART_Baud = 83332 
           clock_100MHz : in STD_LOGIC;                        --2 400 baud        --> UART_Baud = 41666 
           enable       : in STD_LOGIC;                        --4 800 baud        --> UART_Baud = 20832 
           Data         : in STD_LOGIC_VECTOR (7 downto 0);    --9 600 baud        --> UART_Baud = 10416 
           parity_en    : in STD_LOGIC;                        --19 200 baud       --> UART_Baud = 5207   
           parity_type  : in STD_LOGIC;                        --38 400 baud       --> UART_Baud = 2603   
           TX           : out STD_LOGIC;                       --57 600 baud       --> UART_Baud = 1735   
           TX_interrupt : out STD_LOGIC);                      --115 200 baud      --> UART_Baud = 867    
end UART_TX_withParity;                                        --230 400 baud      --> UART_Baud = 433    
                                                               --460 800 baud      --> UART_Baud = 216    
         -- parity_type = '0' => even parity                   --921 600 baud      --> UART_Baud = 108    
         -- parity_type = '1' => odd parity                    --1 843 200 baud    --> UART_Baud = 53     
                                                               --3 686 400 baud    --> UART_Baud = 26     
                                                               
                                                               

architecture Behavioral of UART_TX_withParity is

    type UART_state_type is (Idel_st, Start_st, D0_st, D1_st, D2_st, D3_st,
                             D4_st, D5_st, D6_st, D7_st, Stop_st, Parity_st);
    signal UART_state : UART_state_type;

    signal clock_counter : integer range 0 to UART_Baud;
    
    signal shift_register : STD_LOGIC_VECTOR (9 downto 0);
    signal load_shift_reg : STD_LOGIC;
    signal shift_sig      : STD_LOGIC;

    signal TX_interrupt_sig : STD_LOGIC;
    
    signal parity_bit : STD_LOGIC;

begin

parity_process:
process(Data)
    variable parity_tmp : STD_LOGIC;
begin
    parity_tmp := '0';
    for i in 0 to 7 loop
        parity_tmp := parity_tmp xor Data(i);
    end loop;
    
    parity_bit <= parity_tmp;
    
end process;


clock_counter_process:
process(nreset, clock_100MHz, UART_state, shift_sig)
begin
    if nreset = '0' then
            clock_counter <= 0;
    elsif clock_100MHz'event and clock_100MHz = '1' then
        if UART_state = Idel_st or shift_sig = '1' then
            clock_counter <= 0;
        else
            clock_counter <= clock_counter + 1;
        end if;
    end if;
end process;

UART_TX_FSM_process:
process(nreset, clock_100MHz, enable, shift_sig, clock_counter)
begin
    if nreset = '0' then
                UART_state <= Idel_st;
    elsif clock_100MHz'event and clock_100MHz = '1' then
        case UART_state is

        when Idel_st =>
            if enable = '1' then
                UART_state <= Start_st;
            else
                UART_state <= UART_state;
            end if;
            
        when Start_st =>
            if shift_sig = '1' then
                UART_state <= D0_st;
            else
                UART_state <= UART_state;
            end if;
                
        when D0_st =>
            if shift_sig = '1' then
                UART_state <= D1_st;
            else
                UART_state <= UART_state;
            end if;

        when D1_st =>
            if shift_sig = '1' then
                UART_state <= D2_st;
            else
                UART_state <= UART_state;
            end if;

        when D2_st =>
            if shift_sig = '1' then
                UART_state <= D3_st;
            else
                UART_state <= UART_state;
            end if;

        when D3_st =>
            if shift_sig = '1' then
                UART_state <= D4_st;
            else
                UART_state <= UART_state;
            end if;

        when D4_st =>
            if shift_sig = '1' then
                UART_state <= D5_st;
            else
                UART_state <= UART_state;
            end if;

        when D5_st =>
            if shift_sig = '1' then
                UART_state <= D6_st;
            else
                UART_state <= UART_state;
            end if;

        when D6_st =>
            if shift_sig = '1' then
                UART_state <= D7_st;
            else
                UART_state <= UART_state;
            end if;

        when D7_st =>
            if shift_sig = '1' then
                if parity_en = '1' then
                    UART_state <= Parity_st;
                else
                    UART_state <= Stop_st;
                end if;
            else
                UART_state <= UART_state;
            end if;

        when Parity_st =>
            if shift_sig = '1' then
                UART_state <= Stop_st;
            else
                UART_state <= UART_state;
            end if;

        when others => -- Stop_st
            if clock_counter =  UART_Baud then
                if enable = '1' then
                    UART_state <= Start_st;
                else
                    UART_state <= Idel_st;
                end if;
            else
                UART_state <= UART_state;
            end if;
        end case;
    end if;
end process;

shift_register_process:
process(nreset, clock_100MHz, load_shift_reg, shift_sig)
begin
    if nreset = '0' then
            shift_register <= (others => '1');
    elsif clock_100MHz'event and clock_100MHz = '1' then
        if load_shift_reg = '1' then
            if parity_en = '1' then
                shift_register <= parity_bit & Data & '0';
            else
                shift_register <= '1' & Data & '0';
            end if;
        elsif shift_sig = '1' then
            shift_register <= '1' & shift_register(9 downto 1);
        else
            shift_register <= shift_register;
        end if;
    end if;
end process;

    load_shift_reg <= '1' when (UART_state = Idel_st and enable = '1') or
                               (UART_state = Stop_st and clock_counter =  UART_Baud and enable = '1') else
                      '0';
                      
    shift_sig      <= '1' when clock_counter =  UART_Baud else
                      '0';

interrupt_process:
process(nreset, clock_100MHz, load_shift_reg, shift_sig)
begin
    if nreset = '0' then
            TX_interrupt_sig <= '0';
    elsif clock_100MHz'event and clock_100MHz = '1' then
        if load_shift_reg = '1' then
            TX_interrupt_sig <= '1';
        elsif shift_sig = '1' then
            TX_interrupt_sig <= '0';
        else
            TX_interrupt_sig <= TX_interrupt_sig;
        end if;
    end if;
end process;

    TX <= shift_register(0);
    TX_interrupt <= TX_interrupt_sig;

end Behavioral;
