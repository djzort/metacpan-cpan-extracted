package Zonemaster::Backend::Translator;

our $VERSION = '1.1.0';

use 5.14.2;

use Moose;
use Encode;
use Readonly;
use POSIX qw[setlocale LC_MESSAGES LC_CTYPE];
use Locale::TextDomain qw[Zonemaster-Backend];
use Zonemaster::Backend::Config;

# Zonemaster Modules
require Zonemaster::Engine::Translator;
require Zonemaster::Engine::Logger::Entry;

extends 'Zonemaster::Engine::Translator';

Readonly my %TAG_DESCRIPTIONS => (
    UNABLE_TO_FINISH_TEST => sub {
        __x    # BACKEND_TEST_AGENT:UNABLE_TO_FINISH_TEST
          "Zonemaster was unable to start or finish the test.", @_;
    },
);

sub _build_all_tag_descriptions {
    my $all_tag_descriptions = Zonemaster::Engine::Translator::_build_all_tag_descriptions();
    $all_tag_descriptions->{BACKEND_TEST_AGENT} = \%TAG_DESCRIPTIONS;
    return $all_tag_descriptions;
}

sub translate_tag {
    my ( $self, $hashref ) = @_;

    my $entry = Zonemaster::Engine::Logger::Entry->new( { %{ $hashref } } );
    my $octets = Zonemaster::Engine::Translator::translate_tag( $self, $entry );

    return decode_utf8( $octets );
}

sub test_case_description {
    return decode_utf8(Zonemaster::Engine::Translator::test_case_description(@_));
}
1;
