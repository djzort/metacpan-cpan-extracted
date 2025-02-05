=encoding utf8

=head1

Locale::CLDR::Locales::Bo::Any::In - Package for language Tibetan

=cut

package Locale::CLDR::Locales::Bo::Any::In;
# This file auto generated from Data/common/main/bo_IN.xml
#	on Mon 11 Apr  5:24:34 pm GMT

use strict;
use warnings;
use version;

our $VERSION = version->declare('v0.34.1');

use v5.10.1;
use mro 'c3';
use utf8;
use if $^V ge v5.12.0, feature => 'unicode_strings';
use Types::Standard qw( Str Int HashRef ArrayRef CodeRef RegexpRef );
use Moo;

extends('Locale::CLDR::Locales::Bo::Any');
has 'display_name_region' => (
	is			=> 'ro',
	isa			=> HashRef[Str],
	init_arg	=> undef,
	default		=> sub { 
		{
			'009' => 'ཨོཤི་ཡཱན་ན།',

		}
	},
);

has 'currencies' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'CNY' => {
			symbol => 'CN¥',
		},
	} },
);


no Moo;

1;

# vim: tabstop=4
