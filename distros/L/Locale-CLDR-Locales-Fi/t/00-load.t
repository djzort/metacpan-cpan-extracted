#!perl -T
use Test::More;
use Test::Exception;
use ok( 'Locale::CLDR' );
my $locale;

diag( "Testing Locale::CLDR v0.34.1, Perl $], $^X" );
use ok Locale::CLDR::Locales::Fi, 'Can use locale file Locale::CLDR::Locales::Fi';
use ok Locale::CLDR::Locales::Fi::Any::Fi, 'Can use locale file Locale::CLDR::Locales::Fi::Any::Fi';
use ok Locale::CLDR::Locales::Fi::Any, 'Can use locale file Locale::CLDR::Locales::Fi::Any';

done_testing();
