package Faker::Plugin::JaJp::InternetEmailDomain;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base';

base 'Faker::Plugin::JaJp';

# VERSION

our $VERSION = '1.17';

# METHODS

sub execute {
  my ($self, $data) = @_;

  return $self->faker->random->select(data_for_internet_email_domain());
}

sub data_for_internet_email_domain {
  state $internet_email_domain = [
    'gmail.com',
    'yahoo.co.jp',
    'hotmail.co.jp',
    'mail.goo.ne.jp',
  ]
}

1;



=head1 NAME

Faker::Plugin::JaJp::InternetEmailDomain - Internet Email Domain

=cut

=head1 ABSTRACT

Internet Email Domain for Faker

=cut

=head1 VERSION

1.17

=cut

=head1 SYNOPSIS

  package main;

  use Faker::Plugin::JaJp::InternetEmailDomain;

  my $plugin = Faker::Plugin::JaJp::InternetEmailDomain->new;

  # bless(..., "Faker::Plugin::JaJp::InternetEmailDomain")

=cut

=head1 DESCRIPTION

This package provides methods for generating fake data for internet email domain.

=encoding utf8

=cut

=head1 INHERITS

This package inherits behaviors from:

L<Faker::Plugin::JaJp>

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 execute

  execute(HashRef $data) (Str)

The execute method returns a returns a random fake internet email domain.

I<Since C<1.10>>

=over 4

=item execute example 1

  package main;

  use Faker::Plugin::JaJp::InternetEmailDomain;

  my $plugin = Faker::Plugin::JaJp::InternetEmailDomain->new;

  # bless(..., "Faker::Plugin::JaJp::InternetEmailDomain")

  # my $result = $plugin->execute;

  # 'yahoo.co.jp';

  # my $result = $plugin->execute;

  # 'yahoo.co.jp';

  # my $result = $plugin->execute;

  # 'mail.goo.ne.jp';

=back

=cut

=head2 new

  new(HashRef $data) (Plugin)

The new method returns a new instance of the class.

I<Since C<1.10>>

=over 4

=item new example 1

  package main;

  use Faker::Plugin::JaJp::InternetEmailDomain;

  my $plugin = Faker::Plugin::JaJp::InternetEmailDomain->new;

  # bless(..., "Faker::Plugin::JaJp::InternetEmailDomain")

=back

=cut