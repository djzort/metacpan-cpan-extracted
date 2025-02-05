package Venus::Role::Throwable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub throw {
  my ($self, $name) = @_;

  my $context = (caller(1))[3];
  my $package = $name || join('::', map ucfirst, ref($self), 'error');

  require Venus::Throw;

  return Venus::Throw->new(package => $package, context => $context);
}

# EXPORTS

sub EXPORT {
  ['throw']
}

1;



=head1 NAME

Venus::Role::Throwable - Throwable Role

=cut

=head1 ABSTRACT

Throwable Role for Perl 5

=cut

=head1 SYNOPSIS

  package Example;

  use Venus::Class;

  with 'Venus::Role::Throwable';

  package main;

  my $example = Example->new;

  # $example->throw;

=cut

=head1 DESCRIPTION

This package modifies the consuming package and provides a mechanism for
throwing context-aware errors (exceptions).

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 throw

  throw(Maybe[Str] $package) (Throw)

The throw method builds a L<Venus::Throw> object, which can raise errors
(exceptions).

I<Since C<0.01>>

=over 4

=item throw example 1

  package main;

  my $example = Example->new;

  my $throw = $example->throw;

  # bless({ "package" => "Example::Error", ..., }, "Venus::Throw")

  # $throw->error;

=back

=cut