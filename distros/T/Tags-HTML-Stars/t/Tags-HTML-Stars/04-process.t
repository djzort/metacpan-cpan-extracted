use strict;
use warnings;

use Tags::HTML::Stars;
use Tags::Output::Raw;
use Test::More 'tests' => 3;
use Test::NoWarnings;

# Test.
my $tags = Tags::Output::Raw->new;
my $obj = Tags::HTML::Stars->new(
	'tags' => $tags,
);
$obj->process({
	1 => 'full',
	2 => 'half',
	3 => 'nothing',
});
my $ret = $tags->flush(1);
my $right_ret = <<'END';
<div><img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwcHgiIGhlaWdodD0iMjc1cHgiIHZpZXdCb3g9IjAgMCAzMDAgMjc1IiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZlcnNpb249IjEuMSI+CiAgPHBvbHlnb24gZmlsbD0iI2ZkZmYwMCIgc3Ryb2tlPSIjNjA1YTAwIiBzdHJva2Utd2lkdGg9IjE1IiBwb2ludHM9IjE1MCwyNSAxNzksMTExIDI2OSwxMTEgMTk3LDE2NSAyMjMsMjUxIDE1MCwyMDAgNzcsMjUxIDEwMywxNjUgMzEsMTExIDEyMSwxMTEiIC8+Cjwvc3ZnPgo="></img><img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwcHgiIGhlaWdodD0iMjc1cHgiIHZpZXdCb3g9IjAgMCAzMDAgMjc1IiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZlcnNpb249IjEuMSI+CiAgPGNsaXBQYXRoIGlkPSJlbXB0eSI+PHJlY3QgeD0iMTUwIiB5PSIwIiB3aWR0aD0iMTUwIiBoZWlnaHQ9IjI3NSIgLz48L2NsaXBQYXRoPgogIDxjbGlwUGF0aCBpZD0iZmlsbGVkIj48cmVjdCB4PSIwIiB5PSIwIiB3aWR0aD0iMTUwIiBoZWlnaHQ9IjI3NSIgLz48L2NsaXBQYXRoPgogIDxwb2x5Z29uIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzgwODA4MCIgc3Ryb2tlLXdpZHRoPSIxNSIgc3Ryb2tlLW9wYWNpdHk9IjAuMzc2NDcwNjAiIHBvaW50cz0iMTUwLDI1IDE3OSwxMTEgMjY5LDExMSAxOTcsMTY1IDIyMywyNTEgMTUwLDIwMCA3NywyNTEgMTAzLDE2NSAzMSwxMTEgMTIxLDExMSIgY2xpcC1wYXRoPSJ1cmwoI2VtcHR5KSIgLz4KICA8cG9seWdvbiBmaWxsPSIjZmRmZjAwIiBzdHJva2U9IiM2MDVhMDAiIHN0cm9rZS13aWR0aD0iMTUiIHBvaW50cz0iMTUwLDI1IDE3OSwxMTEgMjY5LDExMSAxOTcsMTY1IDIyMywyNTEgMTUwLDIwMCA3NywyNTEgMTAzLDE2NSAzMSwxMTEgMTIxLDExMSIgY2xpcC1wYXRoPSJ1cmwoI2ZpbGxlZCkiIC8+Cjwvc3ZnPgo="></img><img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwcHgiIGhlaWdodD0iMjc1cHgiIHZpZXdCb3g9IjAgMCAzMDAgMjc1IiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZlcnNpb249IjEuMSI+CiAgPHBvbHlnb24gZmlsbD0ibm9uZSIgc3Ryb2tlPSIjODA4MDgwIiBzdHJva2Utd2lkdGg9IjE1IiBzdHJva2Utb3BhY2l0eT0iMC4zNzY0NzA2MCIgcG9pbnRzPSIxNTAsMjUgMTc5LDExMSAyNjksMTExIDE5NywxNjUgMjIzLDI1MSAxNTAsMjAwIDc3LDI1MSAxMDMsMTY1IDMxLDExMSAxMjEsMTExIiAvPgo8L3N2Zz4K"></img></div>
END
chomp $right_ret;
is($ret, $right_ret, '3 stars (full, half, nothing)');

