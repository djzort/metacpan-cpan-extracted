package Test::PDL;
$Test::PDL::VERSION = '0.20';
# ABSTRACT: Test Perl Data Language arrays (a.k.a. ndarrays) for equality


use strict;
use warnings;
use PDL::Lite;
use PDL::Types ();

use base qw( Exporter );
our @EXPORT = qw( is_pdl );
our @EXPORT_OK = qw( eq_pdl eq_pdl_diag is_pdl test_pdl );
our %EXPORT_TAGS = ( deep => [ qw( test_pdl ) ] );


our %OPTIONS = (
	TOLERANCE   => 1e-6,
	EQUAL_TYPES => 1,
);


sub import
{
	my $i = 0;
	while( $i < @_ ) {
		if( $_[ $i ] =~ /^-/ ) {
			my( $key, $val ) = splice @_, $i, 2;
			$key =~ s/^-(.*)/\U$1/;
			set_options( $key, $val );
		}
		else { $i++ }
	}
	__PACKAGE__->export_to_level( 1, @_ );
}


sub _approx
{
	my( $a, $b ) = @_;
	return abs( $a - $b ) < $OPTIONS{ TOLERANCE };
}


sub _comparison_fails
{
	my ( $got, $expected ) = @_;
	if( not eval { $got->isa('PDL') } ) {
		return 'received value is not a ndarray';
	}
	if( not eval { $expected->isa('PDL') } ) {
		return 'expected value is not a ndarray';
	}
	if( $OPTIONS{ EQUAL_TYPES } && $got->type != $expected->type ) {
		return 'types do not match (EQUAL_TYPES is true)';
	}
	if( $got->ndims != $expected->ndims ) {
		return 'dimensions do not match in number';
	}
	if( not _dimensions_match( [$got->dims], [$expected->dims] ) ) {
		return 'dimensions do not match in extent';
	}
	# evaluating these only makes sense for ndarrays that conform in shape
	if( ( $got->badflag == 1 || $expected->badflag == 1 ) &&
		not eval { PDL::all( PDL::isbad($got) == PDL::isbad($expected) ) } ) {
		return 'bad value patterns do not match';
	}
	return 'values do not match'
		if ( $got->isempty and !$expected->isempty)
		or (!$got->isempty and  $expected->isempty);
	return 0 if $got->isempty and $expected->isempty;
	# if we get here, bad value patterns are sure to match, remove
	my $isgood = $got->isgood;
	$got = $got->where($isgood), $expected = $expected->where($isgood);
	return 0 if $got->isempty;
	if( $got->type < PDL::float && $expected->type < PDL::float ) {
		if( not eval { PDL::all( $got == $expected ) } ) {
			return 'values do not match';
		}
	}
	else {
		# floating-point comparison must be approximate
		if( not eval { PDL::all( _approx $got, $expected ) } ) {
			return 'values do not match';
		}
	}
	# if we get here, we didn't fail
	return 0;
}


sub _dimensions_match
{
	my @A = @{ +shift };
	my @B = @{ +shift };
	while( my $a = shift @A and my $b = shift @B ) {
		if( $a != $b ) { return 0 }
	}
	return 1;
}


sub is_pdl
{
	require Test::Builder;
	my ( $got, $expected, $name ) = @_;
	my $tb = Test::Builder->new;
	if( eval { $name->isa('PDL') } ) {
		$tb->croak( 'error in arguments: test name is a ndarray' );
	}
	$name ||= "ndarrays are equal";
	if( my $reason = _comparison_fails $got, $expected ) {
		my $rc = $tb->ok( 0, $name );
		my $fmt = '%-8T %-12D (%-5S) ';
		$tb->diag( "    $reason\n",
			   "         got: ", eval { $got->isa('PDL')      && !$got->isnull      } ? $got->info( $fmt )      : '', $got, "\n",
			   "    expected: ", eval { $expected->isa('PDL') && !$expected->isnull } ? $expected->info( $fmt ) : '', $expected );
		return $rc;
	}
	else {
		return $tb->ok( 1, $name );
	}
}


sub eq_pdl
{
	my ( $got, $expected ) = @_;
	return !_comparison_fails( $got, $expected );
}


