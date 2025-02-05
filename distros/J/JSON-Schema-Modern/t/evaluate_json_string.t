use strictures 2;
use 5.020;
use experimental qw(signatures postderef);
use if "$]" >= 5.022, experimental => 're_strict';
no if "$]" >= 5.031009, feature => 'indirect';
no if "$]" >= 5.033001, feature => 'multidimensional';
no if "$]" >= 5.033006, feature => 'bareword_filehandles';
use if "$]" >= 5.022, experimental => 're_strict';
use open ':std', ':encoding(UTF-8)'; # force stdin, stdout, stderr into utf8

use Test::More 0.88;
use if $ENV{AUTHOR_TESTING}, 'Test::Warnings';
use Test::Fatal;
use Test::Deep;
use JSON::Schema::Modern;

use lib 't/lib';
use Helper;

my $js = JSON::Schema::Modern->new;

like(ref($js->_json_decoder), qr/^(?:Cpanel::JSON::XS|JSON::PP)$/, 'we have a JSON decoder');

is(
  exception {
    ok($js->evaluate_json_string('true', {}), 'json data "true" is evaluated successfully');
  },
  undef,
  'no exceptions in evaluate_json_string on good json',
);

is(
  exception {
    cmp_deeply(
      $js->evaluate_json_string('blargh', {})->TO_JSON,
      {
        valid => false,
        errors => [
          {
            instanceLocation => '',
            keywordLocation => '',
            error => re(qr/malformed JSON string/),
          },
        ],
      },
      'result object serializes correctly',
      'evaluating bad json data returns false, with error',
    );

  },
  undef,
  'no exceptions in evaluate_json_string on bad json',
);

done_testing;
