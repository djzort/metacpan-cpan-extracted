package POE::Component::SmokeBox::Backend::CPAN::YACSmoke;
$POE::Component::SmokeBox::Backend::CPAN::YACSmoke::VERSION = '0.54';
#ABSTRACT: a backend for CPAN::YACSmoke smokers.

use strict;
use warnings;
use base qw(POE::Component::SmokeBox::Backend::Base);

sub _data {
  my $self = shift;
  $self->{_data} =
  {
	check => [ '-MCPAN::YACSmoke', '-e', 1 ],
	index => [ '-MCPANPLUS::Backend', '-e', 'CPANPLUS::Backend->new()->reload_indices( update_source => 1 );' ],
	smoke => [ '-MCPAN::YACSmoke', '-e', 'my $module = shift; my $smoke = CPAN::YACSmoke->new(); $smoke->test($module);' ],
  };
  return;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

POE::Component::SmokeBox::Backend::CPAN::YACSmoke - a backend for CPAN::YACSmoke smokers.

=head1 VERSION

version 0.54

=head1 DESCRIPTION

POE::Component::SmokeBox::Backend::CPAN::Reporter is a L<POE::Component::SmokeBox::Backend> plugin that defines the
C<check>, C<index> and C<smoke> commands for L<CPAN::YACSmoke> based smokers.

=head1 METHODS

=over

=item C<check>

Returns [ '-MCPAN::YACSmoke', '-e', 1 ]

=item C<index>

Returns [ '-MCPANPLUS::Backend', '-e', 'CPANPLUS::Backend->new()->reload_indices( update_source => 1 );' ]

=item C<smoke>

Returns [ '-MCPAN::YACSmoke', '-e', 'my $module = shift; my $smoke = CPAN::YACSmoke->new(); $smoke->test($module);' ]

=back

=head1 SEE ALSO

L<POE::Component::SmokeBox::Backend>

=head1 AUTHOR

Chris Williams <chris@bingosnet.co.uk>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Chris Williams.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
