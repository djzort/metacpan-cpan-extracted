use strictures 2;
use 5.020;
use experimental qw(signatures postderef);
use if "$]" >= 5.022, experimental => 're_strict';
no if "$]" >= 5.031009, feature => 'indirect';
no if "$]" >= 5.033001, feature => 'multidimensional';
no if "$]" >= 5.033006, feature => 'bareword_filehandles';
use open ':std', ':encoding(UTF-8)'; # force stdin, stdout, stderr into utf8

use Test::More 0.88;
use if $ENV{AUTHOR_TESTING}, 'Test::Warnings';
use Test::Deep;
use Data::Dumper;
use JSON::Schema::Modern;
use lib 't/lib';
use Helper;

sub serialize { Data::Dumper->new([ $_[0] ])->Indent(0)->Terse(1)->Sortkeys(1)->Dump }

my ($test_schema, $failure_result);

subtest 'strict booleans (default)' => sub {
  my $js = JSON::Schema::Modern->new;
  cmp_deeply(
    $js->evaluate($_, { type => 'boolean' })->TO_JSON,
    { valid => true },
    'in data, '.serialize($_).' is a boolean',
  )
  foreach (
    false,
    true,
  );

  cmp_deeply(
    $js->evaluate($_->[1], { type => 'boolean' })->TO_JSON,
    {
      valid => false,
      errors => [
        {
          instanceLocation => '',
          keywordLocation => '/type',
          error => 'got '.$_->[0].', not boolean',
        },
      ],
    },
    'correct error generated from type for '.serialize($_->[1]),
  )
  foreach (
    [ null => undef ],
    [ integer => 0 ],
    [ integer => 1 ],
    [ string => '0' ],
    [ string => '1' ],
    [ string => 'false' ],
    [ string => 'true' ],
    [ 'reference to SCALAR' => \0 ],
    [ 'reference to SCALAR' => \1 ],
  );

  cmp_deeply(
    $js->evaluate(
      $_->[1],
      $test_schema = {
        allOf => [ { type => 'boolean' }, { type => ['boolean','object'] } ],
        anyOf => [ { const => false }, { const => true } ],
        enum => [ false, true ],
      }
    )->TO_JSON,
    $failure_result = {
      valid => false,
      errors => [
        {
          instanceLocation => '',
          keywordLocation => '/allOf/0/type',
          error => 'got '.$_->[0].', not boolean',
        },
        {
          instanceLocation => '',
          keywordLocation => '/allOf/1/type',
          error => 'got '.$_->[0].', not one of boolean, object',
        },
        {
          instanceLocation => '',
          keywordLocation => '/allOf',
          error => 'subschemas 0, 1 are not valid',
        },
        {
          instanceLocation => '',
          keywordLocation => '/anyOf/0/const',
          error => 'value does not match',
        },
        {
          instanceLocation => '',
          keywordLocation => '/anyOf/1/const',
          error => 'value does not match',
        },
        {
          instanceLocation => '',
          keywordLocation => '/anyOf',
          error => 'no subschemas are valid',
        },
        {
          instanceLocation => '',
          keywordLocation => '/enum',
          error => 'value does not match',
        },
      ],
    },
    'in data, '.serialize($_->[1]).' not is a boolean',
  )
  foreach (
    [ null => undef ],
    [ integer => 0 ],
    [ integer => 1 ],
    [ string => '0' ],
    [ string => '1' ],
    [ string => 'false' ],
    [ string => 'true' ],
    [ 'reference to SCALAR' => \0 ],
    [ 'reference to SCALAR' => \1 ],
  );
};

subtest 'scalarref_booleans = 1' => sub {
  my $js = JSON::Schema::Modern->new(scalarref_booleans => 1);
  cmp_deeply(
    $js->evaluate($_, $test_schema)->TO_JSON,
    { valid => true },
    'in data, '.serialize($_).' is a boolean',
  )
  foreach (
    false,
    true,
    \0,
    \1,
  );

  cmp_deeply(
    $js->evaluate($_->[1], $test_schema)->TO_JSON,
    {
      valid => false,
      errors => [
        do {
          my ($type, $value) = $_->@*;
          map +{
            $_->%*,
            $_->{keywordLocation} =~ /\/type$/ ? (error => $_->{error} =~ s/^got .*, not/got $type, not/r) : (),
          }, $failure_result->{errors}->@*,
        },
      ],
    },
    'correct error generated from type for '.serialize($_),
  )
  foreach (
    [ null => undef ],
    [ integer => 0 ],
    [ integer => 1 ],
    [ string => '0' ],
    [ string => '1' ],
    [ string => 'false' ],
    [ string => 'true' ],
  );

  cmp_deeply(
    $js->evaluate(
      [
        undef,
        0,
        1,
        '0',
        '1',
        'false',
        'true',
        \0,
        \1,
      ],
      { uniqueItems => true },
    )->TO_JSON,
    { valid => true },
    'items are all considered unique when types differ, even when perl treats them similarly',
  );

  cmp_deeply(
    $js->evaluate($_, { uniqueItems => true })->TO_JSON,
    {
      valid => false,
      errors => [
        {
          instanceLocation => '',
          keywordLocation => '/uniqueItems',
          error => 'items at indices 0 and 1 are not unique',
        },
      ],
    },
    'scalarrefs compare as identical to their counterpart booleans',
  )
  foreach (
    [ \0, false ],
    [ false, \0 ],
    [ \1, true ],
    [ true, \1 ],
  );
};

done_testing;
