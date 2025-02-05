#!perl -T
use Test::More;
use Test::Exception;
use ok( 'Locale::CLDR' );
my $locale;

diag( "Testing Locale::CLDR v0.34.1, Perl $], $^X" );
use ok Locale::CLDR::Locales::Bo, 'Can use locale file Locale::CLDR::Locales::Bo';
use ok Locale::CLDR::Locales::Bo::Any::In, 'Can use locale file Locale::CLDR::Locales::Bo::Any::In';
use ok Locale::CLDR::Locales::Bo::Any::Cn, 'Can use locale file Locale::CLDR::Locales::Bo::Any::Cn';
use ok Locale::CLDR::Locales::Bo::Any, 'Can use locale file Locale::CLDR::Locales::Bo::Any';

done_testing();
