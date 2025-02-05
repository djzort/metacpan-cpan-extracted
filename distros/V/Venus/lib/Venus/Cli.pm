package Venus::Cli;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Optional';

require POSIX;

# ATTRIBUTES

attr 'init';
attr 'path';
attr 'args';
attr 'data';
attr 'logs';
attr 'opts';
attr 'vars';

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    init => $data,
  };
}

# DEFAULTS

sub default_args {
  my ($self) = @_;

  require Venus::Args;

  return Venus::Args->new($self->init);
}

sub default_data {
  my ($self) = @_;

  require Venus::Data;

  return Venus::Data->new($self->path);
}

sub default_init {
  my ($self) = @_;

  return [@ARGV];
}

sub default_logs {
  my ($self) = @_;

  require Venus::Log;

  return Venus::Log->new('info');
}

sub default_opts {
  my ($self) = @_;

  require Venus::Opts;

  return Venus::Opts->new(value => $self->init, specs => $self->options);
}

sub default_path {
  my ($self) = @_;

  require Venus::Path;
  require Venus::Space;

  return Venus::Path->new(Venus::Space->new(ref $self)->included || $0);
}

sub default_vars {
  my ($self) = @_;

  require Venus::Vars;

  return Venus::Vars->new;
}

# HOOKS

sub _exit {
  POSIX::_exit(shift);
}

# METHODS

sub arg {
  my ($self, $item) = @_;

  return defined $item ? $self->opts->unused->[$item] : undef;
}

sub execute {
  my ($self) = @_;

  return $self->opt('help') ? $self->okay : $self->fail;
}

sub exit {
  my ($self, $code, $method, @args) = @_;

  $self->$method(@args) if $method;

  $code ||= 0;

  _exit($code);
}

sub fail {
  my ($self, $method, @args) = @_;

  return $self->exit(1, $method, @args);
}

sub help {
  my ($self, @data) = @_;

  my $content = $self->data->string(@data ? @data : ('head1', 'OPTIONS'));

  my ($space) = $content =~ /(^\s+)/;

  return (defined $space) ? $content =~ s/^$space//mgr : $content;
}

sub log_debug {
  my ($self, @data) = @_;

  return $self->logs->debug(@data);
}

sub log_error {
  my ($self, @data) = @_;

  return $self->logs->error(@data);
}

sub log_fatal {
  my ($self, @data) = @_;

  return $self->logs->fatal(@data);
}

sub log_info {
  my ($self, @data) = @_;

  return $self->logs->info(@data);
}

sub log_trace {
  my ($self, @data) = @_;

  return $self->logs->trace(@data);
}

sub log_warn {
  my ($self, @data) = @_;

  return $self->logs->warn(@data);
}

sub okay {
  my ($self, $method, @args) = @_;

  return $self->exit(0, $method, @args);
}

sub opt {
  my ($self, $item) = @_;

  return defined $item ? $self->opts->get($item) : undef;
}

sub options {
  my ($self) = @_;

  return ['help|h'];
}

1;



=head1 NAME

Venus::Cli - Cli Class

=cut

=head1 ABSTRACT

Cli Class for Perl 5

=cut

=head1 SYNOPSIS

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', '--help']);

  # $cli->program;

  # "/path/to/executable"

  # $cli->arg(0);

  # "example"

  # $cli->opt('help');

  # 1

=cut

=head1 DESCRIPTION

This package provides a superclass and methods for providing simple yet robust
command-line interfaces.

=cut

=head1 ATTRIBUTES

This package has the following attributes:

=cut

=head2 args

  args(Args $data) (Args)

The args attribute holds a L<Venus::Args> object.

I<Since C<1.71>>

=over 4

=item args example 1

  # given: synopsis

  package main;

  my $args = $cli->args;

=back

=cut

=head2 data

  data(Data $data) (Data)

The data attribute holds a L<Venus::Data> object.

I<Since C<1.71>>

=over 4

=item data example 1

  # given: synopsis

  package main;

  my $data = $cli->data;

=back

