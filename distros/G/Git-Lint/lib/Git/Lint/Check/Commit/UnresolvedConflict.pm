package Git::Lint::Check::Commit::UnresolvedConflict;

use strict;
use warnings;

use parent 'Git::Lint::Check::Commit';

our $VERSION = '0.016';

my $check_name = 'unresolved conflict';

sub check {
    my $self  = shift;
    my $input = shift;

    my $match = sub {
        my $line = shift;
        return 1 if $line =~ /^(?:[<>=]){7}$/;
        return;
    };

    return $self->parse(
        input => $input,
        match => $match,
        check => $check_name
    );
}

1;

__END__

=pod

=head1 NAME

Git::Lint::Check::Commit::UnresolvedConflict - check for lines with unresolved commit conflicts

=head1 SYNOPSIS

 my $plugin = Git::Lint::Check::Commit::UnresolvedConflict->new();

 my $input = $plugin->diff();
 my @lines = @{$input};
 my @issues = $plugin->check( \@lines );

=head1 DESCRIPTION

C<Git::Lint::Check::Commit::UnresolvedConflict> is a C<Git::Lint::Check::Commit> module which checks git diff input for unresolved commit conflicts.

=head1 METHODS

=over

=item check

Method that defines the check subref and passes it to C<Git::Lint::Check::Commit>'s parse method.

=back

=cut