sub eq_pdl_diag
{
	my ( $got, $expected ) = @_;
	my $reason = _comparison_fails( $got, $expected );
	if( $reason ) { return 0, $reason }
	else { return 1 }
}


sub test_pdl
{
	require Test::Deep::PDL;
	my $expected = PDL::Core::pdl( @_ );
	return Test::Deep::PDL->new( $expected );
}


for my $type ( PDL::Types::types ) {
	my $sub = sub {
		require Test::Deep::PDL;
		my $expected = PDL::convert(
			PDL::Core::alltopdl( 'PDL', scalar(@_) > 1 ? [@_] : shift ),
			$type->numval
		);
		return Test::Deep::PDL->new( $expected );
	};
	my $sub_name = 'test_' . $type->convertfunc;
	{
		no strict 'refs';
		*$sub_name = $sub;
	}
	push @EXPORT_OK, $sub_name;
	push @{ $EXPORT_TAGS{deep} }, $sub_name;
}


sub set_options
{
	while( my( $key, $value ) = splice @_, 0, 2 ) {
		PDL::barf( "invalid option $key" ) unless grep { $key eq $_ } keys %OPTIONS;
		PDL::barf( "undefined value for $key" ) unless defined $value;
		$OPTIONS{ $key } = $value;
	}
}


1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Test::PDL - Test Perl Data Language arrays (a.k.a. ndarrays) for equality

=head1 VERSION

version 0.20

=head1 SYNOPSIS

	use PDL;
	use Test::More tests => 3;
	use Test::PDL qw( is_pdl :deep );

	# an example of a test that succeeds
	$got      = sequence 5;
	$expected = pdl( 0,1,2,3,4 );
	is_pdl( $got, $expected, 'sequence() works as expected' );
	#   OUTPUT:
	# ok 1 - sequence() works as expected

	# if a test fails, detailed diagnostics are printed; the output is
	# similar to that of is() from L<Test::More>
	$got      = pdl( 0,-1,-2,3,4 );
	$expected = sequence 5;
	is_pdl( $got, $expected, 'demonstrate the output of a failing test' );
	#   OUTPUT:
	# not ok 2 - demonstrate the output of a failing test
	#
	#   Failed test 'demonstrate the output of a failing test'
	#   at aux/pod.t line 16.
	#     values do not match
	#          got: Double   D [5]        (P    ) [0 -1 -2 3 4]
	#     expected: Double   D [5]        (P    ) [0 1 2 3 4]

	# ndarrays within other data structures can be tested with Test::Deep
	use Test::Deep qw( cmp_deeply );
	$got      = { name => 'Histogram', data => long( 17,0,1 ) };
	$expected = { name => 'Histogram', data => test_long( 17,0,0,1 ) };
	cmp_deeply( $got, $expected, 'demonstrate the output of a failing deep comparison' );
	#   OUTPUT:
	# not ok 3 - demonstrate the output of a failing deep comparison
	#
	#   Failed test 'demonstrate the output of a failing deep comparison'
	#   at aux/pod.t line 30.
	# Comparing $data->{"data"} as a ndarray:
	# dimensions do not match in extent
	#    got : Long     D [3]        (P    ) [17 0 1]
	# expect : Long     D [4]        (P    ) [17 0 0 1]

=head1 DESCRIPTION

With Test::PDL, you can compare two ndarrays for equality. The comparison is
performed as thoroughly as possible, comparing types, dimensions, bad value
patterns, and finally the values themselves. The exact behaviour can be
configured by setting certain options (see set_options() and %OPTIONS below).
Test::PDL is mostly useful in test scripts.

Test::PDL is to be used with the Perl Data Language (L<PDL>).

By default, Test::PDL exports only one function: is_pdl(). The other functions
are exported on demand only. The export tag C<:deep> exports test_pdl() and one
function for each PDL type constructor (like short(), double(), etc.), prefixed
with C<test_>: test_short(), test_double(), ...

=head1 VARIABLES

=head2 %OPTIONS

