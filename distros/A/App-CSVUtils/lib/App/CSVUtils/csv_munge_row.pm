package App::CSVUtils::csv_munge_row;

use 5.010001;
use strict;
use warnings;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2023-01-04'; # DATE
our $DIST = 'App-CSVUtils'; # DIST
our $VERSION = '1.001'; # VERSION

use App::CSVUtils qw(
                        gen_csv_util
                        compile_eval_code
                        eval_code
                );

gen_csv_util(
    name => 'csv_munge_row',
    summary => '',
    description => <<'_',

Perl code (-e) will be called for each row (excluding the header row) and `$_`
will contain the row (arrayref, or hashref if `-H` is specified). The Perl code
is expected to modify it.

Aside from `$_`, `$main::row` will contain the current row array.
`$main::rownum` contains the row number (2 means the first data row).
`$main::csv` is the <pm:Text::CSV_XS> object. `$main::fields_idx` is also
available for additional information.

The modified `$_` will be rendered back to CSV row.

You cannot add new fields using this utility. To do so, use
<prog:csv-add-fields>. You also cannot delete fields (they just become empty
string if you delete the field in the eval code). To delete fields, use
<prog:csv-delete-fields>.

Note that you can also munge a single field using <prog:csv-munge-field>.

_
    add_args => {
        %App::CSVUtils::argspec_eval_1,
        %App::CSVUtils::argspecopt_hash,
    },
    examples => [
        {
            summary => 'Modify two fields in a CSV',
            argv => ['-He', '$_->{field1} *= 2; $_->{field2} =~ s/foo/bar/', 'file.csv'],
            test => 0,
            'x.doc.show_result' => 0,
        },
    ],

    on_input_header_row => sub {
        my $r = shift;

        # we add the following keys to the stash
        $r->{code} = compile_eval_code($r->{util_args}{eval}, 'eval');

        $r->{wants_input_row_as_hashref} = 1 if $r->{util_args}{hash};
    },

    on_input_data_row => sub {
        my $r = shift;

        my $topic; eval { $topic = eval_code($r->{code}, $r, $r->{wants_input_row_as_hashref} ? $r->{input_row_as_hashref} : $r->{input_row}, 'return_topic') };
        die [500, "Error while munging row #$r->{input_rownum}: $@\n"] if $@;
        # convert back hashref row to arrayref
        my $newrow;
        if ($r->{util_args}{hash}) {
            $newrow = [('') x @{ $r->{input_fields} }];
            for my $field (keys %$topic) {
                next unless exists $r->{input_fields_idx}{$field}; # ignore created fields
                $newrow->[$r->{input_fields_idx}{$field}] = $topic->{$field};
            }
        } else {
            $newrow = $topic;
        }
        $r->{code_print_row}->($newrow);
    },
);

1;
# ABSTRACT:

__END__

=pod

=encoding UTF-8

=head1 NAME

App::CSVUtils::csv_munge_row

=head1 VERSION

This document describes version 1.001 of App::CSVUtils::csv_munge_row (from Perl distribution App-CSVUtils), released on 2023-01-04.

=head1 FUNCTIONS


=head2 csv_munge_row

Usage:

 csv_munge_row(%args) -> [$status_code, $reason, $payload, \%result_meta]

.

Examples:

=over

=item * Modify two fields in a CSV:

 csv_munge_row(
     input_filename => "file.csv",
   eval => "\$_->{field1} *= 2; \$_->{field2} =~ s/foo/bar/",
   hash => 1
 );

=back

Perl code (-e) will be called for each row (excluding the header row) and C<$_>
will contain the row (arrayref, or hashref if C<-H> is specified). The Perl code
is expected to modify it.

Aside from C<$_>, C<$main::row> will contain the current row array.
C<$main::rownum> contains the row number (2 means the first data row).
C<$main::csv> is the L<Text::CSV_XS> object. C<$main::fields_idx> is also
available for additional information.

The modified C<$_> will be rendered back to CSV row.

You cannot add new fields using this utility. To do so, use
L<csv-add-fields>. You also cannot delete fields (they just become empty
string if you delete the field in the eval code). To delete fields, use
L<csv-delete-fields>.

