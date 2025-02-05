use strict;
use warnings;
package JSON::Schema::Modern::Error;
# vim: set ts=8 sts=2 sw=2 tw=100 et :
# ABSTRACT: Contains a single error from a JSON Schema evaluation

our $VERSION = '0.560';

use 5.020;
use Moo;
use strictures 2;
use experimental qw(signatures postderef);
use if "$]" >= 5.022, experimental => 're_strict';
no if "$]" >= 5.031009, feature => 'indirect';
no if "$]" >= 5.033001, feature => 'multidimensional';
no if "$]" >= 5.033006, feature => 'bareword_filehandles';
use Safe::Isa;
use JSON::PP ();
use MooX::TypeTiny;
use Types::Standard qw(Str Undef InstanceOf Enum);
use namespace::clean;

use overload
  '""' => sub { $_[0]->stringify };

has [qw(
  instance_location
  keyword_location
  error
)] => (
  is => 'ro',
  isa => Str,
  required => 1,
);

has absolute_keyword_location => (
  is => 'ro',
  isa => InstanceOf['Mojo::URL'],
  coerce => sub { $_[0]->$_isa('Mojo::URL') ? $_[0] : Mojo::URL->new($_[0]) },
);

has keyword => (
  is => 'ro',
  isa => Str|Undef,
  required => 1,
);

has exception => (
  is => 'ro',
  isa => InstanceOf['JSON::PP::Boolean'],
  coerce => sub { $_[0] ? JSON::PP::true : JSON::PP::false },
);

has mode => (
  is => 'rw',
  isa => Enum[qw(traverse evaluate)],
);

sub TO_JSON ($self) {
  return +{
    # note that locations are JSON pointers, not uri fragments!
    instanceLocation => $self->instance_location,
    keywordLocation => $self->keyword_location,
    !defined($self->absolute_keyword_location) ? ()
      : ( absoluteKeywordLocation => $self->absolute_keyword_location->to_string ),
    error => $self->error,  # TODO: allow localization
  };
}

sub stringify ($self) {
  ($self->mode//'evaluate') eq 'traverse'
    ? '\''.$self->keyword_location.'\': '.$self->error
    : '\''.$self->instance_location.'\': '.$self->error;
}

sub dump ($self) {
  my $encoder = JSON::MaybeXS->new(utf8 => 0, convert_blessed => 1, canonical => 1, pretty => 1);
  $encoder->indent_length(2) if $encoder->can('indent_length');
  $encoder->encode($self);
}

1;

__END__

=pod

=encoding UTF-8

=for stopwords schema fragmentless

=head1 NAME

JSON::Schema::Modern::Error - Contains a single error from a JSON Schema evaluation

=head1 VERSION

version 0.560

=head1 SYNOPSIS

  use JSON::Schema::Modern;
  my $js = JSON::Schema::Modern->new;
  my $result = $js->evaluate($data, $schema);
  my @errors = $result->errors;

  my $message = $errors[0]->error;
  my $instance_location = $errors[0]->instance_location;

  my $errors_encoded = encode_json(\@errors);

=head1 DESCRIPTION

An instance of this class holds one error from evaluating a JSON Schema with
L<JSON::Schema::Modern>.

=head1 ATTRIBUTES

=head2 keyword

The keyword that produced the error; might be C<undef>.

=head2 instance_location

The path in the instance where the error occurred; encoded as per the JSON Pointer specification
(L<RFC 6901|https://tools.ietf.org/html/rfc6901>).

=head2 keyword_location

The schema path taken during evaluation to arrive at the error; encoded as per the JSON Pointer
specification (L<RFC 6901|https://tools.ietf.org/html/rfc6901>).

=head2 absolute_keyword_location

The canonical URI or URI reference of the location in the schema where the error occurred; not
defined, if there is no base URI for the schema and no C<$ref> was followed. Note that this is not
a fragmentless URI in most cases, as the indicated error will occur at a path
below the position where the most recent identifier had been declared in the schema. Further, if the
schema never declared an absolute base URI (containing a scheme), this URI won't be absolute either.

=head2 error

The actual error string.

=head2 exception

Indicates the error's severity is sufficient to stop evaluation.

=head1 METHODS

=for Pod::Coverage stringify mode

=head2 TO_JSON

Returns a data structure suitable for serialization. Corresponds to one output unit as specified in
L<https://json-schema.org/draft/2019-09/json-schema-core.html#rfc.section.10.4.2> and
L<https://json-schema.org/draft/2019-09/output/schema>, except that C<instanceLocation> and
C<keywordLocation> are JSON pointers, B<not> URI fragments. (See the
C<strict_basic> L<JSON::Schema::Modern/output_format>
if the distinction is important to you.)

=head2 dump

Returns a JSON string representing the error object, according to
the L<specification|https://json-schema.org/draft/2019-09/json-schema-core.html#rfc.section.10>.

=for stopwords OpenAPI

=head1 SUPPORT

Bugs may be submitted through L<https://github.com/karenetheridge/JSON-Schema-Modern/issues>.

I am also usually active on irc, as 'ether' at C<irc.perl.org> and C<irc.libera.chat>.

You can also find me on the L<JSON Schema Slack server|https://json-schema.slack.com> and L<OpenAPI Slack
server|https://open-api.slack.com>, which are also great resources for finding help.

=head1 AUTHOR

Karen Etheridge <ether@cpan.org>

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2020 by Karen Etheridge.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
