
library IEEE;

use IEEE.std_logic_1164.all;

package CONV_PACK_MUX21_GENERIC is

-- define attributes
attribute ENUM_ENCODING : STRING;

end CONV_PACK_MUX21_GENERIC;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_MUX21_GENERIC.all;

entity MUX21_GENERIC is

   port( A, B : in std_logic_vector (3 downto 0);  SEL : in std_logic;  Y : out
         std_logic_vector (3 downto 0));

end MUX21_GENERIC;

architecture SYN_BEHAVIORAL_5 of MUX21_GENERIC is

   component MUX2_X1
      port( A, B, S : in std_logic;  Z : out std_logic);
   end component;

begin
   
   U10 : MUX2_X1 port map( A => B(3), B => A(3), S => SEL, Z => Y(3));
   U11 : MUX2_X1 port map( A => B(2), B => A(2), S => SEL, Z => Y(2));
   U12 : MUX2_X1 port map( A => B(1), B => A(1), S => SEL, Z => Y(1));
   U13 : MUX2_X1 port map( A => B(0), B => A(0), S => SEL, Z => Y(0));

end SYN_BEHAVIORAL_5;
