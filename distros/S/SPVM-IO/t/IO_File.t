use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";

BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build" };

use SPVM 'TestCase::IO::File';

use TestFile;

sub slurp_binmode {
  my ($output_file) = @_;
  
  open my $fh, '<', $output_file
    or die "Can't open file $output_file:$!";
  
  binmode $fh;
  
  my $output = do { local $/; <$fh> };
  
  return $output;
}

# Start objects count
my $start_memory_blocks_count = SPVM::get_memory_blocks_count();

# Copy test_files to test_files_tmp with replacing os newline
TestFile::copy_test_files_tmp();

my $test_dir = "$FindBin::Bin";

# flush
{
  # test_flush
  {
    my $file = "$test_dir/test_files_tmp/io_file_test_flush.txt";
    ok(SPVM::TestCase::IO::File->test_flush($file));
    my $output = slurp_binmode($file);
    is($output, 'Hello');
  }
}

# print
{
  # test_print
  {
    my $file = "$test_dir/test_files_tmp/io_file_test_print.txt";
    ok(SPVM::TestCase::IO::File->test_print($file));
    my $output = slurp_binmode($file);
    is($output, 'Hello');
  }

  # test_print_newline
  {
    my $file = "$test_dir/test_files_tmp/io_file_test_print_newline.txt";
    ok(SPVM::TestCase::IO::File->test_print_newline($file));
    my $output = slurp_binmode($file);
    is($output, "\x0A");
  }

  # test_print_long_lines
  {
    my $file = "$test_dir/test_files_tmp/io_file_test_print_long_lines.txt";
    ok(SPVM::TestCase::IO::File->test_print_long_lines($file));
    my $output = slurp_binmode($file);
    is($output, "AAAAAAAAAAAAA\x0ABBBBBBBBBBBBBBBBBBB\x0ACCCCCCCCCCCCCCCCCCCCCCCCCCC\x0ADDDDDDDDDDDDDDDDDDDDDDDDD\x0AEEEEEEEEEEEEEEEEEEEEEE\x0AFFFFFFFFFFFFFF\x0A");
  }
}

# open
{
  my $sp_file = SPVM::new_string("$test_dir/test_files_tmp/fread.txt");
  ok(SPVM::TestCase::IO::File->test_open($sp_file));
}

# read
{
  my $sp_file = SPVM::new_string("$test_dir/test_files_tmp/fread.txt");
  ok(SPVM::TestCase::IO::File->test_read($sp_file));
}

# getline
{
  {
    my $sp_file = SPVM::new_string("$test_dir/test_files_tmp/fread.txt");
    ok(SPVM::TestCase::IO::File->test_getline($sp_file));
  }
  {
    my $sp_file = SPVM::new_string("$test_dir/test_files_tmp/fread.txt");
    ok(SPVM::TestCase::IO::File->test_getline_while($sp_file));
  }
  {
    my $sp_file = SPVM::new_string("$test_dir/test_files_tmp/file_eof.txt");
    ok(SPVM::TestCase::IO::File->test_getline_eof($sp_file));
  }
  {
    my $sp_file = SPVM::new_string("$test_dir/test_files_tmp/long_line.txt");
    ok(SPVM::TestCase::IO::File->test_getline_long_line($sp_file));
  }
}

# getline and chompr
{
  {
    my $sp_file = SPVM::new_string("$test_dir/test_files_tmp/fread.txt");
    ok(SPVM::TestCase::IO::File->test_getline_chompr($sp_file));
  }
  {
    my $sp_file = SPVM::new_string("$test_dir/test_files_tmp/fread.txt");
    ok(SPVM::TestCase::IO::File->test_getline_chompr_while($sp_file));
  }
  {
    my $sp_file = SPVM::new_string("$test_dir/test_files_tmp/file_eof.txt");
    ok(SPVM::TestCase::IO::File->test_getline_chompr_eof($sp_file));
  }
  {
    my $sp_file = SPVM::new_string("$test_dir/test_files_tmp/long_line.txt");
    ok(SPVM::TestCase::IO::File->test_getline_chompr_long_line($sp_file));
  }
}

# getlines
{
  my $sp_file = SPVM::new_string("$test_dir/test_files_tmp/fread.txt");
  ok(SPVM::TestCase::IO::File->test_getlines($sp_file));
}


# All object is freed
my $end_memory_blocks_count = SPVM::get_memory_blocks_count();
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;