=cut

=head2 init

  init(ArrayRef $data) (ArrayRef)

The init attribute holds the "initial" raw arguments provided to the CLI,
defaulting to C<[@ARGV]>, used by L</args> and L</opts>.

I<Since C<1.68>>

=over 4

=item init example 1

  # given: synopsis

  package main;

  my $init = $cli->init;

  # ["example", "--help"]

=back

=cut

=head2 logs

  logs(Logs $logs) (Logs)

The logs attribute holds a L<Venus::Logs> object.

I<Since C<1.71>>

=over 4

=item logs example 1

  # given: synopsis

  package main;

  my $logs = $cli->logs;

=back

=cut

=head2 opts

  opts(Opts $opts) (Opts)

The opts attribute holds a L<Venus::Opts> object.

I<Since C<1.71>>

=over 4

=item opts example 1

  # given: synopsis

  package main;

  my $opts = $cli->opts;

=back

=cut

=head2 path

  path(Path $data) (Path)

The path attribute holds a L<Venus::Path> object, meant to represent the path
of the file where the CLI executable and POD is.

I<Since C<1.71>>

=over 4

=item path example 1

  # given: synopsis

  package main;

  my $path = $cli->path;

=back

=cut

=head2 vars

  vars(Vars $vars) (Vars)

The vars attribute holds a L<Venus::Vars> object.

I<Since C<1.71>>

=over 4

=item vars example 1

  # given: synopsis

  package main;

  my $vars = $cli->vars;

=back

=cut

=head1 INHERITS

This package inherits behaviors from:

L<Venus::Kind::Utility>

=cut

=head1 INTEGRATES

This package integrates behaviors from:

L<Venus::Role::Optional>

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 arg

  arg(Str $pos) (Str)

The arg method returns the element specified by the index in the unnamed
arguments list, i.e. arguments not parsed as options.

I<Since C<1.68>>

=over 4

=item arg example 1

  # given: synopsis

  package main;

  my $arg = $cli->arg;

  # undef

=back

=over 4

=item arg example 2

  # given: synopsis

  package main;

  my $arg = $cli->arg(0);

  # "example"

=back

=cut

=head2 execute

  execute() (Any)

The execute method is the default entrypoint of the program and runs the
application.

I<Since C<1.68>>

=over 4

=item execute example 1

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new([]);

  # e.g.

  # sub execute {
  #   my ($self) = @_;
  #
  #   return $self->opt('help') ? $self->okay : $self->fail;
  # }

  # my $result = $cli->execute;

  # ...

=back

=over 4

=item execute example 2

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['--help']);

  # e.g.

  # sub execute {
  #   my ($self) = @_;
  #
  #   return $self->opt('help') ? $self->okay : $self->fail;
  # }

  # my $result = $cli->execute;

  # ...

=back

=cut

=head2 exit

  exit(Int $code, Str|CodeRef $code, Any @args) (Any)

The exit method exits the program using the exit code provided. The exit code
defaults to C<0>. Optionally, you can dispatch before exiting by providing a
method name or coderef, and arguments.

I<Since C<1.68>>

=over 4

=item exit example 1

  # given: synopsis

  package main;

  my $exit = $cli->exit;

  # ()

=back

=over 4

=item exit example 2

  # given: synopsis

  package main;

  my $exit = $cli->exit(0);

  # ()

=back

=over 4

=item exit example 3

  # given: synopsis

  package main;

  my $exit = $cli->exit(1);

  # ()

=back

=over 4

=item exit example 4

  # given: synopsis

  package main;

  # my $exit = $cli->exit(1, 'log_info', 'Something failed!');

  # ()

=back

=cut

=head2 fail

  fail(Str|CodeRef $code, Any @args) (Any)

The fail method exits the program with the exit code C<1>. Optionally, you can
dispatch before exiting by providing a method name or coderef, and arguments.

I<Since C<1.68>>

=over 4

=item fail example 1

  # given: synopsis

  package main;

  my $fail = $cli->fail;

  # ()

=back

