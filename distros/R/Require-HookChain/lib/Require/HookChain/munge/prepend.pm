package Require::HookChain::munge::prepend;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2020-11-13'; # DATE
our $DIST = 'Require-HookChain'; # DIST
our $VERSION = '0.003'; # VERSION

sub new {
    my ($class, $preamble) = @_;
    bless { preamble => $preamble }, $class;
}

sub Require::HookChain::munge::prepend::INC {
    my ($self, $r) = @_;

    # safety, in case we are not called by Require::HookChain
    return () unless ref $r;

    my $src = $r->src;
    return unless defined $src;
    $src = "$self->{preamble};\n$src";
    $r->src($src);
}

1;
# ABSTRACT: Prepend a piece of code to module source

__END__

=pod

=encoding UTF-8

=head1 NAME

Require::HookChain::munge::prepend - Prepend a piece of code to module source

=head1 VERSION

This document describes version 0.003 of Require::HookChain::munge::prepend (from Perl distribution Require-HookChain), released on 2020-11-13.

=head1 SYNOPSIS

 use Require::HookChain 'munge::prepend' => 'use strict';

The above has a similar effect to:

 use everywhere 'strict';

=head1 DESCRIPTION

=for Pod::Coverage .+

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Require-HookChain>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Require-HookChain>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Require-HookChain>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

L<Require::HookChain>

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2020, 2017 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
