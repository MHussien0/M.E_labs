library IEEE;
use IEEE.std_logic_1164.all; --  libreria IEEE con definizione tipi standard logic
use WORK.constants.all; -- libreria WORK user-defined
use ieee.std_logic_unsigned.all;

entity ACC IS
    Generic (NBIT: integer:= 64);
    port (
      A          : in  std_logic_vector(NBIT - 1 downto 0);
      B          : in  std_logic_vector(NBIT - 1 downto 0);
      CLK        : in  std_logic;
      RST_n      : in  std_logic;
      ACCUMULATE : in  std_logic;
      --- ACC_EN_n   : in  std_logic;  -- optional use of the enable
      Y          : out std_logic_vector(NBIT - 1 downto 0));
  end ACC;

architecture STRUCTURAL of ACC is
   signal SB_ADD_IN: std_logic_vector(NBIT - 1 downto 0);
   signal OUT_ADD: std_logic_vector(NBIT - 1 downto 0);
   signal FEEDBACK_ACC: std_logic_vector(NBIT - 1 downto 0);
   
   
     
   component MUX21_GENERIC IS
      Generic (NBIT: integer:= NBIT;
	       DELAY_MUX: Time:= tp_mux);
      Port (  A:	In	std_logic_vector(NBIT-1 downto 0) ;
	      B:	In	std_logic_vector(NBIT-1 downto 0);
	      SEL:	In	std_logic;
	      Y:	Out	std_logic_vector(NBIT-1 downto 0));
      end component;

   component RCA is 
      generic (NBIT:          integer:= NBIT;
               DRCAS : 	Time := 0 ns;
	       DRCAC : 	Time := 0 ns);
      Port (  A:	In	std_logic_vector(NBIT downto 0);
	      B:	In	std_logic_vector(NBIT downto 0);
	      Ci:	In	std_logic;
	      S:	Out	std_logic_vector(NBIT downto 0);
	      Co:	Out	std_logic);
   end component;

   component FD is
      generic (N: integer := NBIT);
      Port (  D:	In	std_logic_vector(NBIT-1 downto 0);
	      CK:	In	std_logic;
	      RESET:	In	std_logic;
	      Q:	Out	std_logic_vector(NBIT-1 downto 0));
   end component;

   begin

     UMUX21_GEN_1 : MUX21_GENERIC
       generic map (NBIT => NBIT)
       port map (A => B, B => FEEDBACK_ACC ,SEL => ACCUMULATE, Y => SB_ADD_IN);

     URCA_GEN_1 : RCA
       generic map (NBIT => NBIT)
       port map (A => A , B=> SB_ADD_IN, Ci => '0', S => OUT_ADD);

     UFD_GEN_1 : FD
       generic map (N => NBIT)
       port map ( D => OUT_ADD, CK => CLK , RESET => RST_n, Q => FEEDBACK_ACC);

   end STRUCTURAL;

   
architecture BEHAVIORAL of ACC is
   signal NXT_STATE : std_logic_vector(NBIT - 1 downto 0);
   signal Feedback_Y : std_logic_vector(NBIT - 1 downto 0);

   begin
    State_Reg: process (CLK ,RST_n)
     begin
       if(RST_n = '1')then
         Feedback_Y <= (others => '0');
       elsif (rising_edge(CLK))THEN
         Feedback_Y <= NXT_STATE;
       end if;
    end process;

    CombLogic: process (A, B, ACCUMULATE, Feedback_Y)
      begin
        if ( ACCUMULATE = '1') then
          NXT_STATE <= A + Feedback_Y;
        else
          NXT_STATE <= A + B;

        end if;

        end process;
	
	Y <= Feedback_Y;

end BEHAVIORAL;

configuration CFG_ACC_STRUCTURAL of ACC is
    for STRUCTURAL 
        for all : MUX21_GENERIC
            use configuration WORK.CFG_MUX21_GEN_BEHAVIORAL;
        end for;

        for all : RCA
            use configuration WORK.CFG_RCA_BEHAVIORAL; 
        end for;

        for all : FD
            use configuration WORK.CFG_FD_PLUTO; 
        end for;
    end for;
end CFG_ACC_STRUCTURAL;
        
         
configuration CFG_ACC_BEHAVIORAL of ACC is
  for BEHAVIORAL 
  end for;
end CFG_ACC_BEHAVIORAL;    

     
   
