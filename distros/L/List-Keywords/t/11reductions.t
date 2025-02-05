#!/usr/bin/perl

use v5.14;
use warnings;

use Test::More;

use List::Keywords 'reductions';

# Short cornercases
{
   is_deeply( [ reductions { die "ARGH" } () ], [],
      'reductions on empty list yields empty' );

   is_deeply( [ reductions { die "ARGH" } 123 ], [ 123 ],
      'reductions on singleton list yields value directly' );
}

# basic sum
is_deeply(
   [ reductions { $a + $b } 1 .. 5 ], 
   [ 1, 3, 6, 10, 15 ],
   'partial sums of 1..5'
);

# reduce is definitely a left-fold
is_deeply(
   [ reductions { "($a+$b)" } "a" .. "d" ],
   [ "a", "(a+b)", "((a+b)+c)", "(((a+b)+c)+d)" ],
   'reductions is a left-fold' );

# We don't guarantee what this will return but it definitely shouldn't crash
{
   my $ret = reductions { $a + $b } 1 .. 5;
   pass( 'reductions in scalar context does not crash' );
}

done_testing;
