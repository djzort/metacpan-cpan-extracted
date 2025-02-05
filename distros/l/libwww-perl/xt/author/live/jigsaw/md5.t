use strict;
use warnings;
use Test::More;
use Test::RequiresInternet ('jigsaw.w3.org' => 443);

use Digest::MD5 qw(md5_base64);
use HTTP::Request;
use LWP::UserAgent;

my $tests = 5;

plan tests => $tests;

SKIP: {
    skip 'LIVE_JIGSAW_TESTS not enabled', $tests if $ENV{NO_JIGSAW};

    my $ua = LWP::UserAgent->new(keep_alive => 1);

    my $req = HTTP::Request->new(GET => "https://jigsaw.w3.org/HTTP/h-content-md5.html");
    $req->header("TE", "deflate");

    my $res = $ua->request($req);
    isa_ok($res, 'HTTP::Response', 'request: Got a proper response');

    is($res->header('Content-MD5'), md5_base64($res->content).'==', 'Content-MD5 header matches content');

    my $etag = $res->header("etag");
    $req->header("If-None-Match" => $etag);

    $res = $ua->request($req);
    isa_ok($res, 'HTTP::Response', 'request: Got a proper response');
    is($res->code, 304, 'response code: 304');
    is($res->header('Client-Response-Num'), 2, 'Client-Response-Num header is 2');
}
