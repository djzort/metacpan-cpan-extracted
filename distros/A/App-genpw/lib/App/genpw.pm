package App::genpw;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2020-05-22'; # DATE
our $DIST = 'App-genpw'; # DIST
our $VERSION = '0.011'; # VERSION

use 5.010001;
use strict;
use warnings;

# TODO: random shuffling/picking of words from wordlist is not cryptographically
# secure yet
use Random::Any 'rand', -warn => 1;

our %SPEC;

my $symbols            = [split //, q(~`!@#$%^&*()_-+={}[]|\\:;"'<>,.?/)];                          # %s
my $letters            = ["A".."Z","a".."z"];                                                       # %l
my $digits             = ["0".."9"];                                                                # %d
my $hexdigits          = ["0".."9","a".."f"];                                                       # %h
my $letterdigits       = [@$letters, @$digits];                                                     # %a
my $letterdigitsymbols = [@$letterdigits, @$symbols];                                               # %x
my $base64characters   = ["A".."Z","a".."z","0".."9","+","/"];                                      # %m
my $base58characters   = [split //, q(ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz123456789)]; # %b
my $base56characters   = [split //, q(ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789)];   # %B

our %arg_action = (
    action => {
        schema => ['str*', in=>[qw/gen list-patterns/]],
        default => 'gen',
        cmdline_aliases => {
            list_patterns => {summary=>'Shortcut for --action=list-patterns', is_flag=>1, code=>sub { $_[0]{action} = 'list-patterns' }},
        },
    },
);

our %arg_patterns = (
    patterns => {
        'x.name.is_plural' => 1,
        'x.name.singular' => 'pattern',
        summary => 'Pattern(s) to use',
        schema => ['array*', of=>'str*', min_len=>1],
        description => <<'_',

A pattern is string that is similar to a printf pattern. %P (where P is certain
letter signifying a format) will be replaced with some other string. %Nw (where
N is a number) will be replaced by a word of length N, %N$MP (where N and M is a
number) will be replaced by a word of length between N and M. Anything else will
be used as-is. Available conversions:

    %l   Random Latin letter (A-Z, a-z)
    %d   Random digit (0-9)
    %h   Random hexdigit (0-9a-f)
    %a   Random letter/digit (Alphanum) (A-Z, a-z, 0-9; combination of %l and %d)
    %s   Random ASCII symbol, e.g. "-" (dash), "_" (underscore), etc.
    %x   Random letter/digit/ASCII symbol (combination of %a and %s)
    %m   Base64 character (A-Z, a-z, 0-9, +, /)
    %b   Base58 character (A-Z, a-z, 0-9 minus IOl0)
    %B   Base56 character (A-Z, a-z, 0-9 minus IOol01)
    %%   A literal percent sign
    %w   Random word

_
        cmdline_aliases => {p=>{}},
    },
);

sub _fill_conversion {
    my ($matches, $words, $wl) = @_;

    my $n = $matches->{N};
    my $m = $matches->{M};
    my $len = defined($n) && defined($m) ? $n+int(rand()*($m-$n+1)) :
        defined($n) ? $n : 1;

    if ($matches->{CONV} eq '%') {
        return join("", map {'%'} 1..$len);
    } elsif ($matches->{CONV} eq 'd') {
        return join("", map {$digits->[rand(@$digits)]} 1..$len);
    } elsif ($matches->{CONV} eq 'h') {
        return join("", map {$hexdigits->[rand(@$hexdigits)]} 1..$len);
    } elsif ($matches->{CONV} eq 'l') {
        return join("", map {$letters->[rand(@$letters)]} 1..$len);
    } elsif ($matches->{CONV} eq 'a') {
        return join("", map {$letterdigits->[rand(@$letterdigits)]} 1..$len);
    } elsif ($matches->{CONV} eq 's') {
        return join("", map {$symbols->[rand(@$symbols)]} 1..$len);
    } elsif ($matches->{CONV} eq 'x') {
        return join("", map {$letterdigitsymbols->[rand(@$letterdigitsymbols)]} 1..$len);
    } elsif ($matches->{CONV} eq 'm') {
        return join("", map {$base64characters->[rand(@$base64characters)]} 1..$len);
    } elsif ($matches->{CONV} eq 'b') {
        return join("", map {$base58characters->[rand(@$base58characters)]} 1..$len);
    } elsif ($matches->{CONV} eq 'B') {
        return join("", map {$base56characters->[rand(@$base56characters)]} 1..$len);
    } elsif ($matches->{CONV} eq 'w') {
       my $word;
        my $iter = 0;
        while (1) {
            if ($words) {
                @$words or die "Ran out of wordse (please use a longer wordlist or set a lower -n";
                $word = shift @$words;
            } elsif ($wl) {
                ($word) = $wl->pick(1, "allow duplicates");
            } else {
                die "No supply of words for conversion '$matches->{all}'";
            }

            # repeat picking if word does not fulfill requirement (e.g. length)
            next if defined $n && length $word < $n;
            next if defined $m && length $word > $m;
            do { undef $word; last } if $iter++ > 1000;
            last;
        }
        die "Couldn't find suitable random words for conversion '$matches->{all}'"
            unless defined $word;
        return $word;
    }
}

sub _set_case {
    my ($str, $case) = @_;
    if ($case eq 'upper') {
        return uc($str);
    } elsif ($case eq 'lower') {
        return lc($str);
    } elsif ($case eq 'title') {
        return ucfirst(lc($str));
    } elsif ($case eq 'random') {
        return join("", map { rand() < 0.5 ? uc($_) : lc($_) } split(//, $str));
    } else {
        return $str;
    }
}

our $re = qr/(?<all>%(?:(?<N>\d+)(?:\$(?<M>\d+))?)?(?<CONV>[abBdhlmswx%]))/;

sub _fill_pattern {
    my ($pattern, $words, $wl) = @_;

    $pattern =~ s/$re/_fill_conversion({%+}, $words, $wl)/eg;

    $pattern;
}

sub _pattern_has_w_conversion {
    my ($pattern) = @_;
    my $res;
    $pattern =~ s/$re/if ($+{CONV} eq 'w') { $res = 1 }/eg;
    $res;
}

$SPEC{genpw} = {
    v => 1.1,
    summary => 'Generate random password, with patterns and wordlists',
    description => <<'_',

This is yet another utility to generate random password. Features:

* Allow specifying pattern(s), e.g. '%8a%s' means 8 random alphanumeric
  characters followed by a symbol.
* Use words from wordlists.
* Use strong random source when available, otherwise fallback to Perl's builtin
  `rand()`.

Examples:

By default generate base56 password 12-20 characters long (-p %12$20B):

    % genpw
    Uk7Zim6pZeMTZQUyaM

Generate 5 passwords instead of 1:

    % genpw 5
    igYiRhUb5t9d9f3J
    b7D44pnxZHJGQzDy2eg
    RXDtqjMvp2hNAdQ
    Xz3DmAL94akqtZ5xb
    7TfANv9yxAaMGXm

Generate random digits between 10 and 12 characters long:

    % genpw -p '%10$12d'
    55597085674

Generate password in the form of a random word + 4 random digits. Words will be
fed from STDIN:

    % genpw -p '%w%4d' < /usr/share/dict/words
    shafted0412

Like the above, but words will be fetched from `WordList::*` modules. You need
to install the <prog:genpw-wordlist> CLI. By default, will use wordlist from
<pm:WordList::EN::Enable>:

    % genpw-wordlist -p '%w%4d'
    sedimentologists8542

Generate a random GUID:

    % genpw -p '%8h-%4h-%4h-%4h-%12h'
    ff26d142-37a8-ecdf-c7f6-8b6ae7b27695

Like the above, but in uppercase:

    % genpw -p '%8h-%4h-%4h-%4h-%12h' -U
    22E13D9E-1187-CD95-1D05-2B92A09E740D

Use configuration file to avoid typing the pattern every time, put this in
`~/genpw.conf`:

    [profile=guid]
    patterns = "%8h-%4h-%4h-%4h-%12h"

then:

    % genpw -P guid
    008869fa-177e-3a46-24d6-0900a00e56d5

_
    args => {
        %arg_action,
        num => {
            schema => ['int*', min=>1],
            default => 1,
            cmdline_aliases => {n=>{}},
            pos => 0,
        },
        %arg_patterns,
        min_len => {
            summary => 'If no pattern is supplied, will generate random '.
                'alphanum characters with this minimum length',
            schema => 'posint*',
        },
        max_len => {
            summary => 'If no pattern is supplied, will generate random '.
                'alphanum characters with this maximum length',
            schema => 'posint*',
        },
        len => {
            summary => 'If no pattern is supplied, will generate random '.
                'alphanum characters with this exact length',
            schema => 'posint*',
            cmdline_aliases => {l=>{}},
        },
        case => {
            summary => 'Force casing',
            schema => ['str*', in=>['default','random','lower','upper','title']],
            default => 'default',
            description => <<'_',

`default` means to not change case. `random` changes casing some letters
randomly to lower-/uppercase. `lower` forces lower case. `upper` forces
UPPER CASE. `title` forces Title case.

_
            cmdline_aliases => {
                U => {is_flag=>1, summary=>'Shortcut for --case=upper', code=>sub {$_[0]{case} = 'upper'}},
                L => {is_flag=>1, summary=>'Shortcut for --case=lower', code=>sub {$_[0]{case} = 'lower'}},
            },
        },
    },
    examples => [
    ],
    links => [
        {url=>'prog:genpw-base56'},
        {url=>'prog:genpw-base64'},
        {url=>'prog:genpw-id'},
        {url=>'prog:genpw-wordlist'},
    ],
};
sub genpw {
    my %args = @_;

    my $action = $args{action} // 'gen';
    my $num = $args{num} // 1;
    my $min_len = $args{min_len} // $args{len} // 12;
    my $max_len = $args{max_len} // $args{len} // 20;
    my $patterns = $args{patterns} // ["%$min_len\$${max_len}B"];
    my $case = $args{case} // 'default';

    if ($action eq 'list-patterns') {
        return [200, "OK", $patterns];
    }

  GET_WORDS_FROM_STDIN:
    {
        last if defined $args{_words} || defined $args{_wl};
        my $has_w;
        for (@$patterns) {
            if (_pattern_has_w_conversion($_)) { $has_w++; last }
        }
        last unless $has_w;
        require List::Util;
        $args{_words} = [List::Util::shuffle(<STDIN>)];
        chomp for @{ $args{_words} };
    }

    my @passwords;
    for my $i (1..$num) {
            my $password =
                _fill_pattern($patterns->[rand @$patterns], $args{_words}, $args{_wl});
            $password = _set_case($password, $case);
        push @passwords, $password;
    }

    [200, "OK", \@passwords];
}

1;
# ABSTRACT: Generate random password, with patterns and wordlists

__END__

=pod

=encoding UTF-8

=head1 NAME

App::genpw - Generate random password, with patterns and wordlists

=head1 VERSION

This document describes version 0.011 of App::genpw (from Perl distribution App-genpw), released on 2020-05-22.

=head1 SYNOPSIS

See the included script L<genpw>.

=head1 FUNCTIONS


=head2 genpw

Usage:

 genpw(%args) -> [status, msg, payload, meta]

Generate random password, with patterns and wordlists.

This is yet another utility to generate random password. Features:

=over

=item * Allow specifying pattern(s), e.g. '%8a%s' means 8 random alphanumeric
characters followed by a symbol.

=item * Use words from wordlists.

=item * Use strong random source when available, otherwise fallback to Perl's builtin
C<rand()>.

=back

Examples:

By default generate base56 password 12-20 characters long (-p %12$20B):

 % genpw
 Uk7Zim6pZeMTZQUyaM

Generate 5 passwords instead of 1:

 % genpw 5
 igYiRhUb5t9d9f3J
 b7D44pnxZHJGQzDy2eg
 RXDtqjMvp2hNAdQ
 Xz3DmAL94akqtZ5xb
 7TfANv9yxAaMGXm

Generate random digits between 10 and 12 characters long:

 % genpw -p '%10$12d'
 55597085674

Generate password in the form of a random word + 4 random digits. Words will be
fed from STDIN:

 % genpw -p '%w%4d' < /usr/share/dict/words
 shafted0412

Like the above, but words will be fetched from C<WordList::*> modules. You need
to install the L<genpw-wordlist> CLI. By default, will use wordlist from
L<WordList::EN::Enable>:

 % genpw-wordlist -p '%w%4d'
 sedimentologists8542

Generate a random GUID:

 % genpw -p '%8h-%4h-%4h-%4h-%12h'
 ff26d142-37a8-ecdf-c7f6-8b6ae7b27695

Like the above, but in uppercase:

 % genpw -p '%8h-%4h-%4h-%4h-%12h' -U
 22E13D9E-1187-CD95-1D05-2B92A09E740D

Use configuration file to avoid typing the pattern every time, put this in
C<~/genpw.conf>:

 [profile=guid]
 patterns = "%8h-%4h-%4h-%4h-%12h"

then:

 % genpw -P guid
 008869fa-177e-3a46-24d6-0900a00e56d5

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<action> => I<str> (default: "gen")

=item * B<case> => I<str> (default: "default")

Force casing.

C<default> means to not change case. C<random> changes casing some letters
randomly to lower-/uppercase. C<lower> forces lower case. C<upper> forces
UPPER CASE. C<title> forces Title case.

=item * B<len> => I<posint>

If no pattern is supplied, will generate random alphanum characters with this exact length.

=item * B<max_len> => I<posint>

If no pattern is supplied, will generate random alphanum characters with this maximum length.

=item * B<min_len> => I<posint>

If no pattern is supplied, will generate random alphanum characters with this minimum length.

=item * B<num> => I<int> (default: 1)

=item * B<patterns> => I<array[str]>

Pattern(s) to use.

A pattern is string that is similar to a printf pattern. %P (where P is certain
letter signifying a format) will be replaced with some other string. %Nw (where
N is a number) will be replaced by a word of length N, %N$MP (where N and M is a
number) will be replaced by a word of length between N and M. Anything else will
be used as-is. Available conversions:

 %l   Random Latin letter (A-Z, a-z)
 %d   Random digit (0-9)
 %h   Random hexdigit (0-9a-f)
 %a   Random letter/digit (Alphanum) (A-Z, a-z, 0-9; combination of %l and %d)
 %s   Random ASCII symbol, e.g. "-" (dash), "_" (underscore), etc.
 %x   Random letter/digit/ASCII symbol (combination of %a and %s)
 %m   Base64 character (A-Z, a-z, 0-9, +, /)
 %b   Base58 character (A-Z, a-z, 0-9 minus IOl0)
 %B   Base56 character (A-Z, a-z, 0-9 minus IOol01)
 %%   A literal percent sign
 %w   Random word


=back

Returns an enveloped result (an array).

First element (status) is an integer containing HTTP status code
(200 means OK, 4xx caller error, 5xx function error). Second element
(msg) is a string containing error message, or 'OK' if status is
200. Third element (payload) is optional, the actual result. Fourth
element (meta) is called result metadata and is optional, a hash
that contains extra information.

Return value:  (any)

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/App-genpw>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-App-genpw>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-genpw>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2020, 2018 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
