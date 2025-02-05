package API::MailboxOrg::API::Spamprotect;

# ABSTRACT: MailboxOrg::API::Spamprotect

# ---
# This class is auto-generated by bin/get_mailbox_api.pl
# ---

use v5.24;

use strict;
use warnings;

use Moo;
use Types::Standard qw(Enum Str Int InstanceOf ArrayRef);
use API::MailboxOrg::Types qw(HashRefRestricted Boolean);
use Params::ValidationCompiler qw(validation_for);

extends 'API::MailboxOrg::APIBase';

with 'MooX::Singleton';

use feature 'signatures';
no warnings 'experimental::signatures';

our $VERSION = '1.0.2'; # VERSION

my %validators = (
    'get' => validation_for(
        params => {
            mail => { type => Str, optional => 0 },

        },
    ),
    'set' => validation_for(
        params => {
            mail                 => { type => Str, optional => 0 },
            greylist             => { type => Enum[qw(0 1)], optional => 0 },
            smtp_plausibility    => { type => Enum[qw(0 1)], optional => 0 },
            rbl                  => { type => Enum[qw(0 1)], optional => 0 },
            bypass_banned_checks => { type => Enum[qw(0 1)], optional => 0 },
            tag2level            => { type => Str, optional => 0 },
            killevel             => { type => Enum[qw(reject route)], optional => 0 },
            route_to             => { type => Str, optional => 0 },

        },
    ),

);


sub get ($self, %params) {
    my $validator = $validators{'get'};
    %params       = $validator->(%params) if $validator;

    my %opt = (needs_auth => 1);

    return $self->_request( 'mail.spamprotect.get', \%params, \%opt );
}

sub set ($self, %params) {
    my $validator = $validators{'set'};
    %params       = $validator->(%params) if $validator;

    my %opt = (needs_auth => 1);

    return $self->_request( 'mail.spamprotect.set', \%params, \%opt );
}


1;

__END__

=pod

=encoding UTF-8

=head1 NAME

API::MailboxOrg::API::Spamprotect - MailboxOrg::API::Spamprotect

=head1 VERSION

version 1.0.2

=head1 SYNOPSIS

    use API::MailboxOrg;

    my $user     = '1234abc';
    my $password = '1234abc';

    my $api      = API::MailboxOrg->new(
        user     => $user,
        password => $password,
    );

=head1 METHODS

=head2 get

Read spamprotection settings

Available for admin, account, domain, mail

Parameters:

=over 4

=item * mail

=back

returns: array

    $api->spamprotect->get(%params);

=head2 set

Sets the spamprotection settings

Available for admin, account, domain, mail

Parameters:

=over 4

=item * mail

=item * greylist

=item * smtp_plausibility

=item * rbl

=item * bypass_banned_checks

=item * tag2level

=item * killevel

=item * route_to

=back

returns: array

    $api->spamprotect->set(%params);

=head1 AUTHOR

Renee Baecker <reneeb@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2022 by Renee Baecker.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
