#!/usr/bin/env perl
use strict;

use Test::More tests => 10;

use File::Path qw(rmtree);
use File::Spec::Functions qw(catdir catfile rel2abs splitdir);

#----------------------------------------------------------------------
# Load package

my @path = splitdir(rel2abs($0));
pop(@path);
pop(@path);

my $lib = catdir(@path, 'lib');
unshift(@INC, $lib);

$lib = catdir(@path, 't');
unshift(@INC, $lib);

eval "use App::Followme::FIO";
require App::Followme::FileData;

my $test_dir = catdir(@path, 'test');
rmtree($test_dir) if -e $test_dir;

mkdir $test_dir or die $!;
chmod 0755, $test_dir;
chdir($test_dir) or die $!;

#----------------------------------------------------------------------
# Create object

my %configuration = (top_directory => $test_dir,
                     base_directory => $test_dir,
                     title_template => '<h1></h1>',
                    );

my $obj = App::Followme::FileData->new(%configuration);

isa_ok($obj, "App::Followme::FileData"); # test 1
can_ok($obj, qw(new build)); # test 2

#----------------------------------------------------------------------
# Test file variables

do {
    my @code;
    my @count = qw(one two three);

    $code[0] = <<'EOQ';
-----
title: The Page %%
author: Bernie Simon
-----
<h1>Count %%</h1>

<p>This is the description. This is the rest of the content.</p>
EOQ

    $code[1] = <<'EOQ';
<h1>Count %%</h1>

<p>This is the description. This is the rest of the content.</p>
EOQ

    $code[2] = <<'EOQ';
<p>This is the description. This is the rest of the content.</p>
EOQ

    for (my $i=0 ; $i < 3; ++ $i) {
        my $output = $code[$i];
        my $kount = ucfirst($count[$i]);
        $output =~ s/%%/$kount/g;

        my $filename = catfile($test_dir, "$count[$i].txt");
        fio_write_page($filename, $output);
    }

    my $filename = catfile($test_dir, 'one.txt');
    my %data = $obj->fetch_data('title', $filename);

    is($data{description}, 'This is the description.',
       'get description from content'); # test 3

    is($data{body}, "<p>This is the description. This is the rest of the content.</p>\n",
       'get body from content'); #test 4

    is($data{title}, 'The Page One', 'get title from metadata'); # test 5
    is($data{author}, 'Bernie Simon', 'get author from metadata'); # test 6

    my $data = \%data;
    my $sorted_order = 1;
    $obj->{sort_field} = 'title';
    my $sorted_data = $obj->format($sorted_order, $data);
    
    is($sorted_data->{title}, 'page one', 'format sortable title'); # test 7
    is($sorted_data->{author}, 'simon bernie', 'format sortable author'); # test 8

    $filename = catfile($test_dir, 'two.txt');
    %data = $obj->fetch_data('title', $filename);
    is($data{title}, 'Count Two', 'get title from content'); # test 9

    $filename = catfile($test_dir, 'three.txt');
    %data = $obj->fetch_data('title', $filename);
    is($data{title}, 'Three', 'get title from filename'); # test 10
};
