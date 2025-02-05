# TOTP second factor authentication
#
# This plugin handle authentications to ask TOTP second factor for users that
# have registered their TOTP secret
package Lemonldap::NG::Portal::2F::TOTP;

use strict;
use Mouse;
use JSON qw(from_json to_json);
use Lemonldap::NG::Portal::Main::Constants qw(
  PE_OK
  PE_ERROR
  PE_BADOTP
  PE_FORMEMPTY
  PE_SENDRESPONSE
);

our $VERSION = '2.0.15';

extends qw(
  Lemonldap::NG::Portal::Main::SecondFactor
  Lemonldap::NG::Common::TOTP
);

# INITIALIZATION

has prefix => ( is => 'ro', default => 'totp' );
has logo   => ( is => 'rw', default => 'totp.png' );

sub init {
    my ($self) = @_;

    # If "activation" is just set to "enabled",
    # replace the rule to detect if user has registered its key
    $self->conf->{totp2fActivation} = 'has2f("TOTP")'
      if $self->conf->{totp2fActivation} eq '1';

    return $self->SUPER::init();
}

# RUNNING METHODS

sub run {
    my ( $self, $req, $token ) = @_;
    $self->logger->debug('Generate TOTP form');

    my $checkLogins = $req->param('checkLogins');
    $self->logger->debug("TOTP: checkLogins set") if $checkLogins;

    my $stayconnected = $req->param('stayconnected');
    $self->logger->debug("TOTP: stayconnected set") if $stayconnected;

    # Prepare form
    my $tmp = $self->p->sendHtml(
        $req,
        'totp2fcheck',
        params => {
            MAIN_LOGO     => $self->conf->{portalMainLogo},
            SKIN          => $self->p->getSkin($req),
            TOKEN         => $token,
            CHECKLOGINS   => $checkLogins,
            STAYCONNECTED => $stayconnected
        }
    );
    $self->logger->debug("Prepare TOTP 2F verification");

    $req->response($tmp);
    return PE_SENDRESPONSE;
}

sub verify {
    my ( $self, $req, $session ) = @_;
    $self->logger->debug('TOTP verification');
    my $code;
    unless ( $code = $req->param('code') ) {
        $self->userLogger->error('TOTP 2F: no code');
        return PE_FORMEMPTY;
    }

    my ( $secret, $_2fDevices );
    if ( $session->{_2fDevices} ) {
        $self->logger->debug("Loading 2F Devices ...");

        # Read existing 2FDevices
        $_2fDevices =
          eval { from_json( $session->{_2fDevices}, { allow_nonref => 1 } ); };
        if ($@) {
            $self->logger->error("Bad encoding in _2fDevices: $@");
            return PE_ERROR;
        }
        $self->logger->debug("2F Device(s) found");
        $self->logger->debug("Reading TOTP secret if exists...");

        $secret = $_->{_secret}
          foreach grep { $_->{type} eq 'TOTP' } @$_2fDevices;
    }

    unless ($secret) {
        $self->logger->debug("No TOTP secret found");
        return PE_BADOTP;
    }

    my $r = $self->verifyCode(
        $self->conf->{totp2fInterval},
        $self->conf->{totp2fRange},
        $self->conf->{totp2fDigits},
        $secret, $code
    );
    return PE_ERROR if ( $r == -1 );

    if ($r) {
        $self->userLogger->info('TOTP succeed');
        return PE_OK;
    }
    else {
        $self->userLogger->notice(
            'Invalid TOTP for ' . $session->{ $self->conf->{whatToTrace} } );
        return PE_BADOTP;
    }
}

1;
