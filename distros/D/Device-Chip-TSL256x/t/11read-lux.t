#!/usr/bin/perl

use v5.26;
use warnings;

use Test::More;
use Test::Device::Chip::Adapter;

use Future::AsyncAwait;

use Device::Chip::TSL256x;

sub is_approx
{
   my ( $x, $y, $name ) = @_;

   my $builder = Test::More->builder;
   $builder->ok( abs( $x - $y ) < 0.01, $name ) or
      $builder->diag( "Got $x, expected approximately $y" );
}

my $chip = Device::Chip::TSL256x->new;

await $chip->mount(
   my $adapter = Test::Device::Chip::Adapter->new,
);

# ->read_lux
{
   $adapter->expect_write_then_read( "\x80", 1 )
      ->returns( "\x00" );
   $adapter->expect_write_then_read( "\x81", 1 )
      ->returns( "\x02" );
   $adapter->expect_write_then_read( "\x8C", 4 )
      ->returns( "\x00\x04\x00\x02" );

   # read_config first just to cache the GAIN/INTEG settings
   await $chip->read_config;

   is_approx( scalar await $chip->read_lux, 113.15,
      '->read_lux converts lux level' );

   $adapter->check_and_clear( '$chip->read_lux' );

   # gut-wrench to clear test data
   use Object::Pad ':experimental(mop)';
   undef Object::Pad::MOP::Class->for_class( ref $chip )->get_field( '$_TIMINGbyte' )->value( $chip );
}

# ->read_lux respects GAIN
{
   $adapter->expect_write_then_read( "\x81", 1 )
      ->returns( "\x12" );
   $adapter->expect_write_then_read( "\x8C", 4 )
      ->returns( "\x00\x40\x00\x20" );

   # read_config first just to cache the GAIN/INTEG settings
   await $chip->read_config;

   is_approx( scalar await $chip->read_lux, 113.15,
      '->read_lux converts lux level at GAIN=16' );

   $adapter->check_and_clear( '$chip->read_lux at GAIN=16' );

   # gut-wrench to clear test data
   use Object::Pad ':experimental(mop)';
   undef Object::Pad::MOP::Class->for_class( ref $chip )->get_field( '$_TIMINGbyte' )->value( $chip );
}

# ->read_lux respects INTEG
{
   $adapter->expect_write_then_read( "\x81", 1 )
      ->returns( "\x11" );
   $adapter->expect_write_then_read( "\x8C", 4 )
      ->returns( "\x00\x10\x00\x08" );

   # read_config first just to cache the GAIN/INTEG settings
   await $chip->read_config;

   is_approx( scalar await $chip->read_lux, 112.59,
      '->read_lux converts lux level at INTEG=101ms' );

   $adapter->check_and_clear( '$chip->read_lux at INTEG=101ms' );

   # gut-wrench to clear test data
   use Object::Pad ':experimental(mop)';
   undef Object::Pad::MOP::Class->for_class( ref $chip )->get_field( '$_TIMINGbyte' )->value( $chip );
}

# ->read_lux also returns DATA0/DATA1
{
   $adapter->expect_write_then_read( "\x81", 1 )
      ->returns( "\x02" );
   $adapter->expect_write_then_read( "\x8C", 4 )
      ->returns( "\x00\x04\x00\x02" );

   # read_config first just to cache the GAIN/INTEG settings
   await $chip->read_config;

   is_deeply( [ ( await $chip->read_lux )[1,2] ],
      [ 1024, 512 ],
      '->read_lux returns DATA0/DATA1 in list context' );

   $adapter->check_and_clear( '$chip->read_lux list context' );

   # gut-wrench to clear test data
   use Object::Pad ':experimental(mop)';
   undef Object::Pad::MOP::Class->for_class( ref $chip )->get_field( '$_TIMINGbyte' )->value( $chip );
}

done_testing;
