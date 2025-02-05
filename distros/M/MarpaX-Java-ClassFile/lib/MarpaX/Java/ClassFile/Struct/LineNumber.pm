use strict;
use warnings FATAL => 'all';

package MarpaX::Java::ClassFile::Struct::LineNumber;
use MarpaX::Java::ClassFile::Struct::_Base
  -tiny => [qw/start_pc line_number/],
  '""' => [
           #
           # Force one line
           #
           [ sub { '{#Start pc, Line number}' } => sub { '{#' . $_[0]->start_pc . ', ' . $_[0]->line_number . '}' } ]
          ];

# ABSTRACT: line and number

our $VERSION = '0.008'; # VERSION

our $AUTHORITY = 'cpan:JDDPAUSE'; # AUTHORITY

use MarpaX::Java::ClassFile::Struct::_Types qw/U2 U4/;

has start_pc    => ( is => 'ro', required => 1, isa => U2 );
has line_number => ( is => 'ro', required => 1, isa => U4 );

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

MarpaX::Java::ClassFile::Struct::LineNumber - line and number

=head1 VERSION

version 0.008

=head1 AUTHOR

Jean-Damien Durand <jeandamiendurand@free.fr>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Jean-Damien Durand.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