The comparison criteria used by Test::PDL can be configured by setting the
values in the %OPTIONS hash. This can be done directly, by addressing
%Test::PDL::OPTIONS directly. However, it is preferred that set_options() is
used instead.

=over 4

=item TOLERANCE

The tolerance used to compare floating-point values. Initially set to 1e-6.
This is currently an absolute tolerance, meaning that two values compare equal
if the absolute value of their difference is below the tolerance.

=item EQUAL_TYPES

If true, only ndarrays with equal type can be considered equal. If false, the
types of the ndarrays being compared is not taken into consideration. Defaults
to true: types must match for the comparison to succeed. If you want to
write tests like

	is_pdl( $got, pdl([ 1, 3, 5, 6 ]) );

without having to worry about the type of the ndarray being exactly I<double>
(which is the default type of the pdl() constructor), set EQUAL_TYPES equal to
0.

=back

=head1 FUNCTIONS

=head2 import

Custom importer that recognizes configuration options specified at use time, as
in

	use Test::PDL -equal_types => 0;

This invocation is equivalent to

	use Test::PDL;
	Test::PDL::set_options( EQUAL_TYPES => 0 );

but is arguably somewhat nicer.

=head2 _approx

Internal function reimplementing the functionality of PDL::approx(), but with a
tolerance that is not remembered across invocations. Rather, the tolerance can
be set by the user (see set_options() and $OPTIONS{TOLERANCE}), and defaults to
1e-6.

=head2 _comparison_fails

Internal function which does the real work of comparing two ndarrays. If the
comparison fails, _comparison_fails() returns a string containing the reason for
failure. If the comparison succeeds, _comparison_fails() returns zero.

The criteria for equality are the following:

=over 4

=item *

Both arguments must be ndarrays for the comparison to succeed. Currently, there
is no implicit conversion from scalar to ndarray.

=item *

The type of both ndarrays must be equal if (and only if) EQUAL_TYPES is true.

=item *

The number of dimensions must be equal. That is, a two-dimensional ndarray only
compares equal with another two-dimensional ndarray.

=item *

The extent of the dimensions are compared one by one and must match. That is, a
ndarray with dimensions (5,4) cannot compare equal with a ndarray of dimensions
(5,3). Note that degenerate dimensions are not treated specially, and thus a
ndarray with dimensions (5,4,1) is considered different from a ndarray with
dimensions (5,4).

=item *

For ndarrays that conform in type and shape, the bad value pattern is examined.
If the two ndarrays have bad values in different positions, the ndarrays are
considered different. Note that two ndarrays may compare equal even though their
bad flag is different, if there are no bad values.

=item *

And last but not least, the values themselves are examined one by one. For
integer types, the comparison is performed exactly, whereas an approximate
equality is used for floating-point types. The approximate comparison is
implemented using a private reimplementation of PDL::approx(). See _approx()
for more information.

=back

=head2 _dimensions_match

Internal function which compares the extent of each of the dimensions of two
ndarrays, one by one. The dimensions must be passed in as two array references.
Returns 1 if all dimensions match pairwise. Returns 0 otherwise.

This function will not operate correctly if the number of dimensions does not
match between the ndarrays, so be sure to check that before calling this
function.

=head2 is_pdl

=for ref # PDL

Run a test comparing a ndarray to an expected ndarray, and fail with detailed
diagnostics if they don't compare equal.

=for usage # PDL

	is_pdl( $got, $expected, $test_name );

Yields ok if the first two arguments are ndarrays that compare equal, not ok if
the ndarrays are different, or if at least one is not a ndarray. Prints a
diagnostic when the comparison fails, with the reason and a brief printout of
both arguments. See the documentation of _comparison_fails() for the comparison
criteria. $test_name is optional.

Named after is() from L<Test::More>.

=head2 eq_pdl

=for ref # PDL

Return true if two ndarrays compare equal, false otherwise.

=for usage # PDL

	my $equal = eq_pdl( $got, $expected );

eq_pdl() contains just the comparison part of is_pdl(), without the
infrastructure required to write tests with Test::More. It could be used as
part of a larger test in which the equality of two ndarrays must be verified. By
itself, eq_pdl() does not generate any output, so it should be safe to use
outside test suites.

