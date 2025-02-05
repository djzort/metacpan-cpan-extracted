=encoding utf8

=head1

Locale::CLDR::Locales::Se::Any::Se - Package for language Northern Sami

=cut

package Locale::CLDR::Locales::Se::Any::Se;
# This file auto generated from Data/common/main/se_SE.xml
#	on Mon 11 Apr  5:37:35 pm GMT

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

extends('Locale::CLDR::Locales::Se::Any');
has 'currencies' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'NOK' => {
			symbol => 'Nkr',
		},
		'SEK' => {
			symbol => 'kr',
		},
	} },
);


no Moo;

1;

# vim: tabstop=4
