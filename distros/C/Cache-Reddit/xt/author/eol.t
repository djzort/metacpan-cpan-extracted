use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.17

use Test::More 0.88;
use Test::EOL;

my @files = (
    'lib/Cache/Reddit.pm',
    'lib/Cache/Reddit/Bleach.pm',
    't/01_basic.t'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;
