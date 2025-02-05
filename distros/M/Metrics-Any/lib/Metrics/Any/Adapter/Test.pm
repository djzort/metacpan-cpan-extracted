#  You may distribute under the terms of either the GNU General Public License
#  or the Artistic License (the same terms as Perl itself)
#
#  (C) Paul Evans, 2020-2022 -- leonerd@leonerd.org.uk

package Metrics::Any::Adapter::Test 0.09;

use v5.14;
use warnings;
use base qw( Metrics::Any::AdapterBase::Stored );

use Carp;

use List::Util 1.29 qw( pairs );
use Scalar::Util qw( reftype );

=head1 NAME

C<Metrics::Any::Adapter::Test> - a metrics reporting adapter for unit testing

=head1 SYNOPSIS

   use Test::More;
   use Metrics::Any::Adapter 'Test';

   {
      Metrics::Any::Adapter::Test->clear;

      # perform some work in the code under test

      is( Metrics::Any::Adapter::Test->metrics,
         "an_expected_metric = 1\n",
         'Metrics were reported while doing something'
      );
   }

=head1 DESCRIPTION

This L<Metrics::Any> adapter type stores reported metrics locally, allowing
access to them by the L</metrics> method. This is useful to use in a unit test
to check that the code under test reports the correct metrics.

This adapter supports timer metrics by storing as distributions. By default,
distributions store only a summary, giving the count and total duration. If
required, the full values can be stored by setting L</use_full_distributions>.

For predictable output of timer metrics in unit tests, a unit test may wish to
use the L</override_timer_duration> method.

This adapter type supports batch mode reporting. Callbacks are invoked at the
beginning of the L</metrics> method.

=cut

my $singleton;

sub new
{
   my $class = shift;
   return $singleton //= $class->SUPER::new( @_ );
}

# We're a singleton instance, so we can just store state in file-scoped
# lexicals

my $timer_duration;
my $use_full_distributions;

=head1 METHODS

=cut

=head2 metrics

   $result = Metrics::Any::Adapter::Test->metrics

This class method returns a string describing all of the stored metric values.
Each is reported on a line formatted as

   name = value

Each line, including the final one, is terminated by a linefeed. The metrics
are sorted alphabetically. Any multi-part metric names will be joined with
underscores (C<_>).

Metrics that have additional labels are formatted with additional label names
and label values in declared order after the name and before the C<=> symbol:

   name l1:v1 l2:v2 = value

=cut

=head2 use_full_distributions

   Metrics::Any::Adapter::Test->use_full_distributions;  # enables the option

   Metrics::Any::Adapter::Test->use_full_distributions( $enable );

I<Since version 0.08.>

If enabled, this option stores the full value of every reported observation
into distributions, rathr than just the count-and-total summary.

Full value distributions will be formatted as a sequence of lines containing
the count of observations at that particular value, in square brackets,
followed by the summary count.

   name[v1] = c1
   name[v2] = c2
   ...
   name_count = c

In order not to be too sensitive to numerical rounding errors, values are
stored to only 3 decimal places.

=cut

sub use_full_distributions
{
   shift;
   ( $use_full_distributions ) = @_ ? @_ : ( 1 );
}

use constant {
   DIST_COUNT => 0,
   DIST_TOTAL => 1,
};

sub store_distribution
{
   shift;
   my ( $storage, $amount ) = @_;

   if( $use_full_distributions ) {
      $storage //= {};

      $storage->{ sprintf "%.3f", $amount }++;
   }
   else {
      $storage //= [ 0, 0 ];
      $storage->[DIST_COUNT] += 1;
      $storage->[DIST_TOTAL] += $amount;
   }

   return $storage;
}

*store_timer = \&store_distribution;

sub metrics
{
   my $self = shift;
   ref $self or $self = Metrics::Any::Adapter::Test->new;

   my @ret;

   $self->walk( sub {
      my ( $type, $name, $labels, $value ) = @_;

      $name .= sprintf " %s:%s", $_->key, $_->value for pairs @$labels;

      if( $type eq "counter" or $type eq "gauge" ) {
         push @ret, "$name = $value";
      }
      elsif( $type eq "distribution" or $type eq "timer" ) {
         if( reftype $value eq "HASH" ) {
            my $total = 0;
            foreach my $k ( sort { $a <=> $b } keys %$value ) {
               my $v = $value->{$k};
               # Trim trailing zeroes for neatness
               $k =~ s/\.0+$/./; $k =~ s/\.$//;

               push @ret, "$name\[$k] = $v";
               $total += $v;
            }
            push @ret, "${name}_count = $total";
         }
         else {
            push @ret, "${name}_count = " . $value->[DIST_COUNT];
            push @ret, "${name}_total = " . $value->[DIST_TOTAL];
         }
      }
      else {
         warn "Unsure how to handle metric of type $type\n";
      }
   } );

   return join "", map { "$_\n" } @ret;
}

=head2 clear

   Metrics::Any::Adapter::Test->clear

This class method removes all of the stored values of reported metrics.

=cut

sub clear
{
   my $self = shift;
   ref $self or $self = Metrics::Any::Adapter::Test->new;

   $self->clear_values;

   undef $timer_duration;
}

=head2 override_timer_duration

   Metrics::Any::Adapter::Test->override_timer_duration( $duration )

This class method sets a duration value, that any subsequent call to
C<inc_timer> will use instead of the value the caller actually passed in. This
will ensure reliably predictable output in unit tests.

Any value set here will be cleared by L</clear>.

=cut

sub override_timer_duration
{
   shift;
   ( $timer_duration ) = @_;
}

sub report_timer
{
   my $self = shift;
   my ( $handle, $duration, @labelvalues ) = @_;

   $duration = $timer_duration if defined $timer_duration;

   $self->SUPER::report_timer( $handle, $duration, @labelvalues );
}

=head1 AUTHOR

Paul Evans <leonerd@leonerd.org.uk>

=cut

0x55AA;
