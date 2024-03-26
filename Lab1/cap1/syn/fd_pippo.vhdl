
library IEEE;

use IEEE.std_logic_1164.all;

package CONV_PACK_FD is

-- define attributes
attribute ENUM_ENCODING : STRING;

end CONV_PACK_FD;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_FD.all;

entity FD is

   port( D : in std_logic_vector (0 downto 0);  CK, RESET : in std_logic;  Q : 
         out std_logic_vector (0 downto 0));

end FD;

architecture SYN_PIPPO of FD is

   component INV_X1
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component DFF_X1
      port( D, CK : in std_logic;  Q, QN : out std_logic);
   end component;
   
   signal N3, n2, n_1000 : std_logic;

begin
   
   Q_reg_0_inst : DFF_X1 port map( D => N3, CK => CK, Q => Q(0), QN => n_1000);
   U5 : NOR2_X1 port map( A1 => RESET, A2 => n2, ZN => N3);
   U6 : INV_X1 port map( A => D(0), ZN => n2);

end SYN_PIPPO;
