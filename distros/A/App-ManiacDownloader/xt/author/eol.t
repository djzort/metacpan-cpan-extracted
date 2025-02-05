use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.19

use Test::More 0.88;
use Test::EOL;

my @files = (
    'bin/mdown',
    'lib/App/ManiacDownloader.pm',
    'lib/App/ManiacDownloader/_BytesDownloaded.pm',
    'lib/App/ManiacDownloader/_File.pm',
    'lib/App/ManiacDownloader/_SegmentTask.pm',
    't/00-compile.t'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;
