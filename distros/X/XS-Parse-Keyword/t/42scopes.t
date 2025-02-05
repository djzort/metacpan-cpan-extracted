#!/usr/bin/perl

use v5.14;
use warnings;

use Test::More;

use lib "t";
use testcase "t::structures";

BEGIN { $^H{"t::structures/permit"} = 1; }

# paren scope
{
   is( scopeparen ( "abc" ), "abc", 'parenthesis scope' );
}

# arg scope - parens are optional
{
   is( scopeargs ( "123" ), "123", 'arguments scope with parens' );
   is( scopeargs "123",     "123", 'arguments scope without parens' );
}

# bracket scope
{
   is( scopebracket [ "def" ], "def", 'bracket scope' );
}

# brace scope
{
   is( scopebrace { "ghi" }, "ghi", 'brace scope' );
}

# chevron scope
{
   # takes a bareword identifier
   is( scopechevron < jkl >, "jkl", 'chevron scope' );
}

done_testing;
