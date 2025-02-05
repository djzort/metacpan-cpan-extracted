package CXC::Exporter::Util;

# ABSTRACT: Tagged Based Exporting

use strict;
use warnings;

our $VERSION = '0.01';

use Scalar::Util 'reftype';
use List::Util 1.45 'uniqstr';
use experimental 'signatures', 'postderef';

use Exporter 'import';

our %EXPORT_TAGS = (
    default   => [qw( install_EXPORTS  )],
    constants => [qw( install_CONSTANTS )],
    utils     => [qw( install_constant_tag install_constant_func )],
);

install_EXPORTS();

sub _croak {
    require Carp;
    goto \&Carp::croak;
}

sub _EXPORT_TAGS ( $caller = scalar caller ) {
    no strict 'refs';    ## no critic
    *${ \"${caller}::EXPORT_TAGS" }{HASH} // \%{ *${ \"${caller}::EXPORT_TAGS" } = {} };
}

sub _EXPORT_OK ( $caller = scalar caller ) {
    no strict 'refs';    ## no critic
    *${ \"${caller}::EXPORT_OK" }{ARRAY} // \@{ *${ \"${caller}::EXPORT_OK" } = [] };
}

sub _EXPORT ( $caller = scalar caller ) {
    no strict 'refs';    ## no critic
    *${ \"${caller}::EXPORT" }{ARRAY} // \@{ *${ \"${caller}::EXPORT" } = [] };
}




























