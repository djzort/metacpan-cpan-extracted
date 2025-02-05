package Zing::Meta;

use 5.014;

use strict;
use warnings;

use registry 'Zing::Types';
use routines;

use Data::Object::Class;
use Data::Object::ClassHas;

extends 'Zing::KeyVal';

our $VERSION = '0.27'; # VERSION

# METHODS

method term() {
  return $self->app->term($self)->meta;
}

1;



=encoding utf8

=head1 NAME

Zing::Meta - Process Metadata

=cut

=head1 ABSTRACT

Generic Process Metadata

=cut

=head1 SYNOPSIS

  use Zing::Meta;

  my $meta = Zing::Meta->new(name => rand);

  # $meta->recv;

=cut

=head1 DESCRIPTION

This package provides process metadata for tracking active processes.

=cut

=head1 INHERITS

This package inherits behaviors from:

L<Zing::KeyVal>

=cut

=head1 LIBRARIES

This package uses type constraints from:

L<Zing::Types>

=cut

=head1 ATTRIBUTES

This package has the following attributes:

=cut

=head2 name

  name(Str)

This attribute is read-only, accepts C<(Str)> values, and is optional.

=cut

=head1 METHODS

This package implements the following methods:

=cut

=head2 drop

  drop() : Int

The drop method returns truthy if the process metadata can be dropped.

=over 4

=item drop example #1

  # given: synopsis

  $meta->drop;

=back

=cut

=head2 recv

  recv() : Maybe[HashRef]

The recv method fetches the process metadata (if any).

=over 4

=item recv example #1

  # given: synopsis

  $meta->recv;

=back

=over 4

=item recv example #2

  # given: synopsis

  use Zing::Process;

  $meta->send(Zing::Process->new->metadata);

  $meta->recv;

=back

=cut

=head2 send

  send(HashRef $proc) : Str

The send method commits the metadata provided to the store overwriting any
existing data.

=over 4

=item send example #1

  # given: synopsis

  $meta->send({ created => time });

=back

=over 4

=item send example #2

  # given: synopsis

  use Zing::Process;

  $meta->drop;

  $meta->send(Zing::Process->new->metadata);

=back

=cut

=head2 term

  term(Str @keys) : Str

The term method generates a term (safe string) for the metadata.

=over 4

=item term example #1

  # given: synopsis

  $meta->term;

=back

=cut

=head1 AUTHOR

Al Newkirk, C<awncorp@cpan.org>

=head1 LICENSE

Copyright (C) 2011-2019, Al Newkirk, et al.

This is free software; you can redistribute it and/or modify it under the terms
of the The Apache License, Version 2.0, as elucidated in the L<"license
file"|https://github.com/cpanery/zing/blob/master/LICENSE>.

=head1 PROJECT

L<Wiki|https://github.com/cpanery/zing/wiki>

L<Project|https://github.com/cpanery/zing>

L<Initiatives|https://github.com/cpanery/zing/projects>

L<Milestones|https://github.com/cpanery/zing/milestones>

L<Contributing|https://github.com/cpanery/zing/blob/master/CONTRIBUTE.md>

L<Issues|https://github.com/cpanery/zing/issues>

=cut
