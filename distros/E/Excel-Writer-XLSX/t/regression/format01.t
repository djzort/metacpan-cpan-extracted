###############################################################################
#
# Tests the output of Excel::Writer::XLSX against Excel generated files.
#
# Copyright 2000-2023, John McNamara, jmcnamara@cpan.org
#

use lib 't/lib';
use TestFunctions qw(_compare_xlsx_files _is_deep_diff);
use strict;
use warnings;

use Test::More tests => 1;

###############################################################################
#
# Tests setup.
#
my $filename     = 'format01.xlsx';
my $dir          = 't/regression/';
my $got_filename = $dir . "ewx_$filename";
my $exp_filename = $dir . 'xlsx_files/' . $filename;

my $ignore_members  = [];
my $ignore_elements = {};


###############################################################################
#
# Test the creation of a simple Excel::Writer::XLSX file with unused formats.
#
use Excel::Writer::XLSX;

my $workbook   = Excel::Writer::XLSX->new( $got_filename );
my $worksheet1 = $workbook->add_worksheet();
my $worksheet2 = $workbook->add_worksheet('Data Sheet');
my $worksheet3 = $workbook->add_worksheet();

my $unused1 = $workbook->add_format( bold   => 1 );
my $bold    = $workbook->add_format( bold   => 1 );
my $unused2 = $workbook->add_format( bold   => 1 );
my $unued3 = $workbook->add_format( italic => 1 );

$worksheet1->write( 'A1', 'Foo' );
$worksheet1->write( 'A2', 123 );

$worksheet3->write( 'B2', 'Foo' );
$worksheet3->write( 'B3', 'Bar', $bold );
$worksheet3->write( 'C4', 234 );

$workbook->close();


###############################################################################
#
# Compare the generated and existing Excel files.
#

my ( $got, $expected, $caption ) = _compare_xlsx_files(

    $got_filename,
    $exp_filename,
    $ignore_members,
    $ignore_elements,
);

_is_deep_diff( $got, $expected, $caption );


###############################################################################
#
# Cleanup.
#
unlink $got_filename;

__END__



