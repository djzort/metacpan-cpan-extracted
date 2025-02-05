#!/usr/bin/perl

use v5.14;
use warnings;

use Test::More;
use Test::Fatal;

package TestParser {
   use base qw( Parser::MGC );

   sub parse
   {
      my $self = shift;

      $self->scope_of(
         "(",
         sub { return $self->token_int },
         ")"
      );
   }
}

package TestParser2 {
   use base qw( Parser::MGC );

   sub parse
   {
      my $self = shift;

      $self->scope_of( "(", 'token_int', ")" );
   }
}

package DynamicDelimParser {
   use base qw( Parser::MGC );

   sub parse
   {
      my $self = shift;

      my $delim = $self->expect( qr/[\(\[]/ );
      $delim =~ tr/([/)]/;

      $self->scope_of(
         undef,
         sub { return $self->token_int },
         $delim,
      );
   }
}

my $parser = TestParser->new;

is( $parser->from_string( "(123)" ), 123, '"(123)"' );

ok( exception { $parser->from_string( "(abc)" ) }, '"(abc)"' );
ok( exception { $parser->from_string( "456" ) }, '"456"' );

is( TestParser2->new->from_string( "(67)" ), 67, '"(67)" as method name' );

$parser = DynamicDelimParser->new;

is( $parser->from_string( "(45)" ), 45, '"(45)"' );
is( $parser->from_string( "[45]" ), 45, '"[45]"' );

ok( exception { $parser->from_string( "(45]" ) }, '"(45]" fails' );

done_testing;
