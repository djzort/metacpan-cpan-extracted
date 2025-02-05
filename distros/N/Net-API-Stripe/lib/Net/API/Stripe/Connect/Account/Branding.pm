##----------------------------------------------------------------------------
## Stripe API - ~/lib/Net/API/Stripe/Connect/Account/Branding.pm
## Version v0.100.0
## Copyright(c) 2019 DEGUEST Pte. Ltd.
## Author: Jacques Deguest <jack@deguest.jp>
## Created 2019/11/02
## Modified 2020/05/15
## 
##----------------------------------------------------------------------------
package Net::API::Stripe::Connect::Account::Branding;
BEGIN
{
    use strict;
    use warnings;
    use parent qw( Net::API::Stripe::Generic );
    use vars qw( $VERSION );
    our( $VERSION ) = 'v0.100.0';
};

use strict;
use warnings;

sub icon { return( shift->_set_get_scalar_or_object( 'icon', 'Net::API::Stripe::File', @_ ) ); }

sub logo { return( shift->_set_get_scalar_or_object( 'logo', 'Net::API::Stripe::File', @_ ) ); }

sub primary_color { return( shift->_set_get_scalar( 'primary_color', @_ ) ); }

sub secondary_color { return( shift->_set_get_scalar( 'secondary_color', @_ ) ); }

1;

__END__

=encoding utf8

=head1 NAME

Net::API::Stripe::Connect::Account::Branding - A Stripe Account Branding Object

=head1 SYNOPSIS

    my $obj = $stripe->account->setting->branding({
        icon => '/some/file/path/corp.png',
        logo => '/some/other/path/large.jpg',
        # Or an hexadecimal value preceded by a #
        primary_color => 'blue',
    });

=head1 VERSION

    v0.100.0

=head1 DESCRIPTION

Settings used to apply the account’s branding to email receipts, invoices, Checkout, and other products.

This is called by method B<branding> from L<Net::API::Stripe::Connect::Account::Settings>

=head1 CONSTRUCTOR

=head2 new( %ARG )

Creates a new L<Net::API::Stripe::Connect::Account::Branding> object.
It may also take an hash like arguments, that also are method of the same name.

=head1 METHODS

=head2 icon string (expandable)

(ID of a file upload) An icon for the account. Must be square and at least 128px x 128px.

When expanded, this is a L<Net::API::Stripe::File> object.

=head2 logo string (expandable)

(ID of a file upload) A logo for the account that will be used in Checkout instead of the icon and without the account’s name next to it if provided. Must be at least 128px x 128px.

When expanded, this is a L<Net::API::Stripe::File> object.

=head2 primary_color string

A CSS hex color value representing the primary branding color for this account

=head2 secondary_color string

A CSS hex color value representing the secondary branding color for this account

=head1 API SAMPLE

    {
      "id": "acct_fake123456789",
      "object": "account",
      "business_profile": {
        "mcc": null,
        "name": "My Shop, Inc",
        "product_description": "Great products shipping all over the world",
        "support_address": {
          "city": "Tokyo",
          "country": "JP",
          "line1": "1-2-3 Kudan-minami, Chiyoda-ku",
          "line2": "",
          "postal_code": "100-0012",
          "state": ""
        },
        "support_email": "billing@example.com",
        "support_phone": "+81312345678",
        "support_url": "",
        "url": "https://www.example.com"
      },
      "business_type": "company",
      "capabilities": {
        "card_payments": "active"
      },
      "charges_enabled": true,
      "country": "JP",
      "default_currency": "jpy",
      "details_submitted": true,
      "email": "tech@example.com",
      "metadata": {},
      "payouts_enabled": true,
      "settings": {
        "branding": {
          "icon": "file_1DLfake123456789",
          "logo": null,
          "primary_color": "#0e77ca"
        },
        "card_payments": {
          "decline_on": {
            "avs_failure": false,
            "cvc_failure": false
          },
          "statement_descriptor_prefix": null
        },
        "dashboard": {
          "display_name": "myshop-inc",
          "timezone": "Asia/Tokyo"
        },
        "payments": {
          "statement_descriptor": "MYSHOP, INC",
          "statement_descriptor_kana": "ﾏｲｼｮｯﾌﾟｲﾝｸ",
          "statement_descriptor_kanji": "マイショップインク"
        },
        "payouts": {
          "debit_negative_balances": true,
          "schedule": {
            "delay_days": 4,
            "interval": "weekly",
            "weekly_anchor": "thursday"
          },
          "statement_descriptor": null
        }
      },
      "type": "standard"
    }

=head1 HISTORY

=head2 v0.1

Initial version

=head1 AUTHOR

Jacques Deguest E<lt>F<jack@deguest.jp>E<gt>

=head1 SEE ALSO

Stripe API documentation:

L<https://stripe.com/docs/api/accounts/object>

=head1 COPYRIGHT & LICENSE

Copyright (c) 2019-2020 DEGUEST Pte. Ltd.

You can use, copy, modify and redistribute this package and associated
files under the same terms as Perl itself.

=cut