=over 4

=item fail example 2

  # given: synopsis

  package main;

  # my $fail = $cli->fail('log_info', 'Something failed!');

  # ()

=back

=cut

=head2 help

  help(Str @data) (Str)

The help method returns the POD found in the file specified by the L</podfile>
method, defaulting to the C<=head1 OPTIONS> section.

I<Since C<1.68>>

=over 4

=item help example 1

  # given: synopsis

  package main;

  my $help = $cli->help;

  # ""

=back

=over 4

=item help example 2

  # given: synopsis

  package main;

  # my $help = $cli->help('head1', 'NAME');

  #  "Example"

=back

=cut

=head2 log_debug

  log_debug(Str @data) (Log)

The log_debug method logs C<debug> information.

I<Since C<1.68>>

=over 4

=item log_debug example 1

  # given: synopsis

  package main;

  # $cli->logs->level('trace');

  # my $log = $cli->log_debug(time, 'Something failed!');

  # "0000000000 Something failed!"

=back

=cut

=head2 log_error

  log_error(Str @data) (Log)

The log_error method logs C<error> information.

I<Since C<1.68>>

=over 4

=item log_error example 1

  # given: synopsis

  package main;

  # $cli->logs->level('trace');

  # my $log = $cli->log_error(time, 'Something failed!');

  # "0000000000 Something failed!"

=back

=cut

=head2 log_fatal

  log_fatal(Str @data) (Log)

The log_fatal method logs C<fatal> information.

I<Since C<1.68>>

=over 4

=item log_fatal example 1

  # given: synopsis

  package main;

  # $cli->logs->level('trace');

  # my $log = $cli->log_fatal(time, 'Something failed!');

  # "0000000000 Something failed!"

=back

=cut

=head2 log_info

  log_info(Str @data) (Log)

The log_info method logs C<info> information.

I<Since C<1.68>>

=over 4

=item log_info example 1

  # given: synopsis

  package main;

  # $cli->logs->level('trace');

  # my $log = $cli->log_info(time, 'Something failed!');

  # "0000000000 Something failed!"

=back

=cut

=head2 log_trace

  log_trace(Str @data) (Log)

The log_trace method logs C<trace> information.

I<Since C<1.68>>

=over 4

=item log_trace example 1

  # given: synopsis

  package main;

  # $cli->logs->level('trace');

  # my $log = $cli->log_trace(time, 'Something failed!');

  # "0000000000 Something failed!"

=back

=cut

=head2 log_warn

  log_warn(Str @data) (Log)

The log_warn method logs C<warn> information.

I<Since C<1.68>>

=over 4

=item log_warn example 1

  # given: synopsis

  package main;

  # $cli->logs->level('trace');

  # my $log = $cli->log_warn(time, 'Something failed!');

  # "0000000000 Something failed!"

=back

=cut

=head2 okay

  okay(Str|CodeRef $code, Any @args) (Any)

The okay method exits the program with the exit code C<0>. Optionally, you can
dispatch before exiting by providing a method name or coderef, and arguments.

I<Since C<1.68>>

=over 4

=item okay example 1

  # given: synopsis

  package main;

  my $okay = $cli->okay;

  # ()

=back

=over 4

=item okay example 2

  # given: synopsis

  package main;

  # my $okay = $cli->okay('log_info', 'Something worked!');

  # ()

=back

=cut

=head2 opt

  opt(Str $name) (Str)

The opt method returns the named option specified by the L</options> method.

I<Since C<1.68>>

=over 4

=item opt example 1

  # given: synopsis

  package main;

  my $opt = $cli->opt;

  # undef

=back

=over 4

=item opt example 2

  # given: synopsis

  package main;

  my $opt = $cli->opt('help');

  # 1

=back

=cut

=head2 options

  options() (ArrayRef)

The options method returns the list of L<Getopt::Long> definitions.

I<Since C<1.68>>

=over 4

=item options example 1

  # given: synopsis

  package main;

  my $options = $cli->options;

  # ['help|h']

=back

=cut