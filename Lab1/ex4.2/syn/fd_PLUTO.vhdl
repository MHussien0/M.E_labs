
library IEEE;

use IEEE.std_logic_1164.all;

package CONV_PACK_FD_1 is

-- define attributes
attribute ENUM_ENCODING : STRING;

end CONV_PACK_FD_1;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_FD_1.all;

entity FD_1 is

   port( D : in std_logic_vector (0 downto 0);  CK, RESET : in std_logic;  Q : 
         out std_logic_vector (0 downto 0));

end FD_1;

architecture SYN_PLUTO of FD_1 is

   component INV_X1
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component DFFR_X1
      port( D, CK, RN : in std_logic;  Q, QN : out std_logic);
   end component;
   
   signal n1, n_1000 : std_logic;

begin
   
   Q_reg_0_inst : DFFR_X1 port map( D => D(0), CK => CK, RN => n1, Q => Q(0), 
                           QN => n_1000);
   U4 : INV_X1 port map( A => RESET, ZN => n1);

end SYN_PLUTO;
