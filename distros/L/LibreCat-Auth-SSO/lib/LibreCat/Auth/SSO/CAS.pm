package LibreCat::Auth::SSO::CAS;

use Catmandu::Sane;
use Catmandu::Util qw(:check :is);
use Authen::CAS::Client;
use Moo;
use Plack::Request;
use Plack::Session;
use LibreCat::Auth::SSO::ResponseParser::CAS;
use namespace::clean;

our $VERSION = "0.01";

with "LibreCat::Auth::SSO";

has cas_url => (
    is => "ro",
    isa => sub { check_string($_[0]); },
    required => 1
);
has cas => (
    is => "ro",
    lazy => 1,
    builder => "_build_cas",
    init_arg => undef
);
has response_parser => (
    is => "ro",
    lazy => 1,
    builder => "_build_response_parser",
    init_arg => undef
);

sub _build_cas {
    my $self = $_[0];

    #TODO
    local $ENV{SSL_VERIFY_NONE}              = 1;
    local $ENV{PERL_LWP_SSL_VERIFY_HOSTNAME} = 0;
    Authen::CAS::Client->new($self->cas_url());
}
sub _build_response_parser {
    LibreCat::Auth::SSO::ResponseParser::CAS->new();
}

sub to_app {
    my $self = $_[0];
    sub {

        my $env = $_[0];

        my $request = Plack::Request->new($env);
        my $session = Plack::Session->new($env);
        my $params  = $request->query_parameters();

        my $auth_sso = $self->get_auth_sso($session);

        #already got here before
        if (is_hash_ref($auth_sso)) {

            return [
                302, [Location => $self->uri_for($self->authorization_path)],
                []
            ];

        }

        #ticket?
        my $ticket = $params->get("ticket");

        my $service = $self->uri_for($request->script_name());

        if (is_string($ticket)) {

            my $cas = $self->cas();

            my $r = $cas->service_validate($service, $ticket);

            if ($r->is_success) {

                my $doc = $r->doc();

                $self->set_auth_sso(
                    $session,
                    {
                        %{
                            $self->response_parser()->parse( $doc )
                        },
                        package    => __PACKAGE__,
                        package_id => $self->id,
                        response   => {
                            content => $doc->toString(),
                            content_type => "text/xml"
                        }
                    }
                );

                return [
                    302,
                    [Location => $self->uri_for($self->authorization_path)],
                    []
                ];

            }

        }

        #no ticket or ticket validation failed
        my $login_url = $self->cas()->login_url($service)->as_string;

        [302, [Location => $login_url], []];

    };
}

1;

=pod

=head1 NAME

LibreCat::Auth::SSO::CAS - implementation of LibreCat::Auth::SSO for CAS

=head1 SYNOPSIS

    #in your app.psgi

    builder {

        mount "/auth/cas" => LibreCat::Auth::SSO::CAS->new(

            session_key => "auth_sso",
            uri_base => "http://localhost:5000",
            authorization_path => "/auth/cas/callback"

        )->to_app;

        mount "/auth/cas/callback" => sub {

            my $env = shift;
            my $session = Plack::Session->new($env);
            my $auth_sso = $session->get("auth_sso");

            #not authenticated yet
            unless($auth_sso){

                return [403,["Content-Type" => "text/html"],["forbidden"]];

            }

            #process auth_sso (white list, roles ..)

            [200,["Content-Type" => "text/html"],["logged in!"]];

        };

    };


=head1 DESCRIPTION

This is an implementation of L<LibreCat::Auth::SSO> to authenticate against a CAS server.

It inherits all configuration options from its parent.

=head1 CONFIG

=over 4

=item cas_url

base url of the CAS service

=back

=head1 TODO

* add an option to ignore validation of the SSL certificate of the CAS Service? For now you should set the environment like this:

    export SSL_VERIFY_NONE=1
    export PERL_LWP_SSL_VERIFY_HOSTNAME=0

=head1 AUTHOR

Nicolas Franck, C<< <nicolas.franck at ugent.be> >>

=head1 SEE ALSO

L<LibreCat::Auth::SSO>

=cut