=head2 eq_pdl_diag

=for ref # PDL

Return true if two ndarrays compare equal, false otherwise, and the reason why
the comparison failed (if it did).

=for usage # PDL

	my( $ok ) = eq_pdl_diag( $got, $expected );
	my( $ok, $diag ) = eq_pdl_diag( $got, $expected );

eq_pdl_diag() is like eq_pdl(), except that it also returns the reason why the
comparison failed (if it failed). $diag will be false if the comparison
succeeds. Does not need L<Test::Builder>, so you can use it as part of
something else, without side effects (like generating output). It was written
to support deep comparisons with L<Test::Deep>.

=head2 test_pdl

=for ref # PDL

Special comparison to be used in conjunction with L<Test::Deep> to test ndarrays
inside data structures.

=for usage # PDL

	my $expected = { ..., some_field => test_pdl( 1,2,-7 ), ... };
	my $expected = [ ..., test_short( 1,2,-7 ), ... ];

Suppose you want to compare data structures that happen to contain ndarrays. You
use is_deeply() (from L<Test::More>) or cmp_deeply() (from L<Test::Deep>) to
compare the structures element by element. Unfortunately, you cannot just write

	my $got = my_sub( ... );
	my $expected = {
		...,
		some_field => pdl( ... ),
		...
	};
	is_deeply $got, $expected;

Neither does cmp_deeply() work in the same situation. is_deeply() tries to
compare the ndarrays using the (overloaded) C<==> comparison operator, which
doesn't work. It simply dies with an error message saying that multidimensional
ndarrays cannot be compared, whereas cmp_deeply() performs only a shallow
comparison of the references.

What you need is a special comparison, which is provided by this function, to
be used with cmp_deeply(). You need to rewrite $expected as follows

	my $expected = {
		...,
		some_field => test_pdl( ... ),
		...
	};
	cmp_deeply $got, $expected;

Note that you need to write test_pdl() instead of pdl(). You could achieve the
same thing with

	my $expected = {
		...,
		some_field => code( sub { eq_pdl_diag( shift, pdl( ... ) ) } ),
		...
	};

but the diagnostics provided by test_pdl() are better, and it's easier to use.
test_pdl() accepts the same arguments as the PDL constructor pdl() does. If you
need to compare a ndarray with a type different from the default type, use one
of the provided test_byte(), test_short(), test_long(), etc.:

	my $expected = { data => test_short( -4,-9,13 ) };

If you need to manipulate the expected value, you should keep in mind that the
return value of test_pdl() and the like are not ndarrays. Therefore, in-place
modification of the expected value won't work:

	my $expected = { data => test_short( -99,-9,13 )->inplace->setvaltobad( -99 ) }; # won't work!

You should rather do

	my $expected = { data => test_pdl( short(-99,-9,13)->inplace->setvaltobad(-99) ) };

test_pdl() will correctly set the type of the expected value to I<short> in the
above example.

=for Pod::Coverage test_anyval test_byte test_short test_ushort test_long
test_indx test_longlong test_float test_double test_cfloat test_cdouble
test_cldouble test_ldouble test_sbyte test_ulong test_ulonglong

=head2 set_options

=for ref # PDL

Configure the comparison carried out by Test::PDL's testing functions.

=for example # PDL

	# e.g., if a tolerance of 1e-6 is too tight
	Test::PDL::set_options( TOLERANCE => 1e-4 );

The preferred way to set the options to this module. See %OPTIONS for all
allowed options. set_options() dies with an error if an unknown option is
passed. Note that sensible default values are provided for all options, so you
needn't use this routine if you are fine with the defaults.

This function is not exported. Rather, it must be called as

	Test::PDL::set_options( KEY => VALUE, ... );

=head1 BUGS

None reported so far.

=head1 SEE ALSO

L<PDL>, L<Test::More>, L<Test::Deep>, L<Test::PDL::Deep>

=head1 ACKNOWLEDGMENTS

Thanks to PDL Porters Joel Berger, Chris Marshall, and David Mertens for
feedback and improvements.

=head1 AUTHOR

Edward Baudrez <ebaudrez@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2022 by Edward Baudrez.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