Note that you can also munge a single field using L<csv-munge-field>.

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<eval>* => I<str|code>

Perl code.

=item * B<hash> => I<bool>

Provide row in $_ as hashref instead of arrayref.

=item * B<input_escape_char> => I<str>

Specify character to escape value in field in input CSV, will be passed to Text::CSV_XS.

Defaults to C<\\> (backslash). Overrides C<--input-tsv> option.

=item * B<input_filename> => I<filename> (default: "-")

Input CSV file.

Use C<-> to read from stdin.

Encoding of input file is assumed to be UTF-8.

=item * B<input_header> => I<bool> (default: 1)

Specify whether input CSV has a header row.

By default, the first row of the input CSV will be assumed to contain field
names (and the second row contains the first data row). When you declare that
input CSV does not have header row (C<--no-input-header>), the first row of the
CSV is assumed to contain the first data row. Fields will be named C<field1>,
C<field2>, and so on.

=item * B<input_quote_char> => I<str>

Specify field quote character in input CSV, will be passed to Text::CSV_XS.

Defaults to C<"> (double quote). Overrides C<--input-tsv> option.

=item * B<input_sep_char> => I<str>

Specify field separator character in input CSV, will be passed to Text::CSV_XS.

Defaults to C<,> (comma). Overrides C<--input-tsv> option.

=item * B<input_tsv> => I<true>

Inform that input file is in TSV (tab-separated) format instead of CSV.

Overriden by C<--input-sep-char>, C<--input-quote-char>, C<--input-escape-char>
options. If one of those options is specified, then C<--input-tsv> will be
ignored.

=item * B<output_escape_char> => I<str>

Specify character to escape value in field in output CSV, will be passed to Text::CSV_XS.

This is like C<--input-escape-char> option but for output instead of input.

Defaults to C<\\> (backslash). Overrides C<--output-tsv> option.

=item * B<output_filename> => I<filename>

Output filename.

Use C<-> to output to stdout (the default if you don't specify this option).

Encoding of output file is assumed to be UTF-8.

=item * B<output_header> => I<bool>

Whether output CSV should have a header row.

By default, a header row will be output I<if> input CSV has header row. Under
C<--output-header>, a header row will be output even if input CSV does not have
header row (value will be something like "col0,col1,..."). Under
C<--no-output-header>, header row will I<not> be printed even if input CSV has
header row. So this option can be used to unconditionally add or remove header
row.

=item * B<output_quote_char> => I<str>

Specify field quote character in output CSV, will be passed to Text::CSV_XS.

This is like C<--input-quote-char> option but for output instead of input.

Defaults to C<"> (double quote). Overrides C<--output-tsv> option.

=item * B<output_sep_char> => I<str>

Specify field separator character in output CSV, will be passed to Text::CSV_XS.

This is like C<--input-sep-char> option but for output instead of input.

Defaults to C<,> (comma). Overrides C<--output-tsv> option.

=item * B<output_tsv> => I<bool>

Inform that output file is TSV (tab-separated) format instead of CSV.

This is like C<--input-tsv> option but for output instead of input.

Overriden by C<--output-sep-char>, C<--output-quote-char>, C<--output-escape-char>
options. If one of those options is specified, then C<--output-tsv> will be
ignored.

=item * B<overwrite> => I<bool>

Whether to override existing output file.


=back

Returns an enveloped result (an array).

First element ($status_code) is an integer containing HTTP-like status code
(200 means OK, 4xx caller error, 5xx function error). Second element
($reason) is a string containing error message, or something like "OK" if status is
200. Third element ($payload) is the actual result, but usually not present when enveloped result is an error response ($status_code is not 2xx). Fourth
element (%result_meta) is called result metadata and is optional, a hash
that contains extra information, much like how HTTP response headers provide additional metadata.

Return value:  (any)

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/App-CSVUtils>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-App-CSVUtils>.

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

This software is copyright (c) 2023, 2022, 2021, 2020, 2019, 2018, 2017, 2016 by perlancar <perlancar@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-CSVUtils>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=cut
