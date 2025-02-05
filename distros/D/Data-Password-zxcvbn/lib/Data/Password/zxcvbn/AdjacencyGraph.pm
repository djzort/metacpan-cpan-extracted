package Data::Password::zxcvbn::AdjacencyGraph;
use strict;
use warnings;
our $VERSION = '1.0.6';

=head1 NAME

Data::Password::zxcvbn::AdjacencyGraph - adjacency graphs for common keyboards

=head1 DESCRIPTION

This is a data file used by L<<
C<Data::Password::zxcvbn::Match::Spatial> >>, and is generated by the
L<<
C<build-keyboard-adjacency-graphs>|https://bitbucket.org/broadbean/p5-data-password-zxcvbn/src/master/maint/build-keyboard-adjacency-graphs
>> program when building the distribution.

=cut

our %graphs = (
  dvorak     => {
                  average_degree => 4.59574468085106,
                  keys => {
                    "!"  => ["`~", undef, undef, "2\@", "'\"", undef],
                    "\"" => [undef, "1!", "2\@", ",<", "aA", undef],
                    "#"  => ["2\@", undef, undef, "4\$", ".>", ",<"],
                    "\$" => ["3#", undef, undef, "5%", "pP", ".>"],
                    "%"  => ["4\$", undef, undef, "6^", "yY", "pP"],
                    "&"  => ["6^", undef, undef, "8*", "gG", "fF"],
                    "'"  => [undef, "1!", "2\@", ",<", "aA", undef],
                    "("  => ["8*", undef, undef, "0)", "rR", "cC"],
                    ")"  => ["9(", undef, undef, "[{", "lL", "rR"],
                    "*"  => ["7&", undef, undef, "9(", "cC", "gG"],
                    "+"  => ["/?", "]}", undef, "\\|", undef, "-_"],
                    ","  => ["'\"", "2\@", "3#", ".>", "oO", "aA"],
                    "-"  => ["sS", "/?", "=+", undef, undef, "zZ"],
                    "."  => [",<", "3#", "4\$", "pP", "eE", "oO"],
                    "/"  => ["lL", "[{", "]}", "=+", "-_", "sS"],
                    "0"  => ["9(", undef, undef, "[{", "lL", "rR"],
                    "1"  => ["`~", undef, undef, "2\@", "'\"", undef],
                    "2"  => ["1!", undef, undef, "3#", ",<", "'\""],
                    "3"  => ["2\@", undef, undef, "4\$", ".>", ",<"],
                    "4"  => ["3#", undef, undef, "5%", "pP", ".>"],
                    "5"  => ["4\$", undef, undef, "6^", "yY", "pP"],
                    "6"  => ["5%", undef, undef, "7&", "fF", "yY"],
                    "7"  => ["6^", undef, undef, "8*", "gG", "fF"],
                    "8"  => ["7&", undef, undef, "9(", "cC", "gG"],
                    "9"  => ["8*", undef, undef, "0)", "rR", "cC"],
                    ":"  => [undef, "aA", "oO", "qQ", undef, undef],
                    ";"  => [undef, "aA", "oO", "qQ", undef, undef],
                    "<"  => ["'\"", "2\@", "3#", ".>", "oO", "aA"],
                    "="  => ["/?", "]}", undef, "\\|", undef, "-_"],
                    ">"  => [",<", "3#", "4\$", "pP", "eE", "oO"],
                    "?"  => ["lL", "[{", "]}", "=+", "-_", "sS"],
                    "\@" => ["1!", undef, undef, "3#", ",<", "'\""],
                    "["  => ["0)", undef, undef, "]}", "/?", "lL"],
                    "\\" => ["=+", undef, undef, undef, undef, undef],
                    "]"  => ["[{", undef, undef, undef, "=+", "/?"],
                    "^"  => ["5%", undef, undef, "7&", "fF", "yY"],
                    "_"  => ["sS", "/?", "=+", undef, undef, "zZ"],
                    "`"  => [undef, undef, undef, "1!", undef, undef],
                    "a"  => [undef, "'\"", ",<", "oO", ";:", undef],
                    "A"  => [undef, "'\"", ",<", "oO", ";:", undef],
                    "B"  => ["xX", "dD", "hH", "mM", undef, undef],
                    "b"  => ["xX", "dD", "hH", "mM", undef, undef],
                    "C"  => ["gG", "8*", "9(", "rR", "tT", "hH"],
                    "c"  => ["gG", "8*", "9(", "rR", "tT", "hH"],
                    "D"  => ["iI", "fF", "gG", "hH", "bB", "xX"],
                    "d"  => ["iI", "fF", "gG", "hH", "bB", "xX"],
                    "E"  => ["oO", ".>", "pP", "uU", "jJ", "qQ"],
                    "e"  => ["oO", ".>", "pP", "uU", "jJ", "qQ"],
                    "f"  => ["yY", "6^", "7&", "gG", "dD", "iI"],
                    "F"  => ["yY", "6^", "7&", "gG", "dD", "iI"],
                    "G"  => ["fF", "7&", "8*", "cC", "hH", "dD"],
                    "g"  => ["fF", "7&", "8*", "cC", "hH", "dD"],
                    "h"  => ["dD", "gG", "cC", "tT", "mM", "bB"],
                    "H"  => ["dD", "gG", "cC", "tT", "mM", "bB"],
                    "I"  => ["uU", "yY", "fF", "dD", "xX", "kK"],
                    "i"  => ["uU", "yY", "fF", "dD", "xX", "kK"],
                    "j"  => ["qQ", "eE", "uU", "kK", undef, undef],
                    "J"  => ["qQ", "eE", "uU", "kK", undef, undef],
                    "k"  => ["jJ", "uU", "iI", "xX", undef, undef],
                    "K"  => ["jJ", "uU", "iI", "xX", undef, undef],
                    "L"  => ["rR", "0)", "[{", "/?", "sS", "nN"],
                    "l"  => ["rR", "0)", "[{", "/?", "sS", "nN"],
                    "M"  => ["bB", "hH", "tT", "wW", undef, undef],
                    "m"  => ["bB", "hH", "tT", "wW", undef, undef],
                    "n"  => ["tT", "rR", "lL", "sS", "vV", "wW"],
                    "N"  => ["tT", "rR", "lL", "sS", "vV", "wW"],
                    "O"  => ["aA", ",<", ".>", "eE", "qQ", ";:"],
                    "o"  => ["aA", ",<", ".>", "eE", "qQ", ";:"],
                    "P"  => [".>", "4\$", "5%", "yY", "uU", "eE"],
                    "p"  => [".>", "4\$", "5%", "yY", "uU", "eE"],
                    "q"  => [";:", "oO", "eE", "jJ", undef, undef],
                    "Q"  => [";:", "oO", "eE", "jJ", undef, undef],
                    "r"  => ["cC", "9(", "0)", "lL", "nN", "tT"],
                    "R"  => ["cC", "9(", "0)", "lL", "nN", "tT"],
                    "s"  => ["nN", "lL", "/?", "-_", "zZ", "vV"],
                    "S"  => ["nN", "lL", "/?", "-_", "zZ", "vV"],
                    "t"  => ["hH", "cC", "rR", "nN", "wW", "mM"],
                    "T"  => ["hH", "cC", "rR", "nN", "wW", "mM"],
                    "u"  => ["eE", "pP", "yY", "iI", "kK", "jJ"],
                    "U"  => ["eE", "pP", "yY", "iI", "kK", "jJ"],
                    "v"  => ["wW", "nN", "sS", "zZ", undef, undef],
                    "V"  => ["wW", "nN", "sS", "zZ", undef, undef],
                    "W"  => ["mM", "tT", "nN", "vV", undef, undef],
                    "w"  => ["mM", "tT", "nN", "vV", undef, undef],
                    "x"  => ["kK", "iI", "dD", "bB", undef, undef],
                    "X"  => ["kK", "iI", "dD", "bB", undef, undef],
                    "y"  => ["pP", "5%", "6^", "fF", "iI", "uU"],
                    "Y"  => ["pP", "5%", "6^", "fF", "iI", "uU"],
                    "Z"  => ["vV", "sS", "-_", undef, undef, undef],
                    "z"  => ["vV", "sS", "-_", undef, undef, undef],
                    "{"  => ["0)", undef, undef, "]}", "/?", "lL"],
                    "|"  => ["=+", undef, undef, undef, undef, undef],
                    "}"  => ["[{", undef, undef, undef, "=+", "/?"],
                    "~"  => [undef, undef, undef, "1!", undef, undef],
                  },
                  starting_positions => 94,
                },
  keypad     => {
                  average_degree => 5.06666666666667,
                  keys => {
                    "*" => ["/", undef, undef, undef, "-", "+", 9, 8],
                    "+" => [9, "*", "-", undef, undef, undef, undef, 6],
                    "-" => ["*", undef, undef, undef, undef, undef, "+", 9],
                    "." => [0, 2, 3, undef, undef, undef, undef, undef],
                    "/" => [undef, undef, undef, undef, "*", 9, 8, 7],
                    "0" => [undef, 1, 2, 3, ".", undef, undef, undef],
                    "1" => [undef, undef, 4, 5, 2, 0, undef, undef],
                    "2" => [1, 4, 5, 6, 3, ".", 0, undef],
                    "3" => [2, 5, 6, undef, undef, undef, ".", 0],
                    "4" => [undef, undef, 7, 8, 5, 2, 1, undef],
                    "5" => [4, 7, 8, 9, 6, 3, 2, 1],
                    "6" => [5, 8, 9, "+", undef, undef, 3, 2],
                    "7" => [undef, undef, undef, "/", 8, 5, 4, undef],
                    "8" => [7, undef, "/", "*", 9, 6, 5, 4],
                    "9" => [8, "/", "*", "-", "+", undef, 6, 5],
                  },
                  starting_positions => 15,
                },
  mac_keypad => {
                  average_degree => 5.25,
                  keys => {
                    "*" => ["/", undef, undef, undef, undef, undef, "-", 9],
                    "+" => [6, 9, "-", undef, undef, undef, undef, 3],
                    "-" => [9, "/", "*", undef, undef, undef, "+", 6],
                    "." => [0, 2, 3, undef, undef, undef, undef, undef],
                    "/" => ["=", undef, undef, undef, "*", "-", 9, 8],
                    "0" => [undef, 1, 2, 3, ".", undef, undef, undef],
                    "1" => [undef, undef, 4, 5, 2, 0, undef, undef],
                    "2" => [1, 4, 5, 6, 3, ".", 0, undef],
                    "3" => [2, 5, 6, "+", undef, undef, ".", 0],
                    "4" => [undef, undef, 7, 8, 5, 2, 1, undef],
                    "5" => [4, 7, 8, 9, 6, 3, 2, 1],
                    "6" => [5, 8, 9, "-", "+", undef, 3, 2],
                    "7" => [undef, undef, undef, "=", 8, 5, 4, undef],
                    "8" => [7, undef, "=", "/", 9, 6, 5, 4],
                    "9" => [8, "=", "/", "*", "-", "+", 6, 5],
                    "=" => [undef, undef, undef, undef, "/", 9, 8, 7],
                  },
                  starting_positions => 16,
                },
  qwerty     => {
                  average_degree => 4.59574468085106,
                  keys => {
                    "!"  => ["`~", undef, undef, "2\@", "qQ", undef],
                    "\"" => [";:", "[{", "]}", undef, undef, "/?"],
                    "#"  => ["2\@", undef, undef, "4\$", "eE", "wW"],
                    "\$" => ["3#", undef, undef, "5%", "rR", "eE"],
                    "%"  => ["4\$", undef, undef, "6^", "tT", "rR"],
                    "&"  => ["6^", undef, undef, "8*", "uU", "yY"],
                    "'"  => [";:", "[{", "]}", undef, undef, "/?"],
                    "("  => ["8*", undef, undef, "0)", "oO", "iI"],
                    ")"  => ["9(", undef, undef, "-_", "pP", "oO"],
                    "*"  => ["7&", undef, undef, "9(", "iI", "uU"],
                    "+"  => ["-_", undef, undef, undef, "]}", "[{"],
                    ","  => ["mM", "kK", "lL", ".>", undef, undef],
                    "-"  => ["0)", undef, undef, "=+", "[{", "pP"],
                    "."  => [",<", "lL", ";:", "/?", undef, undef],
                    "/"  => [".>", ";:", "'\"", undef, undef, undef],
                    "0"  => ["9(", undef, undef, "-_", "pP", "oO"],
                    "1"  => ["`~", undef, undef, "2\@", "qQ", undef],
                    "2"  => ["1!", undef, undef, "3#", "wW", "qQ"],
                    "3"  => ["2\@", undef, undef, "4\$", "eE", "wW"],
                    "4"  => ["3#", undef, undef, "5%", "rR", "eE"],
                    "5"  => ["4\$", undef, undef, "6^", "tT", "rR"],
                    "6"  => ["5%", undef, undef, "7&", "yY", "tT"],
                    "7"  => ["6^", undef, undef, "8*", "uU", "yY"],
                    "8"  => ["7&", undef, undef, "9(", "iI", "uU"],
                    "9"  => ["8*", undef, undef, "0)", "oO", "iI"],
                    ":"  => ["lL", "pP", "[{", "'\"", "/?", ".>"],
                    ";"  => ["lL", "pP", "[{", "'\"", "/?", ".>"],
                    "<"  => ["mM", "kK", "lL", ".>", undef, undef],
                    "="  => ["-_", undef, undef, undef, "]}", "[{"],
                    ">"  => [",<", "lL", ";:", "/?", undef, undef],
                    "?"  => [".>", ";:", "'\"", undef, undef, undef],
                    "\@" => ["1!", undef, undef, "3#", "wW", "qQ"],
                    "["  => ["pP", "-_", "=+", "]}", "'\"", ";:"],
                    "\\" => ["]}", undef, undef, undef, undef, undef],
                    "]"  => ["[{", "=+", undef, "\\|", undef, "'\""],
                    "^"  => ["5%", undef, undef, "7&", "yY", "tT"],
                    "_"  => ["0)", undef, undef, "=+", "[{", "pP"],
                    "`"  => [undef, undef, undef, "1!", undef, undef],
                    "a"  => [undef, "qQ", "wW", "sS", "zZ", undef],
                    "A"  => [undef, "qQ", "wW", "sS", "zZ", undef],
                    "B"  => ["vV", "gG", "hH", "nN", undef, undef],
                    "b"  => ["vV", "gG", "hH", "nN", undef, undef],
                    "C"  => ["xX", "dD", "fF", "vV", undef, undef],
                    "c"  => ["xX", "dD", "fF", "vV", undef, undef],
                    "D"  => ["sS", "eE", "rR", "fF", "cC", "xX"],
                    "d"  => ["sS", "eE", "rR", "fF", "cC", "xX"],
                    "E"  => ["wW", "3#", "4\$", "rR", "dD", "sS"],
                    "e"  => ["wW", "3#", "4\$", "rR", "dD", "sS"],
                    "f"  => ["dD", "rR", "tT", "gG", "vV", "cC"],
                    "F"  => ["dD", "rR", "tT", "gG", "vV", "cC"],
                    "G"  => ["fF", "tT", "yY", "hH", "bB", "vV"],
                    "g"  => ["fF", "tT", "yY", "hH", "bB", "vV"],
                    "h"  => ["gG", "yY", "uU", "jJ", "nN", "bB"],
                    "H"  => ["gG", "yY", "uU", "jJ", "nN", "bB"],
                    "I"  => ["uU", "8*", "9(", "oO", "kK", "jJ"],
                    "i"  => ["uU", "8*", "9(", "oO", "kK", "jJ"],
                    "j"  => ["hH", "uU", "iI", "kK", "mM", "nN"],
                    "J"  => ["hH", "uU", "iI", "kK", "mM", "nN"],
                    "k"  => ["jJ", "iI", "oO", "lL", ",<", "mM"],
                    "K"  => ["jJ", "iI", "oO", "lL", ",<", "mM"],
                    "L"  => ["kK", "oO", "pP", ";:", ".>", ",<"],
                    "l"  => ["kK", "oO", "pP", ";:", ".>", ",<"],
                    "M"  => ["nN", "jJ", "kK", ",<", undef, undef],
                    "m"  => ["nN", "jJ", "kK", ",<", undef, undef],
                    "n"  => ["bB", "hH", "jJ", "mM", undef, undef],
                    "N"  => ["bB", "hH", "jJ", "mM", undef, undef],
                    "O"  => ["iI", "9(", "0)", "pP", "lL", "kK"],
                    "o"  => ["iI", "9(", "0)", "pP", "lL", "kK"],
                    "P"  => ["oO", "0)", "-_", "[{", ";:", "lL"],
                    "p"  => ["oO", "0)", "-_", "[{", ";:", "lL"],
                    "q"  => [undef, "1!", "2\@", "wW", "aA", undef],
                    "Q"  => [undef, "1!", "2\@", "wW", "aA", undef],
                    "r"  => ["eE", "4\$", "5%", "tT", "fF", "dD"],
                    "R"  => ["eE", "4\$", "5%", "tT", "fF", "dD"],
                    "s"  => ["aA", "wW", "eE", "dD", "xX", "zZ"],
                    "S"  => ["aA", "wW", "eE", "dD", "xX", "zZ"],
                    "t"  => ["rR", "5%", "6^", "yY", "gG", "fF"],
                    "T"  => ["rR", "5%", "6^", "yY", "gG", "fF"],
                    "u"  => ["yY", "7&", "8*", "iI", "jJ", "hH"],
                    "U"  => ["yY", "7&", "8*", "iI", "jJ", "hH"],
                    "v"  => ["cC", "fF", "gG", "bB", undef, undef],
                    "V"  => ["cC", "fF", "gG", "bB", undef, undef],
                    "W"  => ["qQ", "2\@", "3#", "eE", "sS", "aA"],
                    "w"  => ["qQ", "2\@", "3#", "eE", "sS", "aA"],
                    "x"  => ["zZ", "sS", "dD", "cC", undef, undef],
                    "X"  => ["zZ", "sS", "dD", "cC", undef, undef],
                    "y"  => ["tT", "6^", "7&", "uU", "hH", "gG"],
                    "Y"  => ["tT", "6^", "7&", "uU", "hH", "gG"],
                    "Z"  => [undef, "aA", "sS", "xX", undef, undef],
                    "z"  => [undef, "aA", "sS", "xX", undef, undef],
                    "{"  => ["pP", "-_", "=+", "]}", "'\"", ";:"],
                    "|"  => ["]}", undef, undef, undef, undef, undef],
                    "}"  => ["[{", "=+", undef, "\\|", undef, "'\""],
                    "~"  => [undef, undef, undef, "1!", undef, undef],
                  },
                  starting_positions => 94,
                },
);

1;
