package Venus::Role::Defaultable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# BUILDERS

sub BUILD {
  my ($self) = @_;

  return $self if !$self->can('defaults');

  my $defaults = $self->defaults;

  return $self if !$defaults;

  for my $name ($self->META->attrs) {
    if (exists $defaults->{$name} && !exists $self->{$name}) {
      $self->{$name} = $defaults->{$name};
    }
  }

  return $self;
}

1;



=head1 NAME

Venus::Role::Defaultable - Defaultable Role

=cut

=head1 ABSTRACT

Defaultable Role for Perl 5

=cut

=head1 SYNOPSIS

  package Example;

  use Venus::Class 'attr', 'with';

  with 'Venus::Role::Defaultable';

  attr 'name';

  sub defaults {
    {
      name => 'example',
    }
  }

  package main;

  my $example = Example->new;

  # bless({name => 'example'}, "Example")

=cut

=head1 DESCRIPTION

This package provides a mechanism for setting default values for missing
constructor arguments.

=cut