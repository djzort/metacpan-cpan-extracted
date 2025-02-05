package Venus::Prototype;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Valuable';
with 'Venus::Role::Buildable';
with 'Venus::Role::Proxyable';

use Scalar::Util ();

# HOOKS

sub _clone {
  my ($data) = @_;

  if (!defined($data)) {
    return $data;
  }
  elsif (!Scalar::Util::blessed($data) && ref($data) eq 'HASH') {
    my $copy = {};
    for my $key (keys %$data) {
      $copy->{$key} = _clone($data->{$key});
    }
    return $copy;
  }
  elsif (!Scalar::Util::blessed($data) && ref($data) eq 'ARRAY') {
    my $copy = [];
    for (my $i = 0; $i < @$data; $i++) {
      $copy->[$i] = _copy($data->[$i]);
    }
    return $copy;
  }
  else {
    return $data;
  }
}

sub _value {
  my ($data) = @_;

  if (keys %$data == 1 && exists $data->{value}) {
    return $data->{value};
  }
  else {
    return $data;
  }
}

# BUILDERS

sub build_args {
  my ($self, $data) = @_;

  if (keys %$data == 1 && exists $data->{value}) {
    return _clone($data);
  }
  return {
    value => _clone($data)
  };
}

sub build_proxy {
  my ($self, $package, $method, @args) = @_;

  # as a method/routine
  return sub {
    $self->{value}{"\&$method"}->($self, @args)
  }
  if defined $self->{value}{"\&$method"};

  # as a property/attribute
  return sub {
    @args ? $self->{value}{"\$$method"} = $args[0] : $self->{value}{"\$$method"}
  }
  if exists $self->{value}{"\$$method"};

  return undef;
}

# METHODS

sub apply {
  my ($self, $data) = @_;

  $data ||= {};

  return $self->do('value', _clone({%{_value($self)}, %{_value($data)}}));
}

sub call {
  my ($self, $method, @args) = @_;

  # as a method/routine
  return $self->{value}{"\&$method"}->($self, @args)
    if defined $self->{value}{"\&$method"};

  # as a property/attribute
  return @args ? $self->{value}{"\$$method"} = $args[0] : $self->{value}{"\$$method"}
    if exists $self->{value}{"\$$method"};
}

sub default {
  my ($self) = @_;

  return {};
}

sub extend {
  my ($self, $data) = @_;

  $data ||= {};

  return $self->class->new(_clone({%{_value($self)}, %{_value($data)}}));
}

sub get {
  my ($self, @args) = @_;

  return $self->value if !int@args;

  my ($index) = @args;

  return $self->value->{$index};
}

sub set {
  my ($self, @args) = @_;

  return $self->value if !int@args;

  my ($index, $value) = @args;

  return $self->value->{$index} = $value;
}

1;



=head1 NAME

Venus::Prototype - Prototype Class

=cut

=head1 ABSTRACT

Prototype Class for Perl 5

=cut

=head1 SYNOPSIS

  package main;

  use Venus::Prototype;

  my $prototype = Venus::Prototype->new(
    '$counter' => 0,
    '&decrement' => sub { $_[0]->counter($_[0]->counter - 1) },
    '&increment' => sub { $_[0]->counter($_[0]->counter + 1) },
  );

  # bless({value => {...}}, 'Venus::Prototype')

  # $prototype->counter # 0
  # $prototype->increment # 1
  # $prototype->counter # 1
  # $prototype->decrement # 0
  # $prototype->counter # 0

=cut

=head1 DESCRIPTION

This package provides a simple construct for enabling prototype-base
programming. Properties can be called as methods when prefixed with a dollar or
ampersand symbol. See L</call> for more details.

=cut

=head1 INHERITS

This package inherits behaviors from:

L<Venus::Kind::Utility>

=cut

=head1 INTEGRATES

This package integrates behaviors from:

L<Venus::Role::Buildable>

L<Venus::Role::Proxyable>

L<Venus::Role::Valuable>

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 apply

  apply(HashRef $data) (Prototype)

The apply method extends the underlying data structure by merging the data
provided, and then returns the invocant.

I<Since C<1.50>>

=over 4

=item apply example 1

  package main;

  my $person = Venus::Prototype->new({
    '$name' => '',
  });

  $person->apply;

  # bless({value => {'$name' => ''}}, 'Venus::Prototype')

=back

=over 4

=item apply example 2

  package main;

  my $person = Venus::Prototype->new({
    '$name' => '',
  });

  $person->apply({
    '$name' => 'Elliot Alderson',
  });

  # bless({value => {'$name' => 'Elliot Alderson'}}, 'Venus::Prototype')

=back

=over 4

=item apply example 3

  package main;

  my $person = Venus::Prototype->new({
    '$name' => '',
    '&greet' => sub {'hello'},
  });

  $person->apply({
    '$name' => 'Elliot Alderson',
  });

  # bless({value => {...}}, 'Venus::Prototype')

=back

=cut

=head2 call

  call(Str $method, Any @args) (Any)

The call method dispatches method calls based on the method name provided and
the state of the object, and returns the results. If the method name provided
matches an object property of the same name with an ampersand prefix, denoting
a method, then the dispatched method call acts as a method call providing the
invocant as the first argument. If the method name provided matches an object
property of the same name with a dollar sign prefix, denoting an attribute,
then the dispatched method call acts as an attribute accessor call. This method
is also useful for calling virtual methods when those virtual methods conflict
with the L<Venus::Prototype> methods.

I<Since C<1.50>>

=over 4

=item call example 1

  package main;

  my $person = Venus::Prototype->new({
    '$name' => 'anonymous',
  });

  my $name = $person->call('name');

  # "anonymous"

=back

=over 4

=item call example 2

  package main;

  my $person = Venus::Prototype->new({
    '$name' => 'anonymous',
  });

  my $name = $person->call('name', 'unidentified');

  # "unidentified"

=back

=cut

=head2 extend

  extend(HashRef $data) (Prototype)

The extend method copies the underlying data structure, merging the data
provided if any, and then returns a new prototype object.

I<Since C<1.50>>

=over 4

=item extend example 1

  package main;

  my $mrrobot = Venus::Prototype->new({
    '$name' => 'Edward Alderson',
    '$group' => 'fsociety',
  });

  my $elliot = $mrrobot->extend({
    '$name' => 'Elliot Alderson',
  });

  # bless({value => {...}}, 'Venus::Prototype')

=back

=over 4

=item extend example 2

  package main;

  my $mrrobot = Venus::Prototype->new({
    '$name' => 'Edward Alderson',
    '$group' => 'fsociety',
    '$login' => { username => 'admin', password => 'secret', },
  });

  my $elliot = $mrrobot->extend({
    '$name' => 'Elliot Alderson',
    '$login' => { password => '$ecr3+', },
  });

  # bless({value => {...}}, 'Venus::Prototype')

=back

=over 4

=item extend example 3

  package main;

  my $ability = {
    '&access' => sub {time},
  };

  my $person = Venus::Prototype->new;

  my $mrrobot = $person->extend($ability);

  my $elliot = $mrrobot->extend($ability);

  # bless({value => {...}}, 'Venus::Prototype')

=back

=cut