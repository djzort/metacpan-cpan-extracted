package Venus::Core;

use 5.018;

use strict;
use warnings;

# METHODS

sub ARGS {
  my ($self, @args) = @_;

  return (!@args)
    ? ($self->DATA)
    : ((@args == 1 && ref($args[0]) eq 'HASH')
    ? (!%{$args[0]} ? $self->DATA : {%{$args[0]}})
    : (@args % 2 ? {@args, undef} : {@args}));
}

sub ATTR {
  my ($self, $attr, @args) = @_;

  no strict 'refs';
  no warnings 'redefine';

  *{"@{[$self->NAME]}::$attr"} = sub {$_[0]->ITEM($attr, @_[1..$#_])}
    if !$self->can($attr);

  my $index = int(keys(%{$${"@{[$self->NAME]}::META"}{ATTR}})) + 1;

  $${"@{[$self->NAME]}::META"}{ATTR}{$attr} = [$index, [$attr, @args]];

  ${"@{[$self->NAME]}::@{[$self->METAOBJECT]}"} = undef;

  return $self;
}

sub AUDIT {
  my ($self) = @_;

  return $self;
}

sub BASE {
  my ($self, $base, @args) = @_;

  no strict 'refs';

  if (!grep !/\A[^:]+::\z/, keys(%{"${base}::"})) {
    local $@; eval "require $base"; do{require Venus; Venus::fault($@)} if $@;
  }

  @{"@{[$self->NAME]}::ISA"} = (
    $base, (grep +($_ ne $base), @{"@{[$self->NAME]}::ISA"})
  );

  my $index = int(keys(%{$${"@{[$self->NAME]}::META"}{BASE}})) + 1;

  $${"@{[$self->NAME]}::META"}{BASE}{$base} = [$index, [$base, @args]];

  ${"@{[$self->NAME]}::@{[$self->METAOBJECT]}"} = undef;

  return $self;
}

sub BLESS {
  my ($self, @args) = @_;

  my $name = $self->NAME;
  my $data = $self->DATA($self->ARGS($self->BUILDARGS(@args)));
  my $anew = bless($data, $name);

  no strict 'refs';

  $anew->BUILD($data);

  # FYI, every call to "new" calls "BUILD" which dispatches to each "BUILD"
  # defined in each attached role.

  # If one (or more) roles use reflection (i.e. calls "META") to introspect the
  # package's configuration, that could cause a performance problem given that
  # the Venus::Meta class uses recursion to introspect all superclasses and
  # roles in order to determine and present aggregate lists of package members.

  # The solution to this is to cache the associated Venus::Meta object which
  # itself caches the results of its recursive lookups. The cache is stored on
  # the subclass (i.e. on the calling package) the cache wil go away whenever
  # the package does, e.g. Venus::Space#unload.

  ${"${name}::@{[$self->METAOBJECT]}"} ||= Venus::Meta->new(name => $name)
    if $name ne 'Venus::Meta';

  return $anew;
}

sub BUILD {
  my ($self) = @_;

  return $self;
}

sub BUILDARGS {
  my ($self, @args) = @_;

  return (@args);
}

sub DATA {
  my ($self, $data) = @_;

  return $data ? {%$data} : {};
}

sub DESTROY {
  my ($self) = @_;

  return;
}

sub DOES {
  my ($self, $role) = @_;

  return if !$role;

  return $self->META->role($role);
}

sub EXPORT {
  my ($self, $into) = @_;

  return [];
}

sub FROM {
  my ($self, $base) = @_;

  $self->BASE($base);

  $base->AUDIT($self->NAME) if $base->can('AUDIT');

  no warnings 'redefine';

  $base->IMPORT($self->NAME);

  return $self;
}

sub IMPORT {
  my ($self, $into) = @_;

  return $self;
}

sub ITEM {
  my ($self, $name, @args) = @_;

  return undef if !$name;
  return $self->{$name} if !@args;
  return $self->{$name} = $args[0];
}

sub META {
  my ($self) = @_;

  no strict 'refs';

  require Venus::Meta;

  my $name = $self->NAME;

  return ${"${name}::@{[$self->METAOBJECT]}"}
    || Venus::Meta->new(name => $name);
}

sub METAOBJECT {
  my ($self) = @_;

  return 'METAOBJECT';
}

sub MIXIN {
  my ($self, $mixin, @args) = @_;

  no strict 'refs';

  if (!grep !/\A[^:]+::\z/, keys(%{"${mixin}::"})) {
    local $@; eval "require $mixin"; do{require Venus; Venus::fault($@)} if $@;
  }

  no warnings 'redefine';

  $mixin->IMPORT($self->NAME);

  no strict 'refs';

  my $index = int(keys(%{$${"@{[$self->NAME]}::META"}{MIXIN}})) + 1;

  $${"@{[$self->NAME]}::META"}{MIXIN}{$mixin} = [$index, [$mixin, @args]];

  ${"@{[$self->NAME]}::@{[$self->METAOBJECT]}"} = undef;

  return $self;
}

sub NAME {
  my ($self) = @_;

  return ref $self || $self;
}

sub ROLE {
  my ($self, $role, @args) = @_;

  no strict 'refs';

  if (!grep !/\A[^:]+::\z/, keys(%{"${role}::"})) {
    local $@; eval "require $role"; do{require Venus; Venus::fault($@)} if $@;
  }

  no warnings 'redefine';

  $role->IMPORT($self->NAME);

  no strict 'refs';

  my $index = int(keys(%{$${"@{[$self->NAME]}::META"}{ROLE}})) + 1;

  $${"@{[$self->NAME]}::META"}{ROLE}{$role} = [$index, [$role, @args]];

  ${"@{[$self->NAME]}::@{[$self->METAOBJECT]}"} = undef;

  return $self;
}

sub SUBS {
  my ($self) = @_;

  no strict 'refs';

  return [
    sort grep *{"@{[$self->NAME]}::$_"}{"CODE"},
    grep /^[_a-zA-Z]\w*$/, keys %{"@{[$self->NAME]}::"}
  ];
}

sub TEST {
  my ($self, $role) = @_;

  $self->ROLE($role);

  $role->AUDIT($self->NAME) if $role->can('AUDIT');

  return $self;
}

1;



=head1 NAME

Venus::Core - Core Base Class

=cut

=head1 ABSTRACT

Core Base Class for Perl 5

=cut

=head1 SYNOPSIS

  package User;

  use base 'Venus::Core';

  package main;

  my $user = User->BLESS(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'User')

  # i.e. BLESS is somewhat equivalent to writing

  # User->BUILD(bless(User->ARGS(User->BUILDARGS(@args) || User->DATA), 'User'))

=cut

=head1 DESCRIPTION

This package provides a base class for L<"class"|Venus::Core::Class> and
L<"role"|Venus::Core::Role> (kind) derived packages and provides class building,
object construction, and object deconstruction lifecycle hooks. The
L<Venus::Class> and L<Venus::Role> packages provide a simple DSL for automating
L<Venus::Core> derived base classes.

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 args

  ARGS(Any @args) (HashRef)

The ARGS method is a object construction lifecycle hook which accepts a list of
arguments and returns a blessable data structure.

I<Since C<1.00>>

=over 4

=item args example 1

  # given: synopsis

  package main;

  my $args = User->ARGS;

  # {}

=back

=over 4

=item args example 2

  # given: synopsis

  package main;

  my $args = User->ARGS(name => 'Elliot');

  # {name => 'Elliot'}

=back

=over 4

=item args example 3

  # given: synopsis

  package main;

  my $args = User->ARGS({name => 'Elliot'});

  # {name => 'Elliot'}

=back

=cut

=head2 attr

  ATTR(Str $name, Any @args) (Str | Object)

The ATTR method is a class building lifecycle hook which installs an attribute
accessors in the calling package.

I<Since C<1.00>>

=over 4

=item attr example 1

  package User;

  use base 'Venus::Core';

  User->ATTR('name');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

  # $user->name;

  # ""

  # $user->name('Elliot');

  # "Elliot"

=back

=over 4

=item attr example 2

  package User;

  use base 'Venus::Core';

  User->ATTR('role');

  package main;

  my $user = User->BLESS(role => 'Engineer');

  # bless({role => 'Engineer'}, 'User')

  # $user->role;

  # "Engineer"

  # $user->role('Hacker');

  # "Hacker"

=back

=cut

=head2 audit

  AUDIT(Str $role) (Str | Object)

The AUDIT method is a class building lifecycle hook which exist in roles and is
executed as a callback when the consuming class invokes the L</TEST> hook.

I<Since C<1.00>>

=over 4

=item audit example 1

  package HasType;

  use base 'Venus::Core';

  sub AUDIT {
    die 'Consumer missing "type" attribute' if !$_[1]->can('type');
  }

  package User;

  use base 'Venus::Core';

  User->TEST('HasType');

  package main;

  my $user = User->BLESS;

  # Exception! Consumer missing "type" attribute

=back

=over 4

=item audit example 2

  package HasType;

  sub AUDIT {
    die 'Consumer missing "type" attribute' if !$_[1]->can('type');
  }

  package User;

  use base 'Venus::Core';

  User->ATTR('type');

  User->TEST('HasType');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

=back

=cut

=head2 base

  BASE(Str $name) (Str | Object)

The BASE method is a class building lifecycle hook which registers a base class
for the calling package. B<Note:> Unlike the L</FROM> hook, this hook doesn't
invoke the L</AUDIT> hook.

I<Since C<1.00>>

=over 4

=item base example 1

  package Entity;

  sub work {
    return;
  }

  package User;

  use base 'Venus::Core';

  User->BASE('Entity');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

=back

=over 4

=item base example 2

  package Engineer;

  sub debug {
    return;
  }

  package Entity;

  sub work {
    return;
  }

  package User;

  use base 'Venus::Core';

  User->BASE('Entity');

  User->BASE('Engineer');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

=back

=over 4

=item base example 3

  package User;

  use base 'Venus::Core';

  User->BASE('Manager');

  # Exception! "Can't locate Manager.pm in @INC"

=back

=cut

=head2 bless

  BLESS(Any @args) (Object)

The BLESS method is an object construction lifecycle hook which returns an
instance of the calling package.

I<Since C<1.00>>

=over 4

=item bless example 1

  package User;

  use base 'Venus::Core';

  package main;

  my $example = User->BLESS;

  # bless({}, 'User')

=back

=over 4

=item bless example 2

  package User;

  use base 'Venus::Core';

  package main;

  my $example = User->BLESS(name => 'Elliot');

  # bless({name => 'Elliot'}, 'User')

=back

=over 4

=item bless example 3

  package User;

  use base 'Venus::Core';

  package main;

  my $example = User->BLESS({name => 'Elliot'});

  # bless({name => 'Elliot'}, 'User')

=back

=over 4

=item bless example 4

  package List;

  use base 'Venus::Core';

  sub ARGS {
    my ($self, @args) = @_;

    return @args
      ? ((@args == 1 && ref $args[0] eq 'ARRAY') ? @args : [@args])
      : $self->DATA;
  }

  sub DATA {
    my ($self, $data) = @_;

    return $data ? [@$data] : [];
  }

  package main;

  my $list = List->BLESS(1..4);

  # bless([1..4], 'List')

=back

=over 4

=item bless example 5

  package List;

  use base 'Venus::Core';

  sub ARGS {
    my ($self, @args) = @_;

    return @args
      ? ((@args == 1 && ref $args[0] eq 'ARRAY') ? @args : [@args])
      : $self->DATA;
  }

  sub DATA {
    my ($self, $data) = @_;

    return $data ? [@$data] : [];
  }

  package main;

  my $list = List->BLESS([1..4]);

  # bless([1..4], 'List')

=back

=cut

=head2 build

  BUILD(HashRef $data) (Object)

The BUILD method is an object construction lifecycle hook which receives an
object and the data structure that was blessed, and should return an object
although its return value is ignored by the L</BLESS> hook.

I<Since C<1.00>>

=over 4

=item build example 1

  package User;

  use base 'Venus::Core';

  sub BUILD {
    my ($self) = @_;

    $self->{name} = 'Mr. Robot';

    return $self;
  }

  package main;

  my $example = User->BLESS(name => 'Elliot');

  # bless({name => 'Mr. Robot'}, 'User')

=back

=over 4

=item build example 2

  package User;

  use base 'Venus::Core';

  sub BUILD {
    my ($self) = @_;

    $self->{name} = 'Mr. Robot';

    return $self;
  }

  package Elliot;

  use base 'User';

  sub BUILD {
    my ($self, $data) = @_;

    $self->SUPER::BUILD($data);

    $self->{name} = 'Elliot';

    return $self;
  }

  package main;

  my $elliot = Elliot->BLESS;

  # bless({name => 'Elliot'}, 'Elliot')

=back

=cut

=head2 buildargs

  BUILDARGS(Any @args) (Any @args | HashRef $data)

The BUILDARGS method is an object construction lifecycle hook which receives
the arguments provided to the constructor (unaltered) and should return a list
of arguments, a hashref, or key/value pairs.

I<Since C<1.00>>

=over 4

=item buildargs example 1

  package User;

  use base 'Venus::Core';

  sub BUILD {
    my ($self) = @_;

    return $self;
  }

  sub BUILDARGS {
    my ($self, @args) = @_;

    my $data = @args == 1 && !ref $args[0] ? {name => $args[0]} : {};

    return $data;
  }

  package main;

  my $user = User->BLESS('Elliot');

  # bless({name => 'Elliot'}, 'User')

=back

=cut

=head2 data

  DATA() (Ref)

The DATA method is an object construction lifecycle hook which returns the
default data structure reference to be blessed when no arguments are provided
to the constructor. The default data structure is an empty hashref.

I<Since C<1.00>>

=over 4

=item data example 1

  package Example;

  use base 'Venus::Core';

  sub DATA {
    return [];
  }

  package main;

  my $example = Example->BLESS;

  # bless([], 'Example')

=back

=over 4

=item data example 2

  package Example;

  use base 'Venus::Core';

  sub DATA {
    return {};
  }

  package main;

  my $example = Example->BLESS;

  # bless({}, 'Example')

=back

=cut

=head2 destroy

  DESTROY() (Any)

The DESTROY method is an object destruction lifecycle hook which is called when
the last reference to the object goes away.

I<Since C<1.00>>

=over 4

=item destroy example 1

  package User;

  use base 'Venus::Core';

  our $USERS = 0;

  sub BUILD {
    return $USERS++;
  }

  sub DESTROY {
    return $USERS--;
  }

  package main;

  my $user = User->BLESS(name => 'Elliot');

  undef $user;

  # undef

=back

=cut

=head2 does

  DOES(Str $name) (Bool)

The DOES method returns true or false if the invocant consumed the role or
interface provided.

I<Since C<1.00>>

=over 4

=item does example 1

  package Admin;

  use base 'Venus::Core';

  package User;

  use base 'Venus::Core';

  User->ROLE('Admin');

  sub BUILD {
    return;
  }

  sub BUILDARGS {
    return;
  }

  package main;

  my $admin = User->DOES('Admin');

  # 1

=back

=over 4

=item does example 2

  package Admin;

  use base 'Venus::Core';

  package User;

  use base 'Venus::Core';

  User->ROLE('Admin');

  sub BUILD {
    return;
  }

  sub BUILDARGS {
    return;
  }

  package main;

  my $is_owner = User->DOES('Owner');

  # 0

=back

=cut

=head2 export

  EXPORT(Any @args) (ArrayRef)

The EXPORT method is a class building lifecycle hook which returns an arrayref
of routine names to be automatically imported by the calling package whenever
the L</ROLE> or L</TEST> hooks are used.

I<Since C<1.00>>

=over 4

=item export example 1

  package Admin;

  use base 'Venus::Core';

  sub shutdown {
    return;
  }

  sub EXPORT {
    ['shutdown']
  }

  package User;

  use base 'Venus::Core';

  User->ROLE('Admin');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

=back

=cut

=head2 from

  FROM(Str $name) (Str | Object)

The FROM method is a class building lifecycle hook which registers a base class
for the calling package, automatically invoking the L</AUDIT> and L</IMPORT>
hooks on the base class.

I<Since C<1.00>>

=over 4

=item from example 1

  package Entity;

  use base 'Venus::Core';

  sub AUDIT {
    my ($self, $from) = @_;
    die "Missing startup" if !$from->can('startup');
    die "Missing shutdown" if !$from->can('shutdown');
  }

  package User;

  use base 'Venus::Core';

  User->ATTR('startup');
  User->ATTR('shutdown');

  User->FROM('Entity');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

=back

=over 4

=item from example 2

  package Entity;

  use base 'Venus::Core';

  sub AUDIT {
    my ($self, $from) = @_;
    die "Missing startup" if !$from->can('startup');
    die "Missing shutdown" if !$from->can('shutdown');
  }

  package User;

  use base 'Venus::Core';

  User->FROM('Entity');

  sub startup {
    return;
  }

  sub shutdown {
    return;
  }

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

=back

=cut

=head2 import

  IMPORT(Str $into, Any @args) (Str | Object)

The IMPORT method is a class building lifecycle hook which dispatches the
L</EXPORT> lifecycle hook whenever the L</ROLE> or L</TEST> hooks are used.

I<Since C<1.00>>

=over 4

=item import example 1

  package Admin;

  use base 'Venus::Core';

  our $USES = 0;

  sub shutdown {
    return;
  }

  sub EXPORT {
    ['shutdown']
  }

  sub IMPORT {
    my ($self, $into) = @_;

    $self->SUPER::IMPORT($into);

    $USES++;

    return $self;
  }

  package User;

  use base 'Venus::Core';

  User->ROLE('Admin');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

=back

=cut

=head2 item

  ITEM(Str $name, Any @args) (Str | Object)

The ITEM method is a class instance lifecycle hook which is responsible for
I<"getting"> and I<"setting"> instance items (or attributes). By default, all
class attributes are dispatched to this method.

I<Since C<1.11>>

=over 4

=item item example 1

  package User;

  use base 'Venus::Core';

  User->ATTR('name');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

  my $item = $user->ITEM('name', 'unknown');

  # "unknown"

=back

=over 4

=item item example 2

  package User;

  use base 'Venus::Core';

  User->ATTR('name');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

  $user->ITEM('name', 'known');

  my $item = $user->ITEM('name');

  # "known"

=back

=cut

=head2 meta

  META() (Meta)

The META method return a L<Venus::Meta> object which describes the invocant's
configuration.

I<Since C<1.00>>

=over 4

=item meta example 1

  package User;

  use base 'Venus::Core';

  package main;

  my $meta = User->META;

  # bless({name => 'User'}, 'Venus::Meta')

=back

=cut

=head2 name

  NAME() (Str)

The NAME method is a class building lifecycle hook which returns the name of
the package.

I<Since C<1.00>>

=over 4

=item name example 1

  package User;

  use base 'Venus::Core';

  package main;

  my $name = User->NAME;

  # "User"

=back

=over 4

=item name example 2

  package User;

  use base 'Venus::Core';

  package main;

  my $name = User->BLESS->NAME;

  # "User"

=back

=cut

=head2 role

  ROLE(Str $name) (Str | Object)

The ROLE method is a class building lifecycle hook which consumes the role
provided, automatically invoking the role's L</IMPORT> hook. B<Note:> Unlike
the L</TEST> and L</WITH> hooks, this hook doesn't invoke the L</AUDIT> hook.
The role composition semantics are as follows: Routines to be consumed must be
explicitly declared via the L</EXPORT> hook. Routines will be copied to the
consumer unless they already exist (excluding routines from base classes, which
will be overridden). If multiple roles are consumed having routines with the
same name (i.e. naming collisions) the first routine copied wins.

I<Since C<1.00>>

=over 4

=item role example 1

  package Admin;

  use base 'Venus::Core';

  package User;

  use base 'Venus::Core';

  User->ROLE('Admin');

  package main;

  my $admin = User->DOES('Admin');

  # 1

=back

=over 4

=item role example 2

  package Create;

  use base 'Venus::Core';

  package Delete;

  use base 'Venus::Core';

  package Manage;

  use base 'Venus::Core';

  Manage->ROLE('Create');
  Manage->ROLE('Delete');

  package User;

  use base 'Venus::Core';

  User->ROLE('Manage');

  package main;

  my $create = User->DOES('Create');

  # 1

=back

=cut

=head2 subs

  SUBS() (ArrayRef)

The SUBS method returns the routines defined on the package and consumed from
roles, but not inherited by superclasses.

I<Since C<1.00>>

=over 4

=item subs example 1

  package Example;

  use base 'Venus::Core';

  package main;

  my $subs = Example->SUBS;

  # [...]

=back

=cut

=head2 test

  TEST(Str $name) (Str | Object)

The TEST method is a class building lifecycle hook which consumes the role
provided, automatically invoking the role's L</IMPORT> hook as well as the
L</AUDIT> hook if defined.

I<Since C<1.00>>

=over 4

=item test example 1

  package Admin;

  use base 'Venus::Core';

  package IsAdmin;

  use base 'Venus::Core';

  sub shutdown {
    return;
  }

  sub AUDIT {
    my ($self, $from) = @_;
    die "${from} is not a super-user" if !$from->DOES('Admin');
  }

  sub EXPORT {
    ['shutdown']
  }

  package User;

  use base 'Venus::Core';

  User->ROLE('Admin');

  User->TEST('IsAdmin');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

=back

=cut