package Sah::Schema::date::dow_num;

use strict;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2022-10-12'; # DATE
our $DIST = 'Sah-Schemas-Date'; # DIST
our $VERSION = '0.018'; # VERSION

our $schema = [int => {
    summary => 'Day-of-week number (1-7, 1=Monday, like DateTime), coercible from English day-of-week name (Mo/mon/MONDAY), e.g. 1 or "Mon"',
    min => 1,
    max => 7,
    'x.perl.coerce_rules' => ['From_str::convert_en_dow_name_to_num'],
    'x.completion' => ['date_dow_num'],
    description => <<'_',

See also related schemas that coerce from other locales, e.g.
<pm:Sah::Schema::date::dow_num::id> (Indonesian),
<pm:Sah::Schema::date::dow_num::en_or_id> (English/Indonesian), etc.

_
    examples => [
        {value=>'', valid=>0, summary=>"Empty string"},
        {value=>0, valid=>0, summary=>"Not in 1-7"},
        {value=>1, valid=>1},
        {value=>"Tue", validated_value=>2, valid=>1},
        {value=>"foo", valid=>0, summary=>'Not a known English day-of-week name'},
        {value=>7, valid=>1},
        {value=>8, valid=>0, summary=>"Not in 1-7"},
    ],
}];

1;

# ABSTRACT: Day-of-week number (1-7, 1=Monday, like DateTime), coercible from English day-of-week name (Mo/mon/MONDAY), e.g. 1 or "Mon"

__END__

=pod

=encoding UTF-8

=head1 NAME

Sah::Schema::date::dow_num - Day-of-week number (1-7, 1=Monday, like DateTime), coercible from English day-of-week name (Mo/mon/MONDAY), e.g. 1 or "Mon"

=head1 VERSION

This document describes version 0.018 of Sah::Schema::date::dow_num (from Perl distribution Sah-Schemas-Date), released on 2022-10-12.

=head1 SYNOPSIS

=head2 Sample data and validation results against this schema

 ""  # INVALID (Empty string)

 0  # INVALID (Not in 1-7)

 1  # valid

 "Tue"  # valid, becomes 2

 "foo"  # INVALID (Not a known English day-of-week name)

 7  # valid

 8  # INVALID (Not in 1-7)

=head2 Using with Data::Sah

To check data against this schema (requires L<Data::Sah>):

 use Data::Sah qw(gen_validator);
 my $validator = gen_validator("date::dow_num*");
 say $validator->($data) ? "valid" : "INVALID!";

The above schema returns a boolean result (true if data is valid, false if
otherwise). To return an error message string instead (empty string if data is
valid, a non-empty error message otherwise):

 my $validator = gen_validator("date::dow_num", {return_type=>'str_errmsg'});
 my $errmsg = $validator->($data);
 
 # a sample valid data
 $data = 7;
 my $errmsg = $validator->($data); # => ""
 
 # a sample invalid data
 $data = "foo";
 my $errmsg = $validator->($data); # => "Not of type integer"

Often a schema has coercion rule or default value, so after validation the
validated value is different. To return the validated (set-as-default, coerced,
prefiltered) value:

 my $validator = gen_validator("date::dow_num", {return_type=>'str_errmsg+val'});
 my $res = $validator->($data); # [$errmsg, $validated_val]
 
 # a sample valid data
 $data = 7;
 my $res = $validator->($data); # => ["",7]
 
 # a sample invalid data
 $data = "foo";
 my $res = $validator->($data); # => ["Not of type integer","foo"]

Data::Sah can also create validator that returns a hash of detailed error
message. Data::Sah can even create validator that targets other language, like
JavaScript, from the same schema. Other things Data::Sah can do: show source
code for validator, generate a validator code with debug comments and/or log
statements, generate human text from schema. See its documentation for more
details.

=head2 Using with Params::Sah

To validate function parameters against this schema (requires L<Params::Sah>):

 use Params::Sah qw(gen_validator);

 sub myfunc {
     my @args = @_;
     state $validator = gen_validator("date::dow_num*");
     $validator->(\@args);
     ...
 }

=head2 Using with Perinci::CmdLine::Lite

To specify schema in L<Rinci> function metadata and use the metadata with
L<Perinci::CmdLine> (L<Perinci::CmdLine::Lite>) to create a CLI:

 # in lib/MyApp.pm
 package
   MyApp;
 our %SPEC;
 $SPEC{myfunc} = {
     v => 1.1,
     summary => 'Routine to do blah ...',
     args => {
         arg1 => {
             summary => 'The blah blah argument',
             schema => ['date::dow_num*'],
         },
         ...
     },
 };
 sub myfunc {
     my %args = @_;
     ...
 }
 1;

 # in myapp.pl
 package
   main;
 use Perinci::CmdLine::Any;
 Perinci::CmdLine::Any->new(url=>'/MyApp/myfunc')->run;

 # in command-line
 % ./myapp.pl --help
 myapp - Routine to do blah ...
 ...

 % ./myapp.pl --version

 % ./myapp.pl --arg1 ...


=head2 Using with Type::Tiny

To create a type constraint and type library from a schema:

 package My::Types {
     use Type::Library -base;
     use Type::FromSah qw( sah2type );

     __PACKAGE__->add_type(
         sah2type('$sch_name*', name=>'DateDowNum')
     );
 }

 use My::Types qw(DateDowNum);
 DateDowNum->assert_valid($data);

=head1 DESCRIPTION

See also related schemas that coerce from other locales, e.g.
L<Sah::Schema::date::dow_num::id> (Indonesian),
L<Sah::Schema::date::dow_num::en_or_id> (English/Indonesian), etc.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Sah-Schemas-Date>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Sah-Schemas-Date>.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 CONTRIBUTING


To contribute, you can send patches by email/via RT, or send pull requests on
GitHub.

Most of the time, you don't need to build the distribution yourself. You can
simply modify the code, then test via:

 % prove -l

If you want to build the distribution (e.g. to try to install it locally on your
system), you can install L<Dist::Zilla>,
L<Dist::Zilla::PluginBundle::Author::PERLANCAR>,
L<Pod::Weaver::PluginBundle::Author::PERLANCAR>, and sometimes one or two other
Dist::Zilla- and/or Pod::Weaver plugins. Any additional steps required beyond
that are considered a bug and can be reported to me.

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2022, 2020, 2019 by perlancar <perlancar@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Sah-Schemas-Date>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=cut
