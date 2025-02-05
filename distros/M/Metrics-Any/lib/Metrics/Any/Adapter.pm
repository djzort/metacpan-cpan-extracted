#  You may distribute under the terms of either the GNU General Public License
#  or the Artistic License (the same terms as Perl itself)
#
#  (C) Paul Evans, 2020 -- leonerd@leonerd.org.uk

package Metrics::Any::Adapter 0.09;

use v5.14;
use warnings;

use Carp;

=head1 NAME

C<Metrics::Any::Adapter> - set the C<Metrics::Any> adapter for the program

=head1 SYNOPSIS

In a program or top-level program-like module:

   use Metrics::Any::Adapter 'Prometheus';

=head1 DESCRIPTION

The C<use> statement which loads this module sets the adapter module for
L<Metrics::Any> to report metrics generated by an modules the program uses.

The first value passed should be a string giving the name of an adapter
module, which will be expected under the C<Metrics::Any::Adapter::>-prefix.
This module will be loaded and set as the adapter to use. Any additional
arguments will be passed to the constructor of the adapter instance.

   use Metrics::Any::Adapter Custom => "another arg";

   # implies
   $adapter = Metrics::Any::Adapter::Custom->new( "another arg" );

=head1 ENVIRONMENT

=head2 METRICS_ANY_ADAPTER

I<Since version 0.04.>

Sets the default adapter type to use if the program has not otherwise
requested one.

Normally this is set to C<Null>, which loads L<Metrics::Any::Adapter::Null>.
By overriding this to a different value, a default adapter can be loaded
without modifying the program. This may be useful for example, when running
unit tests:

   $ METRICS_ANY_ADAPTER=Stderr ./Build test

Additional arguments can be specified after a colon, separated by commas or
equals signs.

   $ METRICS_ANY_ADAPTER=File:path=metrics.log ./program.pl

Note that if a program requests a specific adapter that will override this
variable.

A limited attempt is made at supporting nested arguments wrapped in square
brackets, to allow basic operation of the L<Metrics::Any::Adapter::Tee>
adapter via this variable to itself pass arguments into child adapters:

   $ METRICS_ANY_ADAPTER=Tee:Prometheus,[File:path=metrics.log] perl ...

This should be considered a best-effort scenario useful for short-term testing
and debugging. For more complex requirements in your script or program, it is
better to use the import arguments directly as then any perl data structures
can be passed around.

=cut

sub import
{
   my $pkg = shift;
   my $caller = caller;
   $pkg->import_into( $caller, @_ );
}

# Class method so Metrics::Any::Adapter::Tee can share it
sub split_type_string
{
   shift;
   my ( $str ) = @_;

   my ( $type, $argstr ) = split m/[:,]/, $str, 2;
   my @args;

   while( length $argstr ) {
      if( $argstr =~ m/^\[/ ) {
         # Extract the entire contents of the [...] bracket
         # TODO: Support deeper nesting somehow? Currently this is only used
         # for using the Tee adapter via the $METRICS_ANY_ADAPTER variable
         $argstr =~ s/^\[(.*?)\](?:,|=|$)// or
            croak "Missing close bracket ] in adapter type string";
         push @args, $1;
      }
      else {
         # All up to the next , = or endofstring
         $argstr =~ s/^(.*?)(?:,|=|$)//;
         push @args, $1;
      }
   }

   return ( $type, @args );
}

sub class_for_type
{
   shift;
   my ( $type ) = @_;

   my $class = "Metrics::Any::Adapter::$type";
   unless( $class->can( 'new' ) ) {
      ( my $file = "$class.pm" ) =~ s{::}{/}g;
      require $file;
   }
   return $class;
}

my $adaptertype = "Null";
my @adapterargs;
if( my $val = $ENV{METRICS_ANY_ADAPTER} ) {
   ( $adaptertype, @adapterargs ) = __PACKAGE__->split_type_string( $val );
}

sub import_into
{
   my ( $pkg, $caller, @args ) = @_;

   ( $adaptertype, @adapterargs ) = @args if @args;
}

my $adapter;

sub adapter
{
   shift;

   return $adapter //= __PACKAGE__->class_for_type( $adaptertype )->new( @adapterargs );
}

=head1 AUTHOR

Paul Evans <leonerd@leonerd.org.uk>

=cut

0x55AA;
