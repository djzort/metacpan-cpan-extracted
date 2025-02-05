#!/usr/bin/env perl
use strict;

use File::Path qw(rmtree);
use File::Spec::Functions qw(catdir catfile rel2abs splitdir);

use Test::More tests => 6;

use lib '../..';

#----------------------------------------------------------------------
# Load package

my @path = splitdir(rel2abs($0));
pop(@path);
pop(@path);

my $lib = catdir(@path, 'lib');
unshift(@INC, $lib);

eval "use App::Followme::FIO";
require App::Followme::WebData;

my $test_dir = catdir(@path, 'test');

rmtree($test_dir) if -e $test_dir;
mkdir $test_dir or die $!;
chmod 0755, $test_dir;
chdir $test_dir or die $!;

#----------------------------------------------------------------------
# Create test data

my $index = <<'EOQ';
<html>
<head>
<meta name="robots" content="archive">
<!-- section meta -->
<title>Home Page</title>
<meta name="description" content="This is a test." />
<meta name="date" content="2015-11-22T20:23:13" />
<meta name="author" content="Bernie Simon" />
<!-- endsection meta -->
</head>
<body>
<!-- section primary -->
<h1>Home</h1>

<p>This is not a test.</p>
<!-- endsection primary -->
<!--section secondary-->
<ul>
<li><a href="index.html">Home</a></li>
</ul>
<!-- endsection secondary -->
</body>
</html>,
EOQ

my $index_name = catfile($test_dir, 'index.html');
fio_write_page($index_name, $index);

#----------------------------------------------------------------------
# Create object

my %configuration = (top_directory => $test_dir,
                     base_directory => $test_dir,
                    );

my $obj = App::Followme::WebData->new(%configuration);

isa_ok($obj, "App::Followme::WebData"); # test 1
can_ok($obj, qw(new build)); # test 2

#----------------------------------------------------------------------

my %data = $obj->fetch_data('title', $index_name);

is($data{title}, 'Home Page', 'get title'); # test 3
is($data{description}, 'This is a test.', 'get description'); # test 4
is($data{date}, '2015-11-22T20:23:13', 'get date'); # test 5
is($data{author}, 'Bernie Simon', 'get author'); # test 6
