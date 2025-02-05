#!perl -T
use Test::More;
use Test::Exception;
use ok( 'Locale::CLDR' );
my $locale;

diag( "Testing Locale::CLDR v0.34.1, Perl $], $^X" );
use ok Locale::CLDR::Locales::Tg, 'Can use locale file Locale::CLDR::Locales::Tg';
use ok Locale::CLDR::Locales::Tg::Any::Tj, 'Can use locale file Locale::CLDR::Locales::Tg::Any::Tj';
use ok Locale::CLDR::Locales::Tg::Any, 'Can use locale file Locale::CLDR::Locales::Tg::Any';

done_testing();
