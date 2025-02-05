#!/usr/bin/perl

use v5.14;
use warnings;

use Test::More;

use lib "t";
use testcase "t::pieces";

BEGIN { $^H{"t::pieces/permit"} = 1; }

my $ret;

{
   $ret = piecearithexpr "a term";
   is( $ret, "(a term)", 'a single term' );
}

# arithexpr vs concat
{
   $ret = piecearithexpr "x" . "y";
   is( $ret, "(xy)", 'arithexpr consumes concat' );
}

# arithexpr vs comma
{
   $ret = join "", "x", piecearithexpr "inside", "y";
   is( $ret, "x(inside)y", 'arithexpr stops before comma' );
}

# arithexpr in piece1 can act as entire parens
{
   $ret = piecearithexpr( "x" ) . "y";
   is( $ret, "(x)y", 'arithexpr treats (PARENS) as entire expression' );
}

done_testing;
