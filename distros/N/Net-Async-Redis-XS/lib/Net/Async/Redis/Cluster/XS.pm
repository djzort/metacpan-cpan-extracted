package Net::Async::Redis::Cluster::XS;

use strict;
use warnings;

our $VERSION = '0.008'; # VERSION

use parent qw(Net::Async::Redis::Cluster);

=head1 NAME

Net::Async::Redis::Cluster::XS - like L<Net::Async::Redis::Cluster> but faster

=head1 DESCRIPTION

This is a wrapper around L<Net::Async::Redis::Cluster> with faster protocol parsing.

API and behaviour should be identical to L<Net::Async::Redis::Cluster>, see there for instructions.

=cut

use Net::Async::Redis::XS;
use Future::AsyncAwait;

async sub bootstrap {
    my ($self, %args) = @_;
    my $redis;
    try {
        $self->add_child(
            $redis = Net::Async::Redis::XS->new(
                host => $args{host},
                port => $args{port},
            )
        );
        await $redis->connect;
        await $self->apply_slots_from_instance($redis);
    } finally {
        $redis->remove_from_parent if $redis;
    }
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2022. Licensed under the same terms as Perl itself.

