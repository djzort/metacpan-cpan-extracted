use lib "t/testlib";
use TestAuto;

use strict;
use warnings;

use Test::More;

use SPVM 'TestCase::NativeAPICpp';

# Start objects count
my $start_memory_blocks_count = SPVM::get_memory_blocks_count();

{
  is(SPVM::TestCase::NativeAPICpp->call_cpp_func(2), 4);
  is(SPVM::TestCase::NativeAPICpp->call_native_func(3), 9);
}

# All object is freed
my $end_memory_blocks_count = SPVM::get_memory_blocks_count();
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;