sub install_EXPORTS {

    my $export_tags = ( reftype( $_[0] ) // '' ) eq 'HASH' ? shift : undef;
    my $caller      = shift // scalar caller;
    _croak( "too many arguments to INSTALL_EXPORTS" ) if @_;

    my $EXPORT_TAGS = _EXPORT_TAGS( $caller );

    $EXPORT_TAGS->%* = $export_tags->%*
      if defined $export_tags;

    # Assign the all tag in two steps to avoid the situation
    # where $EXPORT_TAGS->{all} is created with an undefined value
    # before running values on $EXPORT_TAGS->%*;
    my @all = map { $_->@* } values $EXPORT_TAGS->%*;
    $EXPORT_TAGS->{all} //= \@all;

    _EXPORT( $caller )->@*    = ( $EXPORT_TAGS->{default} // [] )->@*;
    _EXPORT_OK( $caller )->@* = uniqstr map { $_->@* } values $EXPORT_TAGS->%*;

}







































































sub install_CONSTANTS ( $constants, $caller = scalar caller ) {
    install_constant_tag( $_, $constants->{$_}, $caller ) for keys $constants->%*;
}












































































sub install_constant_tag ( $tag, $constants, $caller = scalar caller ) {

    my ( @names, @values );
    if ( reftype( $constants ) eq 'HASH' ) {
        @names  = keys $constants->%*;
        @values = values $constants->%*;
    }
    else {
        my @constants = $constants->@*;
        $constants = { @constants };
        while ( @constants ) {
            push @names,  shift @constants;
            push @values, shift @constants;
        }
    }

    constant->import::into( $caller, $constants );
    _EXPORT_TAGS( $caller )->{ lc $tag } = \@names;
    install_constant_func( $tag . 'S', \@values, $caller );
}












































sub install_constant_func ( $tag, $values, $caller = scalar caller ) {
    constant->import::into( $caller, $tag => $values->@* );
    push( ( _EXPORT_TAGS( $caller )->{constants_funcs} //= [] )->@*, $tag );
}


1;

#
# This file is part of CXC-Exporter-Util
#
# This software is Copyright (c) 2022 by Smithsonian Astrophysical Observatory.
#
# This is free software, licensed under:
#
#   The GNU General Public License, Version 3, June 2007
#

__END__

=pod

=for :stopwords Diab Jerius Smithsonian Astrophysical Observatory

=head1 NAME

CXC::Exporter::Util - Tagged Based Exporting

=head1 VERSION

version 0.01

=head1 SYNOPSIS

  package My::Constants;
  use CXC::Exporter::Util ':all';

  install_CONSTANTS( {
        DETECTOR => {
            ACIS => 'ACIS',
            HRC  => 'HRC',
        },

        AGGREGATE => {
            ALL  => 'all',
            NONE => 'none',
            ANY  => 'any',
        },
    } );

  install_EXPORTS;

  # in an importer;

  # import ACIS & HRC constants, and DETECTORS function
  use My::Constants '-detector', 'DETECTORS';

  # print the DETECTOR constants' values;
  say $_ for DETECTORS;

=head1 DESCRIPTION

C<CXC::Exporter::Util> provides tag-centric utilities for
modules which export symbols.

In this approach, C<%EXPORT_TAGS> is the definitive source for
information about exportable symbols and is used to generate both
C<@EXPORT_OK> and C<@EXPORT>.  Consolidation of symbol information in
one place avoids errors of omission.

The standard export interface provided by Perl's core L<Exporter> (and
emulated by others such as L<Exporter::Tiny>) uses three structures in
the exporting module's namespace:

=over

=item @EXPORT

Symbols in this array are automatically exported.

=item @EXPORT_OK

Symbols in this array are available for export.

=item %EXPORT_TAGS

This hash associates sets of symbols with tags. L<Exporter> allows the
importing module to import a set of symbols by specifying
a set's tag rather than each of the symbols individually.

=back

=head2 Standard Usage

At it simplest, the exporting module calls L</install_EXPORTS> with a hash:

  package My::ExportingModule;
  use CXC::Exporter::Util;

  use parent 'Exporter';

  install_EXPORTS( { tag => [ 'Symbol1', 'Symbol2' ] } );

For more complicated setups, C<%EXPORT_TAGS> may be specified first:

  package My::ExportingModule;
  use CXC::Exporter::Util;

  use parent 'Exporter';
  our %EXPORT_TAGS = ( tag => [ 'Symbol1', 'Symbol2' ] );
  install_EXPORTS;

=head2 Handling Constant values

L<CXC::Exporter::Util> provides additional support for creating,
organizing and installing constants via L</install_CONSTANTS>.
Constants are created via Perl's L<constant> pragma.

L</install_CONSTANTS> is passed a hash containing sets of constants
grouped by tags, e.g.:

  install_CONSTANTS( {
        DETECTOR => {
            ACIS => 'ACIS',
            HRC  => 'HRC',
        },

        AGGREGATE => {
            ALL  => 'all',
            NONE => 'none',
            ANY  => 'any',
        },
   });
   install_EXPORTS;

In addition to the constants, it generates constant functions which
return all of the constant values in each set.

For the above example, it creates constants C<ACIS>, C<HRC>, C<ALL>,
C<NONE>, C<ANY>, and constant functions C<DETECTORS> and C<AGGREGATES>
(note the trailing upper-case C<S>).  The latter are useful for generating
enumerated types via e.g. L<Type::Tiny>:

  Enum( DETECTORS )

or iterating:

  say $_ for DETECTORS;

The top level keys (C<DETECTOR>, C<AGGREGATE>) are transformed into
tags by lower casing them, e.g.

  $EXPORT_TAGS{detector} = [ qw( ACIS HRC ) ];
  $EXPORT_TAGS{aggregate} = [ qw( ALL NONE ANY ) ];

The constant functions are assigned the C<constant_funcs> tag, e.g.

  $EXPORT_TAGS{constant_funcs} = [ qw( DETECTORS AGGREGATES ) ];

If the constants are used later in the module for other purposes, constant definition
should be done in a L<BEGIN> block:

  BEGIN { install_CONSTANTS( \%CONSTANTS ) }

For more complex situations, the lower level L</install_constant_tag>
and L</install_constant_func> routines may be useful.

=head1 SUBROUTINES

=head2 install_EXPORTS

  install_EXPORT( [\%export_tags], [$package],   );

Populate C<$package>'s C<@EXPORT> and C<@EXPORT_OK> arrays based upon
C<%export_tags>. C<$package> defaults to the caller's package.

If not specified, C<%export_tags> defaults to C<%EXPORT_TAGS> in C<$package>.
If specified, the contents of C<%export_tags> will overwrite C<%EXPORT_TAGS>;

This routine does the following in C<$package>, which defaults to the
caller's package.

=over

=item *

Install the symbols specified via the C<default> tag into C<$package>'s C<@EXPORT>.

=item *

Install all of the symbols in C<%EXPORT_TAGS> into C<@EXPORT_OK>.

=back

=head2 install_CONSTANTS

  install_CONSTANTS( \%hash, [$package]  );

Create constants from a nested hash of constants names and values and
make them available for export.

C<%hash> should be a two level nested structure.  The keys in the top
level are tag names, the second level structures are either hashes or
arrays ( of I<name-value> pairs )and contain the constant names and
values, e.g.

     %hash = (
        DETECTOR => {
            ACIS => 'ACIS',
            HRC  => 'HRC',
        },

        AGGREGATE => {
            ALL  => 'all',
            NONE => 'none',
            ANY  => 'any',
        },
     );

This routine does the following in C<$package>, which defaults to the
caller's package.

=over

=item 1

Create constants for each of the entries in the inner hashes, and
add tags to C<%EXPORT_TAGS> for them.

=item 2

Create constant functions for each of the inner hashes which return
the hash values, and add them to the export tag C<constant_funcs>
in C<%EXPORT_TAGS>

=back

For example, given the above value for C<%hash>,

=over

=item *

constants C<ACIS>, and C<HRC> will be created and assigned the export
tag C<detector>.

=item *

constants C<ALL>, C<NONE>, and C<ANY> will be created and assigned
the export tag C<aggregate>.

=item *

Constant functions C<DETECTORS> and C<AGGREGATES> will be created
and assigned to the C<constant_funcs> export tag.

=back

L<install_EXPORTS> uses L</install_constant_tag> to install the individual
tagged sets.

=head2 install_constant_tag( $tag, $constants, [$package] )

C<$constants> may be either a hashref or an arrayref ( composed of I<name-value> pairs ).
Specifying constant names and their values, e.g.

    (
            NAME1     => VALUE1,
            NAME2     => VALUE2,
   );

This routine does the following in C<$package>, which defaults to the
caller's package.

=over

=item 1

installs the constants in C<$package>,

=item 2

installs a constant function C<${tag}S> which returns the constant
values

=item 3

adds the constant names to C<%EXPORT_TAGS> with the
lower-cased tag C<$tag>

=item 4

adds C<${tag}S> in the C<$EXPORT_TAGS{contant_funcs}> tag.

=back

For example, after

  install_constant_tag( 'AGGREGATE',
                        { ALL => 'all', NONE => 'none', ANY => 'any' } );

=over

=item 1

The constants, C<ALL>, C<NONE>, C<ANY> will be created.

=item 2

The function C<AGGREGATES> will return C<all>, C<none>, C<any>.

=item 3

A package importing from C<$package> can import the constants
C<ALL>, C<NONE>, C<ANY> via the C<aggregate> tag:

   use Package ':aggregate';

=item 4

A package importing from C<$package> can import the C<AGGREGATE>
constant function via the C<constant_funcs> tag:

  use Package ':constant_funcs';

or directly

  use Package 'AGGREGATES';

=back

L<install_constant_tag> uses L</install_constant_func> to create and install
the constant functions which return the constant values.

=head2 install_constant_func( $name, \@values )

This routine does the following in C<$package>, which defaults to the
caller's package.

=over

=item 1

Create a constant subroutine named C<$name> which returns C<@values>;

=item 2

Adds C<$name> to the C<constant_funcs> tag in C<%EXPORT_TAGS>.

=back

For example, after calling

  install_constant_func( 'AGGREGATE', [ 'all', 'none', 'any' ]  );

=over

=item 1

The function C<AGGREGATES> will return C<all>, C<none>, C<any>.

=item 2

A package importing from C<$package> can import the C<AGGREGATE>
constant function via the C<constant_funcs> tag:

  use Package ':constant_funcs';

or directly

  use Package 'AGGREGATES';

=back

=head1 SUPPORT

=head2 Bugs

Please report any bugs or feature requests to bug-cxc-exporter-tagged@rt.cpan.org  or through the web interface at: https://rt.cpan.org/Public/Dist/Display.html?Name=CXC-Exporter-Util

=head2 Source

Source is available at

  https://gitlab.com/djerius/cxc-exporter-tagged

and may be cloned from

  https://gitlab.com/djerius/cxc-exporter-tagged.git

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<Exporter|Exporter>

=back

=head1 AUTHOR

Diab Jerius <djerius@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2022 by Smithsonian Astrophysical Observatory.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
