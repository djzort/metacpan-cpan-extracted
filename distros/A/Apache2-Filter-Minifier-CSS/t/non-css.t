use strict;
use warnings FATAL => 'all';
use if $ENV{AUTOMATED_TESTING}, 'Test::DiagINC'; use Apache::Test;
use Apache::TestRequest;
use Apache::TestUtil qw(t_cmp);
use lib 't';
use File::Slurp qw(slurp);

# Make sure that non-CSS files get passed through unaltered
plan tests => 1, need_lwp;

# Non-CSS file should get passed through unaltered
non_css_unaltered: {
    my $body = GET_BODY '/test.txt';
    my $orig = slurp( 't/htdocs/test.txt' );
    ok( t_cmp($body, $orig) );
}
