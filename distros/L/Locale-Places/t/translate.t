#!perl -wT

use strict;
use warnings;
use Test::Most tests => 21;
use lib 't/lib';
use MyLogger;

BEGIN {
	use_ok('Locale::Places');
}

TRANSLATE: {
	my $places;
	if($ENV{'TEST_VERBOSE'}) {
		$places = new_ok('Locale::Places' => [logger => MyLogger->new()]);
	} else {
		$places = new_ok('Locale::Places');
	}

	like($places->translate(place => 'London', from => 'en', to => 'fr'), qr/Londres$/, 'French for London is Londres');
	like($places->translate(place => 'Londres', from => 'fr', to => 'en'), qr/London$/, 'English for Londres is London');
	is($places->translate({ place => 'London', from => 'en', to => 'en' }), 'London', 'English for London is London');
	is($places->translate({ place => 'foo', from => 'bar' }), undef, 'Translating gibberish returns undef');

	delete $ENV{'LC_MESSAGES'};
	delete $ENV{'LC_ALL'};
	delete $ENV{'LANG'};

	$ENV{'LANGUAGE'} = 'en';
	is($places->translate({ place => 'Dover', 'from' => 'en' }), 'Dover', 'LANGUAGE set to English');

	delete $ENV{'LANGUAGE'};

	$ENV{'LANG'} = 'fr_FR';
	is($places->translate(place => 'Dover', 'from' => 'en'), 'Douvres', 'Target LANG set to French');

	is($places->translate(place => 'Douvres', 'to' => 'en'), 'Dover', 'Source LANG set to French');
	is($places->translate(place => 'Douvres', 'to' => 'fr'), 'Douvres', 'Source LANG set to French');
	is($places->translate('Dover'), 'Douvres', 'Sets default source as English and a default target from the environment');

	is($places->translate(place => 'Durham', 'from' => 'en', 'to' => 'fr'), 'Durham', 'Durham has different matches');
	is($places->translate(place => 'Bromley', 'from' => 'en', 'to' => 'fr'), 'Bromley', 'Bromley has different matches');
	is($places->translate(place => 'Lewisham', 'from' => 'en', 'to' => 'fr'), 'Lewisham', 'Lewisham has different matches');

	is($places->translate(place => 'Cardiff', 'from' => 'en', 'to' => 'fr'), 'Cardiff', 'unable to find a good match for Cardiff');

	$ENV{'LANG'} = 'en_GB';

	is($places->translate(place => 'Dover', 'to' => 'en'), 'Dover', 'Source LANG set to English');
	is($places->translate(place => 'Dover', 'to' => 'fr'), 'Douvres', 'Source LANG set to English');
	is($places->translate(place => 'Douvres', 'from' => 'fr'), 'Dover', 'Source LANG set to English');
	is($places->translate(place => 'Dover', 'from' => 'en'), 'Dover', 'Source LANG set to English');

	# There is more than one preferred entry for Bexley in London in the database, but they have the same value
	is($places->translate(place => 'Bexley', from => 'en', to => 'fr'), 'Bexley', 'Test for two preferred values that are the same');
	is($places->translate(place => 'Thurrock', to => 'fr'), 'Thurrock', 'Test for two preferred values neither of which matches');
}
