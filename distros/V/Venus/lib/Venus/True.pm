package Venus::True;

use 5.018;

use strict;
use warnings;

use Scalar::Util ();

state $true = Scalar::Util::dualvar(1, "1");

use overload (
  '!' => sub{!$true},
  'bool' => sub{$true},
  fallback => 1,
);

# METHODS

sub new {
  return bless({});
}

sub value {
  return $true;
}

1;



=head1 NAME

Venus::True - True Class

=cut

=head1 ABSTRACT

True Class for Perl 5

=cut

=head1 SYNOPSIS

  package main;

  use Venus::True;

  my $true = Venus::True->new;

  # $true->value;

=cut

=head1 DESCRIPTION

This package provides the global C<true> value used in L<Venus::Boolean> and
the L<Venus/true> function.

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 value

  value() (Bool)

The value method returns value representing the global C<true> value.

I<Since C<1.23>>

=over 4

=item value example 1

  # given: synopsis;

  my $value = $true->value;

  # 1

=back

=cut