# Test.
$tags = Tags::Output::Raw->new;
$obj = Tags::HTML::Stars->new(
	'star_width' => '10px',
	'tags' => $tags,
);
$obj->process({
	1 => 'full',
	2 => 'half',
	3 => 'nothing',
});
$ret = $tags->flush(1);
$right_ret = <<'END';
<div><img style="width: 10px;" src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwcHgiIGhlaWdodD0iMjc1cHgiIHZpZXdCb3g9IjAgMCAzMDAgMjc1IiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZlcnNpb249IjEuMSI+CiAgPHBvbHlnb24gZmlsbD0iI2ZkZmYwMCIgc3Ryb2tlPSIjNjA1YTAwIiBzdHJva2Utd2lkdGg9IjE1IiBwb2ludHM9IjE1MCwyNSAxNzksMTExIDI2OSwxMTEgMTk3LDE2NSAyMjMsMjUxIDE1MCwyMDAgNzcsMjUxIDEwMywxNjUgMzEsMTExIDEyMSwxMTEiIC8+Cjwvc3ZnPgo="></img><img style="width: 10px;" src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwcHgiIGhlaWdodD0iMjc1cHgiIHZpZXdCb3g9IjAgMCAzMDAgMjc1IiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZlcnNpb249IjEuMSI+CiAgPGNsaXBQYXRoIGlkPSJlbXB0eSI+PHJlY3QgeD0iMTUwIiB5PSIwIiB3aWR0aD0iMTUwIiBoZWlnaHQ9IjI3NSIgLz48L2NsaXBQYXRoPgogIDxjbGlwUGF0aCBpZD0iZmlsbGVkIj48cmVjdCB4PSIwIiB5PSIwIiB3aWR0aD0iMTUwIiBoZWlnaHQ9IjI3NSIgLz48L2NsaXBQYXRoPgogIDxwb2x5Z29uIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzgwODA4MCIgc3Ryb2tlLXdpZHRoPSIxNSIgc3Ryb2tlLW9wYWNpdHk9IjAuMzc2NDcwNjAiIHBvaW50cz0iMTUwLDI1IDE3OSwxMTEgMjY5LDExMSAxOTcsMTY1IDIyMywyNTEgMTUwLDIwMCA3NywyNTEgMTAzLDE2NSAzMSwxMTEgMTIxLDExMSIgY2xpcC1wYXRoPSJ1cmwoI2VtcHR5KSIgLz4KICA8cG9seWdvbiBmaWxsPSIjZmRmZjAwIiBzdHJva2U9IiM2MDVhMDAiIHN0cm9rZS13aWR0aD0iMTUiIHBvaW50cz0iMTUwLDI1IDE3OSwxMTEgMjY5LDExMSAxOTcsMTY1IDIyMywyNTEgMTUwLDIwMCA3NywyNTEgMTAzLDE2NSAzMSwxMTEgMTIxLDExMSIgY2xpcC1wYXRoPSJ1cmwoI2ZpbGxlZCkiIC8+Cjwvc3ZnPgo="></img><img style="width: 10px;" src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwcHgiIGhlaWdodD0iMjc1cHgiIHZpZXdCb3g9IjAgMCAzMDAgMjc1IiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZlcnNpb249IjEuMSI+CiAgPHBvbHlnb24gZmlsbD0ibm9uZSIgc3Ryb2tlPSIjODA4MDgwIiBzdHJva2Utd2lkdGg9IjE1IiBzdHJva2Utb3BhY2l0eT0iMC4zNzY0NzA2MCIgcG9pbnRzPSIxNTAsMjUgMTc5LDExMSAyNjksMTExIDE5NywxNjUgMjIzLDI1MSAxNTAsMjAwIDc3LDI1MSAxMDMsMTY1IDMxLDExMSAxMjEsMTExIiAvPgo8L3N2Zz4K"></img></div>
END
chomp $right_ret;
is($ret, $right_ret, '3 stars (full, half, nothing, width=10px)');
