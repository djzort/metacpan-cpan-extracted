package WebService::PayPal::PaymentsAdvanced::Role::HasPayPal;

use Moo::Role;

use namespace::autoclean;

our $VERSION = '0.000028';

use Types::Common::String qw( NonEmptyStr );

has reference_transaction_id => (
    is       => 'lazy',
    isa      => NonEmptyStr,
    init_arg => undef,
    default  => sub { shift->params->{BAID} },
);

1;

# ABSTRACT: Role which provides methods specifically for PayPal transactions

__END__

=pod

=encoding UTF-8

=head1 NAME

WebService::PayPal::PaymentsAdvanced::Role::HasPayPal - Role which provides methods specifically for PayPal transactions

=head1 VERSION

version 0.000028

=head1 METHODS

=head2 reference_transaction_id

The id you will use in order to use this as a reference transaction (C<BAID>).

=head1 SUPPORT

Bugs may be submitted through L<https://github.com/maxmind/webservice-paypal-paymentsadvanced/issues>.

=head1 AUTHOR

Olaf Alders <olaf@wundercounter.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2022 by MaxMind, Inc.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
