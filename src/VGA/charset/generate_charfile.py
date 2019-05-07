
import math
from charset_decoder import *

BASE_TEMPLATE = """library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package CHARS is
  
  constant NUMBER_OF_CHARS : INTEGER := {0};
  constant CHAR_SIZE       : INTEGER := {1};
  constant CHAR_BIT_SIZE   : INTEGER := {2};
  
  type char_array is array (0 to NUMBER_OF_CHARS - 1) of UNSIGNED (CHAR_SIZE * CHAR_SIZE - 1 downto 0);
  
  -- ======== Chars ========
  
  constant CHARS : char_array := (
{3}
);
  
  -- ======== Alias ========
  -- Indexes
{4}
  -- Chars
{5}
end CHARS;"""

ALIAS_TEMPLATE = "constant {0}: INTEGER := {1};"
ALIAS_CHAR_TEMPLATE = "alias {0}_char: UNSIGNED (CHAR_SIZE * CHAR_SIZE - 1 downto 0) is CHARS({1});"

FILENAME = "charset"

ASCII_NAMES = ["NULL_CHAR",
               "SOH",
               "STX",
               "ETX",
               "EOT",
               "ENQ",
               "ACK",
               "BEL",
               "BS",
               "HT",
               "LF",
               "VT",
               "FF",
               "CR",
               "SO",
               "SI",
               "DLE",
               "DC1",
               "DC2",
               "DC3",
               "DC4",
               "NAK",
               "SYN",
               "ETB",
               "CAN",
               "EM",
               "SUB",
               "ESC",
               "FS",
               "GS",
               "RS",
               "US",
               "SPACE",
               "EXCLAMATION_MARK",
               "DOUBLE_QUOTE",
               "HASH",
               "DOLLAR",
               "PERCENT",
               "AMPERSAND",
               "SINGLE_QUOTE",
               "LEFT_PARENTHESES",
               "RIGHT_PARENTHESES",
               "STAR",
               "PLUS",
               "COMMA",
               "DASH",
               "PERIOD",
               "SLASH",
               "ZERO",
               "ONE",
               "TWO",
               "THREE",
               "FOUR",
               "Five",
               "SIX",
               "SEVEN",
               "EIGHT",
               "NINE",
               "COLON",
               "SEMICOLON",
               "LESS_THAN",
               "EQUAL",
               "GREATER_THAN",
               "QUESTION_MARK",
               "AT",
               "A",
               "B",
               "C",
               "D",
               "E",
               "F",
               "G",
               "H",
               "I",
               "J",
               "K",
               "L",
               "M",
               "N",
               "O",
               "P",
               "Q",
               "R",
               "S",
               "T",
               "U",
               "V",
               "W",
               "X",
               "Y",
               "Z",
               "LEFT_BRACKET",
               "BACK_SLASH",
               "RIGHT_BRACKET",
               "HAT",
               "UNDERSCORE",
               "LEFT_TICK",
               "a_low",
               "b_low",
               "c_low",
               "d_low",
               "e_low",
               "f_low",
               "g_low",
               "h_low",
               "i_low",
               "j_low",
               "k_low",
               "l_low",
               "m_low",
               "n_low",
               "o_low",
               "p_low",
               "q_low",
               "r_low",
               "s_low",
               "t_low",
               "u_low",
               "v_low",
               "w_low",
               "x_low",
               "y_low",
               "z_low",
               "CURLY_LEFT",
               "PIPE",
               "CURLY_RIGHT",
               "SWUNG_DASH",
               "DEL"]
               
               
if __name__ == "__main__":
  with open(FILENAME + ".bitmap") as f:
    text = f.read()
  
  width, size = constants(text, FILENAME)
  clean = strip(text)
  chars = charify(clean, width, size)
  
  # ======== Array ========
  array_string = ""
  char_strings = []
  for index, char in enumerate(chars):
    rows = ["\"" + char[i:i + size] + "\"" for i in range(0, len(char), size)]
    
    char_string = " &\n".join(rows)
    char_strings.append("\n-- " + ASCII_NAMES[index] + "\n" + char_string)
  
  array_string = ",\n".join(char_strings)
  
  # ======== Alias ========
  alias_string = ""
  for index, char in enumerate(chars):
    alias_string += "  " + ALIAS_TEMPLATE.format(ASCII_NAMES[index], index) + "\n"
    
  # ====== Alias chars ======
  alias_char_string = ""
  for index, char in enumerate(chars):
    alias_char_string += "  " + ALIAS_CHAR_TEMPLATE.format(ASCII_NAMES[index], index) + "\n"
  
  # ======== Output ========
  file_string = BASE_TEMPLATE.format(len(chars), size, int(math.log(size, 2)), array_string, alias_string, alias_char_string)
  
  with open("Chars.vhd", "w+") as f:
    f.write(file_string)
  
  
